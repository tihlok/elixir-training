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

  iex> Cards.deck(-1) |> Enum.member?({:CLUBS, :A})
  true
  """
  def deck(shuffles \\ 1) do
    kinds()
    |> Enum.map(&cards_kind/1)
    |> List.flatten()
    |> deck(shuffles)
  end

  defp deck(deck, shuffles) when shuffles > 0,
    do: deck(Enum.shuffle(deck), shuffles - 1)

  defp deck(deck, _),
    do: deck

  @doc """
  Create a TABLE for receiving the CARDs from the DECK

  iex> Cards.table
  %{:center => [], :CLUBS => [], :DIAMONDS => [], :HEARTS => [], :SPADES => [], :sides => []}
  """
  def table,
    do: %{
      :center => [],
      :CLUBS => [],
      :DIAMONDS => [],
      :HEARTS => [],
      :SPADES => [],
      :sides => []
    }

  @doc """
  DRAW one CARD from DECK and put it on TABLE at the right place

  iex> {deck, _} = Cards.draw()
  iex> length(deck)
  39

  iex> {deck, _} = Cards.draw() |> Cards.draw() |> Cards.draw()
  iex> length(deck)
  37
  """
  def draw(),
    do: draw({deck(), table()})

  def draw({deck, table}) do
    [top | deck] = deck
    {deck, table_draw(top, table)}
  end

  defp table_draw({type, :A}, table),
    do:
      table
      |> Map.put(type, [:A])

  defp table_draw({type, card}, table) when length(table.sides) < 12 do
    sides = [{type, card} | table.sides]

    table
    |> Map.put(:sides, sides)
  end

  defp table_draw({type, card}, table) when length(table.sides) >= 12 do
    center = [{type, card} | table.center]

    table
    |> Map.put(:center, center)
  end

  defp cards_kind(kind),
    do:
      cards()
      |> Enum.map(&card_atom(kind, &1))

  defp card_atom(kind, card),
    do: {kind, card}
end
