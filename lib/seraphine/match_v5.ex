defmodule Seraphine.MatchV5 do
  @moduledoc """
  Module for MATCH-V5 API.
  """

  @doc """
  Get the matches played by `puuid` through `routing`.
  """
  def matches_by_puuid(routing, puuid) do
    Seraphine.API.Rest.wrapped_get(
      routing,
      "match_v5_matches_by_puuid",
      "https://#{routing}.api.riotgames.com/lol/match/v5/matches/by-puuid/#{puuid}/ids"
    )
  end

  @doc """
  Get a match by its `match_id` through `routing`.
  """
  def match_by_id(routing, match_id) do
    Seraphine.API.Rest.wrapped_get(
      routing,
      "match_v5_match_by_id",
      "https://#{routing}.api.riotgames.com/lol/match/v5/matches/#{match_id}"
    )
  end

  @doc """
  Get a match timeline by its `match_id` through `routing`.
  """
  def match_timeline_by_id(routing, match_id) do
    Seraphine.API.Rest.wrapped_get(
      routing,
      "match_v5_match_timeline_by_id",
      "https://#{routing}.api.riotgames.com/lol/match/v5/matches/#{match_id}/timeline"
    )
  end
end
