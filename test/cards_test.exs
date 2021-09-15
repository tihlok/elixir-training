defmodule CardsTest do
  use ExUnit.Case, async: true

  alias Cards

  @moduletag :cards

  doctest Cards

  test "module exists" do
    assert is_list(Cards.module_info())
  end

  test "cards/0" do
    assert Cards.cards() == [:A, 2, 3, 4, 5, 6, 7, :J, :Q, :K]
  end

  test "kinds/0" do
    assert Cards.kinds() == [:CLUBS, :DIAMONDS, :HEARTS, :SPADES]
  end

  test "deck/1" do
    deck = Cards.deck(0)
    assert length(deck) == 40

    assert deck == [
             {:CLUBS, :A},
             {:CLUBS, 2},
             {:CLUBS, 3},
             {:CLUBS, 4},
             {:CLUBS, 5},
             {:CLUBS, 6},
             {:CLUBS, 7},
             {:CLUBS, :J},
             {:CLUBS, :Q},
             {:CLUBS, :K},
             {:DIAMONDS, :A},
             {:DIAMONDS, 2},
             {:DIAMONDS, 3},
             {:DIAMONDS, 4},
             {:DIAMONDS, 5},
             {:DIAMONDS, 6},
             {:DIAMONDS, 7},
             {:DIAMONDS, :J},
             {:DIAMONDS, :Q},
             {:DIAMONDS, :K},
             {:HEARTS, :A},
             {:HEARTS, 2},
             {:HEARTS, 3},
             {:HEARTS, 4},
             {:HEARTS, 5},
             {:HEARTS, 6},
             {:HEARTS, 7},
             {:HEARTS, :J},
             {:HEARTS, :Q},
             {:HEARTS, :K},
             {:SPADES, :A},
             {:SPADES, 2},
             {:SPADES, 3},
             {:SPADES, 4},
             {:SPADES, 5},
             {:SPADES, 6},
             {:SPADES, 7},
             {:SPADES, :J},
             {:SPADES, :Q},
             {:SPADES, :K}
           ]
  end

  test "table/0" do
    assert Cards.table() == %{
             :center => [],
             :CLUBS => [],
             :DIAMONDS => [],
             :HEARTS => [],
             :SPADES => [],
             :sides => []
           }
  end

  test "draw/2 fortune teller" do
    {deck, table} = Cards.draw()
    assert length(deck) == 39

    {deck, table} = Cards.draw({deck, table})
    assert length(deck) == 38

    {deck, table} =
      {deck, table}
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()

    assert length(deck) == 30

    {deck, table} =
      {deck, table}
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()
      |> Cards.draw()

    IO.inspect(deck)
    IO.inspect(table)

    assert deck == []
    assert length(deck) == 0

    assert Enum.member?(table[:CLUBS], :A)
    assert 1 <= length(table[:CLUBS]) >= 7
  end
end
