defmodule Cards do
  @cards [
    %{:A => 1},
    %{2 => 2},
    %{3 => 3},
    %{4 => 4},
    %{5 => 5},
    %{6 => 6},
    %{7 => 7},
    %{:J => 11},
    %{:Q => 12},
    %{:K => 13}
  ]
  @kinds [:CLUBS, :DIAMONDS, :HEARTS, :SPADES]

  @doc """
  All CARDS numbers from a DECK
  from A to K, excluding 8, 9, 10

  iex> Cards.cards
  [%{:A => 1},%{2 => 2},%{3 => 3},%{4 => 4},%{5 => 5},%{6 => 6},%{7 => 7},%{:J => 11},%{:Q => 12},%{:K => 13}]
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

  iex> Cards.deck(-1) |> Enum.member?(%{kind: :CLUBS, card: %{:A => 1}})
  true

  iex> Cards.deck(0) |> Enum.member?(%{kind: :SPADES, card: %{5 => 5}})
  true

  iex> Cards.deck |> Enum.member?(%{kind: :DIAMONDS, card: %{:K => 13}})
  true

  iex> Cards.deck(10) |> Enum.member?(%{kind: :HEARTS, card: %{:Q => 12}})
  true
  """
  def deck(shuffles \\ 1) do
    kinds()
    |> Enum.map(&cards_kind/1)
    |> List.flatten()
    |> deck(shuffles)
  end

  defp deck(deck, shuffles) when shuffles > 0, do: deck(Enum.shuffle(deck), shuffles - 1)
  defp deck(deck, _), do: deck

  @doc """
  Create a TABLE for receiving the CARDs from the DECK

  iex> Cards.table
  %{pile: [], clubs: [], diamonds: [], hearts: [], spades: [], slots: [:empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty]}
  """
  def table,
      do:
      %{
        pile: [],
        clubs: [],
        diamonds: [],
        hearts: [],
        spades: [],
        slots: :empty
               |> List.duplicate(12),
      }

  defp card_atom(kind, card) do
    %{kind: kind, card: card}
  end

  defp cards_kind(kind) do
    cards()
    |> Enum.map(&card_atom(kind, &1))
  end
end
