defmodule Seraphine.ClashV1 do
  @moduledoc """
  Module for CLASH-V1 API.
  """

  @doc """
  Get the current clash registration for encrypted `summoner_id` on `region`.
  """
  def registration_by_summoner_id(region, summoner_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "clash_v1_registration_by_summoner_id",
      "https://#{region}.api.riotgames.com/lol/clash/v1/players/by-summoner/#{summoner_id}"
    )
  end

  @doc """
  Get a teams clash registration with their `team_id` on `region`.
  """
  def team_by_team_id(region, team_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "clash_v1_team_by_team_id",
      "https://#{region}.api.riotgames.com/lol/clash/v1/teams/#{team_id}"
    )
  end

  @doc """
  Get the active and upcoming clash tournaments on `region`.
  """
  def active_and_upcoming_tournaments(region) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "clash_v1_active_and_upcoming_tournaments",
      "https://#{region}.api.riotgames.com/lol/clash/v1/tournaments"
    )
  end

  @doc """
  Get a tournament a `team_id` is registered for on `region`.
  """
  def tournament_by_team_id(region, team_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "clash_v1_tournament_by_team_id",
      "https://#{region}.api.riotgames.com/lol/clash/v1/tournaments/by-team/#{team_id}"
    )
  end

  @doc """
  Get a tournament by `tournament_id` is registered for on `region`.
  """
  def tournament_by_id(region, tournament_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "clash_v1_tournament_by_id",
      "https://#{region}.api.riotgames.com/lol/clash/v1/tournaments/#{tournament_id}"
    )
  end
end
