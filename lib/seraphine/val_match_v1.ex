defmodule Seraphine.ValMatchV1 do
    @moduledoc """
    Module for VAL-MATCH-V1 API.
    """

    @doc """
    Get a match by its `match_id` through `region`.
    """
    def match_by_id(region, match_id) do
      Seraphine.API.Rest.wrapped_get(
        region,
        "val_match_v1_match_by_id",
        "https://#{region}.api.riotgames.com/val/match/v1/matches/#{match_id}"
      )
    end
  
    @doc """
    Get the matches played by `puuid` through `region`.
    """
    def matchlists_by_puuid(region, puuid) do
      Seraphine.API.Rest.wrapped_get(
        region,
        "val_match_v1_matchlists_by_puuid",
        "https://#{region}.api.riotgames.com/val/match/v1/matchlists/by-puuid/#{puuid}"
      )
    end
  
  
    @doc """
    Get recent matches by `queue` through `region`.
    """
    def recent_matches_by_queue(region, queue) do
      Seraphine.API.Rest.wrapped_get(
        region,
        "val_match_v1_recent_matches_by_queue",
        "https://#{region}.api.riotgames.com/val/match/v1/recent-matches/by-queue/#{queue}"
      )
    end
  end
  