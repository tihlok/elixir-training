defmodule LearningTest do
  use ExUnit.Case, async: true
  doctest Learning
  doctest Math

  import ExUnit.CaptureIO

  test "001 - greets the world" do
    assert Learning.hello() == :world
  end

  test "002 - greets people" do
    greeter = Learning.greet_for("Tiago", "Hi")
    assert greeter.("Tiago") == {:ok, "Hi, Tiago!"}
    assert greeter.("Morgana") == {:error, "I don't know you..."}
  end

  test "003 - & notation" do
    add_one = &(&1 + 1)
    assert add_one.(5) == 6
    assert add_one.(1) == 2
    assert add_one.(-1) == 0

    speak = &(IO.puts(&1))
    assert capture_io(fn -> speak.("HI") end) == "HI\n"

    div_rem = &{div(&1, &2), rem(&1, &2)}
    assert div_rem.(10, 5) == {2, 0}
    assert div_rem.(999, 5) == {199, 4}
  end

  test "004 - function alias" do
    count = &Enum.count/1
    assert count.([1, 2, 3]) == 3
  end

  test "005 - factorial" do
    assert App.Factorial.of(0) == 1
    assert App.Factorial.of(1) == 1
    assert App.Factorial.of(2) == 2
    assert App.Factorial.of(100) == 93326215443944152681699238856266700490715968264381621468592963895217599993229915608941463976156518286253697920827223758251185210916864000000000000000000000000
    assert App.Factorial.of(-1) == :non_positive_number
    assert App.Factorial.of(:morgana) == :not_a_number
  end

  @name "Tiago"
  test "006 - module attributes" do
    print = &("#{&1} #{@name}")
    assert @name == "Tiago"
    assert print.("hi") == "hi Tiago"
  end

  describe "007 - lists" do
    test "length" do
      assert MyList.len(:atom) == :not_a_list
      assert MyList.len([]) == 0
      assert MyList.len([:one]) == 1
      assert MyList.len([:one, :two, 3, 4, "5"]) == 5
    end

    test "square" do
      assert MyList.square([]) == []
      assert MyList.square([2]) == [4]
      assert MyList.square([2, 4, 8, 16]) == [4, 16, 64, 256]
      assert MyList.square(:none) == :not_a_list
    end

    test "map" do
      assert MyList.map([], &(&1)) == []
      assert MyList.map([1, 2, 3], &(&1)) == [1, 2, 3]
      assert MyList.map([1, 2, 3], &(&1 * 2)) == [2, 4, 6]
      assert MyList.map(:number, &(&1)) == :invalid_params
    end

    test "swap" do
      assert MyList.swap([]) == []
      assert MyList.swap([1, 2]) == [2, 1]
      assert MyList.swap([1, 2, 3, 4, 5, 6]) == [2, 1, 4, 3, 6, 5]
    end
  end
end
