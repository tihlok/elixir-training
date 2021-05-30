defmodule GuardTest do
  use ExUnit.Case, async: true
  @moduletag :guard

  doctest App.Guard

  test "should test guard" do
    assert App.Guard.what_is(1) == :number
    assert App.Guard.what_is(0.9) == :number
    assert App.Guard.what_is(0xcafe) == :number
    assert App.Guard.what_is([1, :coffe, "cats", %{:empty => "map"}]) == :list
    assert App.Guard.what_is(:hey_yo) == :atom
    assert App.Guard.what_is("this is a string") == :unknown
    assert App.Guard.what_is(%{:empty => "map"}) == :unknown
  end

  test "default args" do
    assert App.Guard.list(1, 2) == [1, :none, :none, 2]
    assert App.Guard.list(1, 2, 3) == [1, 2, :none, 3]
    assert App.Guard.list(1, 2, 3, 4) == [1, 2, 3, 4]
    refute App.Guard.list(1, 2) == [1, 2, :none, :none]
    refute App.Guard.list(1, 2) == [1, 2]
  end
end
