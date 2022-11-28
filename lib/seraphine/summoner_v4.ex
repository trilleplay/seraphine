defmodule Seraphine.SummonerV4 do
  @moduledoc """
  Module for SUMMONER-V4 API.
  """

  @doc """
  Get the summoner using their encrypted `account_id` on `region`.
  """
  def summoner_by_account(region, account_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "summoner_v4_summoner_by_account",
      "https://#{region}.api.riotgames.com/lol/summoner/v4/summoners/by-account/#{account_id}"
    )
  end

  @doc """
  Get summoner with `name` from `region`.
  """
  def summoner_by_name(region, name) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "summoner_v4_summoner_by_name",
      "https://#{region}.api.riotgames.com/lol/summoner/v4/summoners/by-name/#{name}"
    )
  end

  @doc """
  Get summoner with `puuid` from `region`.
  """
  def summoner_by_puuid(region, puuid) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "summoner_v4_summoner_by_puuid",
      "https://#{region}.api.riotgames.com/lol/summoner/v4/summoners/by-puuid/#{puuid}"
    )
  end

  @doc """
  Get summoner with their encrypted `summoner_id` from `region`.
  """
  def summoner_by_id(region, summoner_id) do
    Seraphine.API.Rest.wrapped_get(
      region,
      "summoner_v4_summoner_by_id",
      "https://#{region}.api.riotgames.com/lol/summoner/v4/summoners/#{summoner_id}"
    )
  end
end
