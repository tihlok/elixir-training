defmodule App.Guard do
  @moduledoc """
  Guard Service
  """

  @doc """
  ## Examples
      iex> App.Guard.what_is 0
      :number

      iex> App.Guard.what_is 9123
      :number

      iex> App.Guard.what_is -123
      :number

      iex> App.Guard.what_is []
      :list

      iex> App.Guard.what_is [1]
      :list

      iex> App.Guard.what_is [:item1, 2, "3"]
      :list

      iex> App.Guard.what_is :atom
      :atom

      iex> App.Guard.what_is :another_atom
      :atom

      iex> App.Guard.what_is "string"
      :unknown

      iex> App.Guard.what_is %{:map => []}
      :unknown
  """
  def what_is(x) when is_number(x) do
    :number
  end

  def what_is(x) when is_list(x) do
    :list
  end

  def what_is(x) when is_atom(x) do
    :atom
  end

  def what_is(_) do
    :unknown
  end

  @doc """
  ## Examples
      iex> App.Guard.list 1, 2
      [1, :none, :none, 2]

      iex> App.Guard.list 1, 2, 3
      [1, 2, :none, 3]

      iex> App.Guard.list 1, 2, 3, 4
      [1, 2, 3, 4]
  """
  def list(a, b \\ :none, c \\ :none, d) do
    [a, b, c, d]
  end
end
