defmodule CardsTest do
  use ExUnit.Case, async: true

  alias Cards

  @moduletag :cards

  doctest Cards

  test "module exists" do
    assert is_list(Cards.module_info())
  end

  test "cards" do
    assert Cards.cards() == [:A, 2, 3, 4, 5, 6, 7, :J, :Q, :K]
  end

  test "kinds" do
    assert Cards.kinds() == [:CLUBS, :DIAMONDS, :HEARTS, :SPADES]
  end

  test "deck" do
    deck = Cards.deck()

    assert Enum.all?(
             [
               :CLUBS_A,
               :CLUBS_2,
               :CLUBS_3,
               :CLUBS_4,
               :CLUBS_5,
               :CLUBS_6,
               :CLUBS_7,
               :CLUBS_J,
               :CLUBS_Q,
               :CLUBS_K,
               :DIAMONDS_A,
               :DIAMONDS_2,
               :DIAMONDS_3,
               :DIAMONDS_4,
               :DIAMONDS_5,
               :DIAMONDS_6,
               :DIAMONDS_7,
               :DIAMONDS_J,
               :DIAMONDS_Q,
               :DIAMONDS_K,
               :HEARTS_A,
               :HEARTS_2,
               :HEARTS_3,
               :HEARTS_4,
               :HEARTS_5,
               :HEARTS_6,
               :HEARTS_7,
               :HEARTS_J,
               :HEARTS_Q,
               :HEARTS_K,
               :SPADES_A,
               :SPADES_2,
               :SPADES_3,
               :SPADES_4,
               :SPADES_5,
               :SPADES_6,
               :SPADES_7,
               :SPADES_J,
               :SPADES_Q,
               :SPADES_K
             ],
             fn d -> Enum.member?(deck, d) end
           ) == true
  end

  test "table" do
  end
end
