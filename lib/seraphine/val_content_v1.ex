defmodule Seraphine.ValContentV1 do
    @moduledoc """
    Module for VAL-CONTENT-V1 API.
    """
  
    @doc """
    Get Valorant content, optionally with a specified locale.
    Valid locales:
    ar-AE, de-DE, en-GB, en-US, es-ES, es-MX, fr-FR, id-ID, it-IT, ja-JP, ko-KR, pl-PL, pt-BR, ru-RU, th-TH, tr-TR, vi-VN, zh-CN, zh-TW
    """
    def contents(region, locale) do
      Seraphine.API.Rest.wrapped_get(
        region,
        "val_content_v1_contents",
        "https://#{region}.api.riotgames.com/val/content/v1/contents?locale=#{locale}"
      )
    end

end
  