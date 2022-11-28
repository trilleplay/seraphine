defmodule Seraphine.ChampionV3 do
  @moduledoc """
  Module for CHAMPION-V3 API.
  """

  @doc """
  Get the current champions in free rotation on `region`.
  """
  def champion_rotations(region) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "champion_v3_champion_rotations",
      "https://#{region}.api.riotgames.com/lol/platform/v3/champion-rotations"
    )
  end
end
