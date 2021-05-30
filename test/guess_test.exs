defmodule GuessTest do
  use ExUnit.Case, async: true
  @moduletag :guard

  doctest App.Guess

  @half 500
  test "should test guess" do
    alias App.Guess

    assert Guess.play(-10, 1..100) == {:not_in_range, 0, -10}
    assert Guess.play("testing", 1..100) == {:not_a_number, 0, "testing"}

    assert Guess.play(@half) == {:ok, 1, 500}
    assert Guess.play(@half, 1..1000) == {:ok, 1, @half}
    assert Guess.play(273, 1..1000) == {:ok, 7, 273}

    {status, count, number} = Guess.play(-10, 1..100)
    assert status == :not_in_range
    assert count == 0
    assert number == -10
  end
end
