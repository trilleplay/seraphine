defmodule Seraphine.AccountV1 do
    @moduledoc """
    Module for ACCOUNT-V1 API.
    """
  
    @doc """
    Get the account for encrypted `puuid` through `routing`.
    """
    def account_by_puuid(routing, puuid) do
      Seraphine.API.Rest.wrapped_get(
        routing,
        "account_v1_account_by_puuid",
        "https://#{routing}.api.riotgames.com/riot/account/v1/accounts/by-puuid/#{puuid}"
      )
    end

    @doc """
    Get the account for `game_name` and `tag_line` through `routing`.
    """
    def account_by_riot_id(routing, game_name, tag_line) do
      Seraphine.API.Rest.wrapped_get(
        routing,
        "account_v1_account_by_riot_id",
        "https://#{routing}.api.riotgames.com/riot/account/v1/accounts/by-riot-id/#{game_name}/#{tag_line}"
      )
    end

    @doc """
    Get the active shard for a certain `puuid` on a certain `game` through `routing`.
    """
    def active_shard_for_game_by_puuid(routing, game, puuid) do
      Seraphine.API.Rest.wrapped_get(
        routing,
        "account_v1_active_shard_for_game_by_puuid",
        "https://#{routing}.api.riotgames.com/riot/account/v1/active-shards/by-game/#{game}/by-puuid/#{puuid}"
      )
    end
  end
  