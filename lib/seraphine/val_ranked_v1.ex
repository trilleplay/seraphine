defmodule Seraphine.ValRankedV1 do
    @moduledoc """
    Module for VAL-RANKED-V1 API.
    """

    @doc """
    Get a ranked acts leaderboard by `act_id` through `region`.
    """
    def leaderboard_by_act(region, act_id, size \\ 200, startIndex \\ 0) do
      Seraphine.API.Rest.wrapped_get(
        region,
        "val_ranked_v1_leaderboard_by_act",
        "https://#{region}.api.riotgames.com/val/ranked/v1/leaderboards/by-act/#{act_id}?size=#{size}&startIndex=#{startIndex}"
      )
    end
  end
  