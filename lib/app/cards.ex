defmodule Cards do
  @cards [:A, 2, 3, 4, 5, 6, 7, :J, :Q, :K]
  @kinds [:CLUBS, :DIAMONDS, :HEARTS, :SPADES]

  @doc """
  All CARDS numbers from a DECK
  from A to K, excluding 8, 9, 10

  iex> Cards.cards
  [:A, 2, 3, 4, 5, 6, 7, :J, :Q, :K]
  """
  def cards,
    do: @cards

  @doc """
  All cards kinds
  CLUBS (♣), DIAMONDS (♦), HEARTS (♥) AND SPADES (♠)

  iex> Cards.kinds
  [:CLUBS, :DIAMONDS, :HEARTS, :SPADES]
  """
  def kinds,
    do: @kinds

  @doc """
  Create a DECK with all CARDS by KIND

  iex> Cards.deck |> Enum.member?(:CLUBS_A)
  true

  iex> Cards.deck |> Enum.member?(:DIAMONDS_J)
  true

  iex> Cards.deck |> Enum.member?(:HEARTS_Q)
  true

  iex> Cards.deck |> Enum.member?(:SPADES_K)
  true
  """
  def deck,
    do:
      kinds()
      |> Enum.map(&cards_kind/1)
      |> List.flatten()
      |> Enum.shuffle()

  def table,
    do:
      :empty
      |> List.duplicate(12)

  defp card_atom(kind, card) do
    "#{kind}_#{card}"
    |> String.to_atom()
  end

  defp cards_kind(kind) do
    cards()
    |> Enum.map(&card_atom(kind, &1))
  end
end
