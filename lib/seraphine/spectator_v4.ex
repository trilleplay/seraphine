defmodule Seraphine.SpectatorV4 do
  @moduledoc """
  Module for SPECTATOR-V4 API.
  """

  @doc """
  Get the current match being played by `summoner_id` on `region`.
  """
  def active_games_by_summoner(region, summoner_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "spectator_v4_active_games_by_summoner",
      "https://#{region}.api.riotgames.com/lol/spectator/v4/active-games/by-summoner/#{summoner_id}"
    )
  end

  @doc """
  Return a list of featured games on `region`
  """
  def featured_games(region) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "spectator_v4_featured_games",
      "https://#{region}.api.riotgames.com/lol/spectator/v4/featured-games"
    )
  end
end
