defmodule Seraphine.API.RiotAPIBase do
  @moduledoc false

  use HTTPoison.Base

  @ver Seraphine.MixProject.project()[:version]
  @app Seraphine.MixProject.project()[:app]

  def process_request_headers(headers) do
    [
      {"X-Riot-Token", Application.fetch_env!(@app, :riot_api_key)},
      {"User-Agent", "Seraphine v#{@ver}"} | headers
    ]
  end
end
