defmodule CardsTest do
  use ExUnit.Case, async: true

  alias Cards

  @moduletag :cards

  doctest Cards

  test "module exists" do
    assert is_list(Cards.module_info())
  end

  test "cards" do
    assert Cards.cards() == [
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
  end

  test "kinds" do
    assert Cards.kinds() == [:CLUBS, :DIAMONDS, :HEARTS, :SPADES]
  end

  test "deck" do
    deck = Cards.deck()
    assert Enum.all?(
             [
               %{
                 kind: :CLUBS,
                 card: %{
                   :A => 1
                 }
               },
               %{
                 kind: :CLUBS,
                 card: %{
                   2 => 2
                 }
               },
               %{
                 kind: :CLUBS,
                 card: %{
                   3 => 3
                 }
               },
               %{
                 kind: :CLUBS,
                 card: %{
                   4 => 4
                 }
               },
               %{
                 kind: :CLUBS,
                 card: %{
                   5 => 5
                 }
               },
               %{
                 kind: :CLUBS,
                 card: %{
                   6 => 6
                 }
               },
               %{
                 kind: :CLUBS,
                 card: %{
                   7 => 7
                 }
               },
               %{
                 kind: :CLUBS,
                 card: %{
                   :J => 11
                 }
               },
               %{
                 kind: :CLUBS,
                 card: %{
                   :Q => 12
                 }
               },
               %{
                 kind: :CLUBS,
                 card: %{
                   :K => 13
                 }
               },
               %{
                 kind: :DIAMONDS,
                 card: %{
                   :A => 1
                 }
               },
               %{
                 kind: :DIAMONDS,
                 card: %{
                   2 => 2
                 }
               },
               %{
                 kind: :DIAMONDS,
                 card: %{
                   3 => 3
                 }
               },
               %{
                 kind: :DIAMONDS,
                 card: %{
                   4 => 4
                 }
               },
               %{
                 kind: :DIAMONDS,
                 card: %{
                   5 => 5
                 }
               },
               %{
                 kind: :DIAMONDS,
                 card: %{
                   6 => 6
                 }
               },
               %{
                 kind: :DIAMONDS,
                 card: %{
                   7 => 7
                 }
               },
               %{
                 kind: :DIAMONDS,
                 card: %{
                   :J => 11
                 }
               },
               %{
                 kind: :DIAMONDS,
                 card: %{
                   :Q => 12
                 }
               },
               %{
                 kind: :DIAMONDS,
                 card: %{
                   :K => 13
                 }
               },
               %{
                 kind: :HEARTS,
                 card: %{
                   :A => 1
                 }
               },
               %{
                 kind: :HEARTS,
                 card: %{
                   2 => 2
                 }
               },
               %{
                 kind: :HEARTS,
                 card: %{
                   3 => 3
                 }
               },
               %{
                 kind: :HEARTS,
                 card: %{
                   4 => 4
                 }
               },
               %{
                 kind: :HEARTS,
                 card: %{
                   5 => 5
                 }
               },
               %{
                 kind: :HEARTS,
                 card: %{
                   6 => 6
                 }
               },
               %{
                 kind: :HEARTS,
                 card: %{
                   7 => 7
                 }
               },
               %{
                 kind: :HEARTS,
                 card: %{
                   :J => 11
                 }
               },
               %{
                 kind: :HEARTS,
                 card: %{
                   :Q => 12
                 }
               },
               %{
                 kind: :HEARTS,
                 card: %{
                   :K => 13
                 }
               },
               %{
                 kind: :SPADES,
                 card: %{
                   :A => 1
                 }
               },
               %{
                 kind: :SPADES,
                 card: %{
                   2 => 2
                 }
               },
               %{
                 kind: :SPADES,
                 card: %{
                   3 => 3
                 }
               },
               %{
                 kind: :SPADES,
                 card: %{
                   4 => 4
                 }
               },
               %{
                 kind: :SPADES,
                 card: %{
                   5 => 5
                 }
               },
               %{
                 kind: :SPADES,
                 card: %{
                   6 => 6
                 }
               },
               %{
                 kind: :SPADES,
                 card: %{
                   7 => 7
                 }
               },
               %{
                 kind: :SPADES,
                 card: %{
                   :J => 11
                 }
               },
               %{
                 kind: :SPADES,
                 card: %{
                   :Q => 12
                 }
               },
               %{
                 kind: :SPADES,
                 card: %{
                   :K => 13
                 }
               }
             ],
             fn d -> Enum.member?(deck, d) end
           ) == true
  end

  test "table" do
    assert Cards.table == %{
             pile: [],
             clubs: [],
             diamonds: [],
             hearts: [],
             spades: [],
             slots: [:empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty, :empty]
           }
  end

  test "fortune teller" do
    deck = Cards.deck()
  end
end
