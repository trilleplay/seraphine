defmodule Seraphine.ValStatusV1 do
    @moduledoc """
    Module for VAL-STATUS-V1 API.
    """

    @doc """
    Get the current platform status for Valorant.
    """
    def platform_status(region) do
      Seraphine.API.Rest.wrapped_get(
        region,
        "val_status_v1_platform_status",
        "https://#{region}.api.riotgames.com/val/status/v1/platform-data"
      )
    end
  end