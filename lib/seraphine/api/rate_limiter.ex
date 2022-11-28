defmodule Seraphine.API.RateLimiter do
  @moduledoc false

  @riot_regions [
    "br1",
    "eun1",
    "euw1",
    "jp1",
    "kr",
    "la1",
    "la2",
    "na1",
    "oc1",
    "tr1",
    "ru",
    "americas",
    "asia",
    "europe",
    "sea"
  ]

  def handle_retry_after_headers(headers) do
    retry_after_header =
      Enum.at(
        Enum.filter(headers, fn
          {key, _} -> String.match?(key, ~r/Retry-After/)
        end),
        0
      )

    if(retry_after_header != nil && tuple_size(retry_after_header) != 0) do
      raise Seraphine.Api.ApiRateLimitExceeded, message: elem(retry_after_header, 0)
    else
      raise Seraphine.Api.ApiRateLimitExceeded
    end
  end

  defp get_rate_limit_token(region, method) do
    # I don't want to let someone send garbage into the region field and be able to create infinite atoms, that's why the region is checked since atoms are dynamically created for regions on-demand.
    if region not in @riot_regions do
      raise Seraphine.Api.ApiError, message: "#{region} - is not a valid region."
    end

    # Prefixing with seraphine_ because I don't want other end-users usage of the library to collide with the dependancies of this library.
    String.to_atom("seraphine_#{region}_#{method}")
  end

  def release_application_lock(region) do
    stored_limits = FastGlobal.get(get_rate_limit_token(region, "limits"))

    if(stored_limits != nil) do
      for n <- 0..(map_size(stored_limits) - 1) do
        Task.async(fn ->
          Process.sleep(Enum.fetch!(Map.keys(stored_limits), n) * 1000)
          Semaphore.release(get_rate_limit_token(region, n))
        end)
      end
    end
  end

  def release_method_lock(region, method) do
    rate_limit_token = get_rate_limit_token(region, method)
    stored_limits = FastGlobal.get(rate_limit_token)

    if(stored_limits != nil) do
      Task.async(fn ->
        Process.sleep(Enum.fetch!(Map.keys(stored_limits), 0) * 1000)
        Semaphore.release(rate_limit_token)
      end)
    end

    release_application_lock(region)
  end

  def acquire_application_lock(region) do
    stored_limits = FastGlobal.get(get_rate_limit_token(region, "limits"))

    if(stored_limits != nil) do
      for n <- 0..(map_size(stored_limits) - 1) do
        particular_key = Enum.fetch!(Map.keys(stored_limits), n)

        if Semaphore.acquire(
             get_rate_limit_token(region, n),
             Map.get(stored_limits, particular_key, 10)
           ) do
          :ok
        else
          :error
        end
      end
    else
      [:ok, :ok]
    end
  end

  def acquire_method_lock(region, method) do
    rate_limit_token = get_rate_limit_token(region, method)
    stored_limits = FastGlobal.get(rate_limit_token)

    if(stored_limits == nil) do
      :ok
    else
      particular_key = Enum.fetch!(Map.keys(stored_limits), 0)

      if Semaphore.acquire(rate_limit_token, Map.get(stored_limits, particular_key, 10)) do
        :ok
      else
        :error
      end
    end
  end

  defp rate_limit_details_to_map(header) do
    formatted_header = String.split(header, ",")

    Enum.reduce(formatted_header, %{}, fn x, d ->
      parsed_limit = String.split(x, ":")

      Map.put(
        d,
        String.to_integer(Enum.at(parsed_limit, 1)),
        String.to_integer(Enum.at(parsed_limit, 0))
      )
    end)
  end

  def discover_method_limits(region, method, response_headers) do
    rate_limit_token = get_rate_limit_token(region, method)

    if(FastGlobal.get(rate_limit_token) == nil && response_headers != nil) do
      # Store the limits for the method.
      method_rate_limit_header =
        Enum.at(
          Enum.filter(response_headers, fn
            {key, _} -> String.match?(key, ~r/X-Method-Rate-Limit/)
          end),
          0
        )

      if(method_rate_limit_header != nil && tuple_size(method_rate_limit_header) != 0) do
        parsed_data = rate_limit_details_to_map(elem(method_rate_limit_header, 1))
        FastGlobal.put(rate_limit_token, parsed_data)
      end

      # Do the first acquire to allocate the semaphore
      Semaphore.acquire(rate_limit_token, 1)

      # Now reset it to the cap we've gathered from the API already
      method_rate_limit_count_header =
        Enum.at(
          Enum.filter(response_headers, fn
            {key, _} -> String.match?(key, ~r/X-Method-Rate-Limit-Count/)
          end),
          0
        )

      if(
        method_rate_limit_count_header != nil && tuple_size(method_rate_limit_count_header) != 0
      ) do
        parsed_limit = String.split(elem(method_rate_limit_count_header, 1), ":")
        executed_requests = String.to_integer(Enum.at(parsed_limit, 0))
        Semaphore.reset(rate_limit_token, executed_requests)
        # Schedule the locks for cleanup
        for _ <- 1..executed_requests do
          release_method_lock(region, method)
        end
      end
    end
  end

  def discover_application_limits(region, response_headers) do
    rate_limit_data = get_rate_limit_token(region, "limits")

    if(FastGlobal.get(rate_limit_data) == nil) do
      app_rate_limit_header =
        Enum.at(
          Enum.filter(response_headers, fn
            {key, _} -> String.match?(key, ~r/X-App-Rate-Limit/)
          end),
          0
        )

      app_rate_limit_count_header =
        Enum.at(
          Enum.filter(response_headers, fn
            {key, _} -> String.match?(key, ~r/X-App-Rate-Limit-Count/)
          end),
          0
        )

      if(app_rate_limit_header != nil && tuple_size(app_rate_limit_header) != 0) do
        formatted_header = rate_limit_details_to_map(elem(app_rate_limit_header, 1))
        FastGlobal.put(rate_limit_data, formatted_header)

        app_rate_limit_count_header =
          rate_limit_details_to_map(elem(app_rate_limit_count_header, 1))

        for n <- 0..(map_size(formatted_header) - 1) do
          key = get_rate_limit_token(region, n)
          # Allocate the semaphore
          Semaphore.acquire(key, 1)
          # Now reset it to the cap we've gathered from the API already
          particular_key = Enum.fetch!(Map.keys(app_rate_limit_count_header), n)
          executed_requests = Map.get(app_rate_limit_count_header, particular_key, 0)
          Semaphore.reset(key, executed_requests)
          # Schedule the locks for cleanup.
          for _ <- 1..executed_requests do
            Task.async(fn ->
              Process.sleep(particular_key * 1000)
              Semaphore.release(key)
            end)
          end
        end
      end
    end
  end
end
