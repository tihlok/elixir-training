defmodule ElixirSchool1EnumTest do
  use ExUnit.Case, async: true
  @moduletag :school

  @array [1, 2, 3, 4, 5, 6, 7, 8, 9]
  @mixed_array [50, 0, -9, 1000, -100, 250]
  @array_map [
    %{x: 1, y: 1},
    %{x: 1, y: 5},
    %{x: 5, y: 5},
    %{x: 5, y: 1},
    %{x: 1, y: 2},
    %{x: 2, y: 3},
    %{x: 3, y: 4},
    %{x: 4, y: 1}
  ]

  test "Enum.all" do
    assert Enum.all?(["tiago", "jaque"], fn s -> String.length(s) === 5 end) === true
    assert Enum.all?(["tiago", "jaque", "morgana"], fn s -> String.length(s) === 5 end) === false
  end

  test "Enum.chunk" do
    assert Enum.chunk_every(@array, 2) == [[1, 2], [3, 4], [5, 6], [7, 8], [9]]
    assert Enum.chunk_every(@array, 4) == [[1, 2, 3, 4], [5, 6, 7, 8], [9]]
  end

  test "Enum.map_every" do
    assert Enum.map_every(@array, 2, &(&1 * 1000)) == [1000, 2, 3000, 4, 5000, 6, 7000, 8, 9000]
    assert Enum.map_every(@array, 3, fn n -> n * 10 + n end) == [11, 2, 3, 44, 5, 6, 77, 8, 9]
  end

  test "Enum.map" do
    assert Enum.map(@array, &(&1 * -1)) == [-1, -2, -3, -4, -5, -6, -7, -8, -9]
  end

  test "Enum.min" do
    assert Enum.min(@array, fn -> :empty? end) == 1
    assert Enum.min(@mixed_array) == -100
    assert Enum.min([], fn -> :empty_fallback end) == :empty_fallback
  end

  test "Enum.max" do
    assert Enum.max(@array, fn -> :empty? end) == 9
    assert Enum.max(@mixed_array) == 1000
    assert Enum.max([], fn -> :empty_fallback end) == :empty_fallback
  end

  test "Enum.filter" do
    assert Enum.filter(@array, fn n -> n > 5 end) == [6, 7, 8, 9]
    assert Enum.filter(@array, &(rem(&1, 2) == 0)) == [2, 4, 6, 8]
  end

  test "Enum.reduce" do
    # accumulator starting at first @array element
    assert Enum.reduce(@array, fn n, accumulator -> n + accumulator end) == 45
    # accumulator starting at 0
    assert Enum.reduce(@array, 0, fn n, accumulator -> n + accumulator end) == 45
    # accumulator starting at 10
    assert Enum.reduce(@array, 10, fn n, accumulator -> n + accumulator end) == 55
    # accumulator starting at -10
    assert Enum.reduce(@array, -10, fn n, accumulator -> n + accumulator end) == 35

    # transforming into string
    reduced =
      Enum.map(@array, &"#{&1}")
      # reducing concat the actual with the next one
      |> Enum.reduce("<-last", &"#{&1} #{&2}")

    assert reduced == "9 8 7 6 5 4 3 2 1 <-last"

    # transforming into string
    reduced =
      Enum.map(@array, &"#{&1}")
      # reducing concat the actual with the next one
      |> Enum.reduce("first->", &"#{&2} #{&1}")

    assert reduced == "first-> 1 2 3 4 5 6 7 8 9"
  end

  test "Enum.sort" do
    assert Enum.sort(@array) == @array
    assert Enum.sort(@mixed_array) == [-100, -9, 0, 50, 250, 1000]
    assert Enum.sort(@mixed_array, :asc) == [-100, -9, 0, 50, 250, 1000]
    assert Enum.sort(@mixed_array, :desc) == [1000, 250, 50, 0, -9, -100]

    super_mixed_array = [:test] ++ @array ++ @mixed_array ++ [:morgana, "Jaque"]

    assert Enum.sort(super_mixed_array) == [
             -100,
             -9,
             0,
             1,
             2,
             3,
             4,
             5,
             6,
             7,
             8,
             9,
             50,
             250,
             1000,
             :morgana,
             :test,
             "Jaque"
           ]

    assert Enum.sort(@mixed_array, &(&1 > &2)) == [1000, 250, 50, 0, -9, -100]
  end

  test "Enum.uniq" do
    assert Enum.uniq([1, 2, 3, 4, 5, 1, 1, 2, 4, 6, 7, 2, 5]) == [1, 2, 3, 4, 5, 6, 7]
  end

  test "Enum.uniq_by" do
    assert Enum.uniq_by(@array_map, & &1.y) == [
             %{x: 1, y: 1},
             %{x: 1, y: 5},
             %{x: 1, y: 2},
             %{x: 2, y: 3},
             %{x: 3, y: 4}
           ]

    assert Enum.uniq_by(@array_map, fn item -> item.x end) == [
             %{x: 1, y: 1},
             %{x: 5, y: 5},
             %{x: 2, y: 3},
             %{x: 3, y: 4},
             %{x: 4, y: 1}
           ]

    filter = & &1.x

    assert Enum.uniq_by(@array_map, filter) == [
             %{x: 1, y: 1},
             %{x: 5, y: 5},
             %{x: 2, y: 3},
             %{x: 3, y: 4},
             %{x: 4, y: 1}
           ]
  end
end
