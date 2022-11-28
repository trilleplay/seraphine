defmodule Seraphine.API.Rest do
  @moduledoc false

  def wrapped_get(region, method, url) do
    if(
      Seraphine.API.RateLimiter.acquire_method_lock(region, method) != :ok ||
        :error in Seraphine.API.RateLimiter.acquire_application_lock(region)
    ) do
      {:error, :rate_limit_caught, nil}
    else
      {status_code, body, headers} = get(url)

      if(headers != nil) do
        Seraphine.API.RateLimiter.discover_application_limits(region, headers)
        Seraphine.API.RateLimiter.discover_method_limits(region, method, headers)
      end

      Seraphine.API.RateLimiter.release_method_lock(region, method)

      if(status_code == 429) do
        Seraphine.API.RateLimiter.handle_retry_after_headers(headers)
      end

      if(status_code != 200) do
        if(status_code == :error) do
          raise Seraphine.Api.ApiError, message: "#{body}"
        else
          raise Seraphine.Api.ApiHttpErrorCode, message: "#{status_code}"
        end
      end

      if(body == nil) do
        {:error, :request_error, nil}
      else
        {:ok, body, headers}
      end
    end
  end

  defp get(url, headers \\ []) do
    url
    |> Seraphine.API.RiotAPIBase.get(headers)
    |> case do
      {:ok, %{body: raw, status_code: code, headers: response_headers}} ->
        {code, raw, response_headers}

      {:error, %{reason: reason}} ->
        {:error, reason, nil}
    end
    |> (fn {ok, body, headers} ->
          try do
            body
            |> Poison.decode(keys: :atoms)
            |> case do
              {:ok, parsed} -> {ok, parsed, headers}
              _ -> {ok, body, headers}
            end
          rescue
            ArgumentError -> {:error, body, headers}
          end
        end).()
  end
end
