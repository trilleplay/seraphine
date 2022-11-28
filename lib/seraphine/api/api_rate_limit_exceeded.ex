defmodule Seraphine.Api.ApiRateLimitExceeded do
  @moduledoc """
    The local rate limit bucket was out of sync with the one Riot Games has, or the underlying service is rate limiting you, either way the message exception contains the Retry-After data.
  """
  defexception message: "1"
end
