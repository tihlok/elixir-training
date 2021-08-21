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
      :non_positive_number

      iex> App.Factorial.of -9999
      :non_positive_number

      iex> App.Factorial.of :atom
      :not_a_number
  """
  def of(0), do: 1
  def of(n) when is_number(n) and n > 0, do: n * of(n - 1)
  def of(n) when is_number(n) and n < 0, do: :non_positive_number
  def of(_), do: :not_a_number
end
