defmodule Seraphine.LolStatusV4 do
  @moduledoc """
  Module for LOL-STATUS-V4 API.
  """

  @doc """
  Get platform status of the `region`.
  """
  def league_status_for_platform(region) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "lol_status_v4_league_status_for_platform",
      "https://#{region}.api.riotgames.com/lol/status/v4/platform-data"
    )
  end
end
