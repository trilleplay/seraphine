defmodule Seraphine.LolChallengesV1 do
  @moduledoc """
  Module for LOL-CHALLENGES-V1 API.
  """

  @doc """
  List of all basic challenge configuration information for a given `region`
  """
  def challenges_configuration(region) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "lol_challenges_v1_challenger_configuration",
      "https://#{region}.api.riotgames.com/lol/challenges/v1/challenges/config"
    )
  end

  @doc """
  List of all percentiles of players who've achieved challenges on `region`.
  """
  def challenges_percentile_completed(region) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "lol_challenges_v1_challenges_percentile_completed",
      "https://#{region}.api.riotgames.com/lol/challenges/v1/challenges/percentiles"
    )
  end

  @doc """
  Basic challenge configuration information for a given `challenge_id` on `region`
  """
  def configuration_for_challenge(region, challenge_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "lol_challenges_v1_configuration_for_challenge",
      "https://#{region}.api.riotgames.com/lol/challenges/v1/challenges/#{challenge_id}/config"
    )
  end

  @doc """
  Returns the top players for a given `challenge_id` in a certain `level` on `region`.
  """
  def top_players_by_level(region, challenge_id, level) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "lol_challenges_v1_top_players_by_level",
      "https://#{region}.api.riotgames.com/lol/challenges/v1/challenges/#{challenge_id}/leaderboards/by-level/#{level}"
    )
  end

  @doc """
  Percentiles for a certain `challenge_id` of players who's completed the given challenge on `region`.
  """
  def percentile_completed_for_challenge(region, challenge_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "lol_challenges_v1_percentile_completed_for_challenge",
      "https://#{region}.api.riotgames.com/lol/challenges/v1/challenges/#{challenge_id}/percentiles"
    )
  end

  @doc """
  Challenges progression for a certain `puuid` on `region`.
  """
  def progressed_challenges_by_puuid(region, puuid) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "lol_challenges_v1_progressed_challenges_by_puuid",
      "https://#{region}.api.riotgames.com/lol/challenges/v1/player-data/#{puuid}"
    )
  end
end
