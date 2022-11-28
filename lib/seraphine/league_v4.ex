defmodule Seraphine.LeagueV4 do
  @moduledoc """
  Module for LEAGUE-V4 API.
  """

  @doc """
  Get the challenger league for a specific `queue` on `region`.
  """
  def challenger_league_for_queue(region, queue) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "league_v4_challenger_league_for_queue",
      "https://#{region}.api.riotgames.com/lol/league/v4/challengerleagues/by-queue/#{queue}"
    )
  end

  @doc """
  Get the league entries for all queues for a given `summoner_id` on `region`.
  """
  def league_entries_by_summoner(region, summoner_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "league_v4_league_entries_by_summoner",
      "https://#{region}.api.riotgames.com/lol/league/v4/entries/by-summoner/#{summoner_id}"
    )
  end

  @doc """
  Get the league entries for a given `queue` on `region`, with `tier` and `division`.
  """
  def league_entries_by_queue(region, queue, tier, division) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "league_v4_league_entries_by_queue",
      "https://#{region}.api.riotgames.com/lol/league/v4/entries/#{queue}/#{tier}/#{division}"
    )
  end

  @doc """
  Get the grandmaster league for a specific `queue` on `region`.
  """
  def grandmaster_league_for_queue(region, queue) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "league_v4_grandmaster_league_for_queue",
      "https://#{region}.api.riotgames.com/lol/league/v4/grandmasterleagues/by-queue/#{queue}"
    )
  end

  @doc """
  Get a league by its `league_id` on `region`.
  """
  def league_by_id(region, league_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "league_v4_league_by_id",
      "https://#{region}.api.riotgames.com/lol/league/v4/leagues/#{league_id}"
    )
  end

  @doc """
  Get the master league for a specific `queue` on `region`.
  """
  def master_league_for_queue(region, queue) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "league_v4_grandmaster_league_for_queue",
      "https://#{region}.api.riotgames.com/lol/league/v4/masterleagues/by-queue/#{queue}"
    )
  end
end
