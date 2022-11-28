defmodule Seraphine.ChampionMasteryV4 do
  @moduledoc """
  Module for CHAMPION-MASTERY-V4 API.
  """

  @doc """
  Get the mastery champion entries using their encrypted `summoner_id` on `region`.
  """
  def mastery_champion_entries_by_summoner_id(region, summoner_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "champion_mastery_v4_mastery_champion_entries_by_summoner_id",
      "https://#{region}.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/#{summoner_id}"
    )
  end

  @doc """
  Get the mastery champion entry for `champion_id` using their encrypted `summoner_id` on `region`.
  """
  def mastery_for_champion_by_summoner_id(region, summoner_id, champion_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "champion_mastery_v4_mastery_for_champion_by_summoner_id",
      "https://#{region}.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/#{summoner_id}/by-champion/#{champion_id}"
    )
  end

  @doc """
  Get the top `count` amount of mastery champions using their encrypted `summoner_id` on `region`.
  `count` defaults to 3.
  """
  def top_masteries_by_summoner_id(region, summoner_id, count \\ 3) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "champion_mastery_v4_top_masteries_by_summoner_id",
      "https://#{region}.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-summoner/#{summoner_id}/top?count=#{count}"
    )
  end

  @doc """
  Get the total champion mastery score using their encrypted `summoner_id` on `region`.
  """
  def total_mastery_score_for_summoner(region, summoner_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "champion_mastery_v4_total_mastery_score_for_summoner",
      "https://#{region}.api.riotgames.com/lol/champion-mastery/v4/scores/by-summoner/#{summoner_id}"
    )
  end
end
