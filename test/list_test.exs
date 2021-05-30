defmodule ListTest do
  use ExUnit.Case, async: true
  @moduletag :list

  doctest App.List

  test "should test lists length" do
    alias App.List

    assert List.len([]) == 0
    assert List.len([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]) == 10
  end

  test "should test lists square function" do
    assert App.List.square([]) == []
    assert App.List.square([2, 3, 5, 9, 10]) == [4, 9, 25, 81, 100]
  end

  test "should test lists add function" do
    assert App.List.add(10000, []) == []
    assert App.List.add(-1, [2, 3, 5, 9, 10]) == [1, 2, 4, 8, 9]
    assert App.List.add_1([2, 3, 5, 9, 10]) == [3, 4, 6, 10, 11]
  end

  test "should test lists map function" do
    assert App.List.map([], &(&1)) == []
    assert App.List.map([1, 2, 3], &(&1)) == [1, 2, 3]
    assert App.List.map([1, 2, 3], &(&1 - &1)) == [0, 0, 0]
    assert App.List.map([1, 2, 3], &(&1 == 2)) == [:false, :true, false]
  end

  test "should get max value" do
    assert App.List.max([]) == :none
    assert App.List.max([1]) == 1
    assert App.List.max([1, 99]) == 99
    assert App.List.max([-1, -99]) == -1
    assert App.List.max([-99]) == -99
  end
end
