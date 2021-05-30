defmodule App.Leaderboard do
  @moduledoc """
  Leaderboard Service
  """

  @env Application.get_env(:leaderboard, :env)

  @doc """
  Get ENVIRONMENT

  ## Examples
      iex> App.Leaderboard.env
      :TEST
  """
  def env do
    @env
  end
end
