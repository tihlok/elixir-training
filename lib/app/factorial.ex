defmodule App.Factorial do
  @moduledoc """
  Factorial Service
  """

  @doc """
  Factorial of ZERO

  ## Examples
      iex> App.Factorial.of 0
      1

      iex> App.Factorial.of 3
      6

      iex> App.Factorial.of 10
      3628800

      iex> App.Factorial.of -1
      :error

      iex> App.Factorial.of -9999
      :error

      iex> App.Factorial.of :atom
      :error
  """
  def of(n) when is_integer(n) and n > 0 do
    n * of(n - 1)
  end

  #def of(0) do
  def of(n) when is_integer(n) and n === 0 do
    1
  end

  def of(n) do
    :error
  end
end
