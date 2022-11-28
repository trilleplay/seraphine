defmodule Seraphine.Api.ApiError do
  @moduledoc """
    An unknown error has occurred.
  """
  defexception message: "Unknown error, probably communication related/timeout related."
end
