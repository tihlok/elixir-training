defmodule FactorialTest do
  use ExUnit.Case, async: true
  @moduletag :factorial

  doctest App.Factorial

  test "should test factorial of 1 to 10" do
    assert App.Factorial.of(0) == 1
    assert App.Factorial.of(1) == 1
    assert App.Factorial.of(2) == 1 * 2
    assert App.Factorial.of(3) == 1 * 2 * 3
    assert App.Factorial.of(4) == 1 * 2 * 3 * 4
    assert App.Factorial.of(10) == 1 * 2 * 3 * 4 * 5 * 6 * 7 * 8 * 9 * 10
  end
end
