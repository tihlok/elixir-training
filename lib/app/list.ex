defmodule App.List do
  @moduledoc """
  List Service
  """

  @doc """
  Get LIST length
  ## Examples
      iex> App.List.len []
      0

      iex> App.List.len [:item1]
      1

      iex> App.List.len [:item1, 2]
      2

      iex> App.List.len [:item1, 2, 3, "4", [], %{}]
      6
  """
  def len([]) do
    0
  end

  def len([_ | tail]) do
    1 + len(tail)
  end

  @doc """
  Get square for each list item
  ## Examples
      iex> App.List.square []
      []

      iex> App.List.square [1]
      [1]

      iex> App.List.square [1, 2, 10]
      [1, 4, 100]

      iex> App.List.square [10, 5]
      [100, 25]

      iex> App.List.square [10, 5, 1023, 9999, 5.5]
      [100, 25, 1046529, 99980001, 30.25]
  """
  def square([]) do
    []
  end

  def square([head | tail]) do
    [head * head | square(tail)]
  end

  @doc """
  Add number for each list item
  ## Examples
      iex> App.List.add 0, []
      []

      iex> App.List.add 1, []
      []

      iex> App.List.add 1, [0, 1, 9]
      [1, 2, 10]

      iex> App.List.add 999, [0, 1, 9]
      [999, 1000, 1008]
  """
  def add(_n, []) do
    []
  end

  def add(n, [head | tail]) do
    [head + n | add(n, tail)]
  end

  @doc """
  Add +1 for each list item
  ## Examples
      iex> App.List.add_1 []
      []

      iex> App.List.add_1 [0, 1, 9]
      [1, 2, 10]
  """
  def add_1(list), do: add(1, list)

  @doc """
  Execute function for each list element
  ## Examples
      iex> App.List.map [], &(&1 * 10)
      []

      iex> App.List.map [5, 9], &(&1 * 10)
      [50, 90]
  """
  def map([], _function) do
    []
  end

  def map([head | tail], function) do
    [function.(head) | map(tail, function)]
  end

  @doc """
  Reduce
  ## Examples
      iex> App.List.reduce [], 0, &(&1 * &2)
      0

      iex> App.List.reduce []
      0

      iex> App.List.reduce [1, 2, 3]
      6

      iex> App.List.reduce [1, 2, 3, 10, 100, 1500]
      9000000
  """
  def reduce([], value \\ 0, _function \\ &(&1 * &2)) do
    value
  end

  def reduce([head | tail], value, function) do
    value = case value do
      0 -> 1
      _ -> value
    end
    reduce(tail, function.(head, value), function)
  end

  @doc """
  Max number in list
  ## Examples
      iex> App.List.max []
      :none

      iex> App.List.max [1, 0, 10]
      10

      iex> App.List.max [-10, 0, -1]
      0

      iex> App.List.max [-10, -1]
      -1

      iex> App.List.max [-10, 0, 99]
      99
  """
  def max([]) do
    :none
  end

  def max([head | tail]) do
    max_numbers(tail, head)
  end

  defp max_numbers([], highest) do
    highest
  end

  defp max_numbers([head | tail], highest) when head <= highest do
    max_numbers(tail, highest)
  end

  defp max_numbers([head | tail], highest) when head > highest do
    max_numbers(tail, head)
  end
end
