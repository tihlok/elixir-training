defmodule KeywordsTest do
  use ExUnit.Case, async: true
  @moduletag :keywords

  doctest App.Keywords

  @default [name: "Tiago", age: 28]
  @optional [nick: :tihlok]
  test "should test keywords merge" do
    merged = App.Keywords.merge(@default, @optional)
    assert merged == [{:name, "Tiago"}, {:age, 28}, {:nick, :tihlok}]
    assert Keyword.get(merged, :name) == "Tiago"
    assert Keyword.get(merged, :age) == 28
    assert Keyword.get(merged, :nick) == :tihlok

    assert Keyword.get(merged, :github, "https://github.com/tihlok") ==
             "https://github.com/tihlok"
  end
end
