defmodule TrainingTest do
  use ExUnit.Case, async: true
  @moduletag :training

  test "lists, part 1" do
    list = [1, "2", 3.1, [4, 5], :world]
    assert list == [1, "2", 3.1, [4, 5], :world]
    [a, b, c, d, e] = list
    assert a == 1
    assert b == "2"
    assert c == 3.1
    assert d == [4, 5]
    assert e == :world

    [_, _, c, _, _] = list
    assert c == 3.1

    # reassign C value
    [c, _, _, _, _] = list
    assert c == 1

    # keeps C value
    [_, ^c, _, _] = [0, 1, 0, 0]
    assert c == 1

    # it does not create a new list with all elements
    # just create a list with ":first" and a tail of "list"
    list2 = [:first | list]
    assert list2 == [:first, 1, "2", 3.1, [4, 5], :world]
  end

  test "lists, part 2" do
    list1 = [1, 2, 3, 4]
    assert 1 in list1
    assert 2 in list1
    assert 3 in list1
    assert 4 in list1
    refute 5 in list1

    list2 = [3, 4, 5, 6]

    list_concat = list1 ++ list2
    assert list_concat == [1, 2, 3, 4, 3, 4, 5, 6]

    list_diff = list1 -- list2
    assert list_diff == [1, 2]

    list_tuples = [name: "tiago", age: 28, github: :tihlok]
    assert list_tuples == [name: "tiago", age: 28, github: :tihlok]
  end

  test "lists, part 3" do
    list = [1 | [2 | [3 | []]]]
    assert list == [1, 2, 3]

    [head | tail] = list
    assert head == 1
    assert tail == [2, 3]

    [head | tail] = tail
    assert head == 2
    assert tail == [3]

    [head | tail] = tail
    assert head == 3
    assert tail == []
  end

  test "sets" do
    set1 = 1..10 |> Enum.into MapSet.new
    assert inspect(set1) == "#MapSet<[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]>"
  end

  test "maps, part 1" do
    map = %{:name => "tiago", :age => 28}
    assert map == %{:name => "tiago", :age => 28}
    assert map.name == "tiago"
    assert map[:name] == "tiago"
    assert map.age == 28
    assert map[:age] == 28

    status = %{{:error, :enoent} => :fatal, {:error, :busy} => :retry}
    assert status[{:error, :enoent}] == :fatal
    assert status[{:error, :busy}] == :retry

    colors = %{:red => 0xff0000, :green => 0x00ff00, :blue => 0x0000ff}
    assert colors == %{blue: 255, green: 65280, red: 16711680}

    # reordered :(
    assert Map.keys(colors) == [:blue, :green, :red]
    assert Map.values(colors) == [255, 65280, 16711680]

    only_red = Map.drop colors, [:blue, :green]
    assert Map.keys(only_red) == [:red]
    assert Map.values(only_red) == [16711680]

    only_red_and_blue = Map.put only_red, :blue, 0x0000ff
    assert Map.keys(only_red_and_blue) == [:blue, :red]
    assert Map.values(only_red_and_blue) == [255, 16711680]
  end

  test "maps, part 2" do
    map = %{:name => "tiago", :age => 28}
    assert map == %{:name => "tiago", :age => 28}

    map = %{map | age: 29}
    assert map == %{:name => "tiago", :age => 29}

    map = Map.put_new(%{map | age: 30, name: "TIAGO"}, :github, "@tihlok")
    assert map == %{:name => "TIAGO", :age => 30, :github => "@tihlok"}
  end

  test "pattern matching, part 1" do
    tiago = %{name: "Tiago", nick: "@tihlok", age: 28}
    assert tiago == %{name: "Tiago", nick: "@tihlok", age: 28}

    #get name
    %{name: name} = tiago
    assert name == "Tiago"

    everybody = [
      %{name: "Tiago", age: 28},
      %{name: "Jaque", age: 29},
      %{name: "Morgana", age: 10},
      %{name: "Logan", age: 5}
    ]
    #             [       OBJECT      ] [   ARRAY  ] [CONDITION]  [RETURN]
    major_18 = for each = %{age: age} <- everybody, age >= 18, do: each
    assert major_18 == [%{age: 28, name: "Tiago"}, %{age: 29, name: "Jaque"}]
  end

  test "pattern matching, part 2" do
    data = %{player: "tihlok", score: 1000, verified: true}
    result = for key <- [:score, :verified] do
      %{^key => value} = data
      value
    end
    assert result === [1000, true]

    result2 = for key <- [:score] do
      %{^key => value} = data
      assert value === 1000
      value
    end
    assert result2 === [1000]
  end

  test "strings" do
    string1 = "common string"
    string1_capitalized = String.capitalize string1
    assert string1 == "common string"
    assert string1_capitalized == "Common string"
  end

  test "numbers" do
    decimal1 = 12345
    assert decimal1 == 12345

    decimal2 = 123_555_090
    assert decimal2 == 123555090

    floats1 = 2.9
    assert floats1 == 2.9

    floats2 = 0.0001e5
    assert floats2 == 10

    floats3 = 0.0201e-3
    assert floats3 == 2.01e-5

    hexa = 0xcafe
    assert hexa == 51966

    octa = 0o2311
    assert octa == 1225

    binary = 0b010101
    assert binary == 21

    # ERLANG functions
    assert :io.format("number: ~3.1f~n", [1.234]) == :ok
  end

  test ":atoms" do
    assert :atom == :atom
    assert :also_a_atom == :also_a_atom
    assert :is_it_a_atom? == :is_it_a_atom?
    assert :atom@2! == :atom@2!
    assert :=== == :===
    assert :<> == :<>
    assert :"this is a atom, right?" == :"this is a atom, right?"
    refute :atom@2? == :atom@2!

    assert is_atom(IO)
    assert :"Elixir.IO" == IO
  end

  test "ranges" do
    range = 1..10
    assert range == 1..10
  end

  test "regex" do
    regex = ~r{[0-9]}
    assert Regex.run(regex, "testing 1 2 3 4 done") == ["1"]
    assert Regex.scan(regex, "testing 1 2 3 4 done") == [["1"], ["2"], ["3"], ["4"]]
    assert Regex.split(regex, "testing 1 2 3 4 done") == ["testing ", " ", " ", " ", " done"]
    assert Regex.replace(regex, "testing 1 2 3 4 done", "#") == "testing # # # # done"
  end

  test "{tuples}" do
    {status, action, value} = {:ok, "skip", 120}
    assert status == :ok
    assert action == "skip"
    assert value == 120

    {status, _} = File.open "README.md"
    assert status == :ok

    {status, file} = File.open "NO EXISTING FILE"
    assert status == :error
    assert file == :enoent
  end

  test "binaries" do
    bin = <<1, 2, 3>>
    assert bin == <<1, 2, 3>>
    assert byte_size(bin) == 3
  end

  test "dates" do
    date = Date.new(2021, 06, 03)
    assert date == {:ok, ~D[2021-06-03]}

    {:ok, date} = Date.new(2021, 06, 04)
    assert date == ~D[2021-06-04]

    date = ~D[2021-06-05]
    assert date == ~D[2021-06-05]

    assert Date.day_of_week(date) == 6
    assert Date.add(date, 10) == ~D[2021-06-15]

    range = Date.range ~D[2021-06-01], ~D[2021-06-10]
    assert ~D[2021-06-09] in range
    refute ~D[2021-07-01] in range
  end

  test "back block" do
    atom = case 1 do
      1 -> :one
      2 -> :two
    end
    assert atom == :one
  end

  test "with" do
    nobody = with {:ok, file} = File.open("test.do.not.delete"),
                  content = IO.read(file, :all),
                  :ok = File.close(file),
                  [_, uid, gid] <- Regex.run(~r{nobody:.*?:([-0-9]+):([-0-9]+):}, content),
                  do: "nobody: uid: #{uid}, gid: #{gid}"
    assert nobody == "nobody: uid: -2, gid: -2"

    it_is_nil = with {:ok, file} = File.open("test.do.not.delete"),
                     content = IO.read(file, :all),
                     :ok = File.close(file),
                     [_, uid, gid] <- Regex.run(~r{xxxxx:.*?:([-0-9]+):([-0-9]+):}, content),
                     do: "xxxxx: uid: #{uid}, gid: #{gid}"
    assert it_is_nil == :nil
  end

  test "anonymous functions" do
    sum = fn a, b -> a + b end
    assert sum.(4, 5) == 9

    print_sum = fn name, func, a, b -> "Hello #{name}, the sum is #{func.(a, b)}" end
    assert print_sum.("Tiago", sum, 2, 3) == "Hello Tiago, the sum is 5"

    sum2 = &(&1 + &2)
    assert sum2.(1, 5) == 6

    greet = &"Hello #{&1}"
    assert greet.("Tiago") == "Hello Tiago"

    count = &Enum.count/1
    assert count.([1, 2, 3, 4]) == 4
  end

  test "multiple bodies" do
    handle_open = fn
      {:ok, file} -> "Read data: #{IO.read(file, :line)}"
      {_, error} -> "Error: #{:file.format_error(error)}"
    end

    assert handle_open.(File.open("test.do.not.delete")) == "Read data: # PASSWORDs\n"
    assert handle_open.(File.open("file.not.exists")) == "Error: no such file or directory"

    password = fn (password) ->
      fn
        (^password) -> :OPEN
        (_) -> :LOCKED
      end
    end

    locker = password.("12345")
    assert locker.("12345") == :OPEN
    assert locker.("not a pass") == :LOCKED

    locker2 = password.(:atom_pass)
    assert locker2.(:atom_pass) == :OPEN
    refute locker2.(:wrong_pass) == :OPEN
  end

  test "structs" do
    tiago = %App.Structs{name: "Tiago", age: 28}
    assert tiago == %App.Structs{age: 28, github: :none, name: "Tiago"}
    assert tiago.name == "Tiago"
    assert tiago.age == 28
    assert tiago.github == :none

    %App.Structs{name: tiago_name} = tiago
    assert tiago_name == "Tiago"

    none = %App.Structs{}
    assert none == %App.Structs{age: 0, github: :none, name: ""}
    none = %App.Structs{none | name: "NONE :)"}
    assert none.name == "NONE :)"

    assert App.Structs.has_github(tiago) == false
    assert App.Structs.has_github(none) == false

    tiago = %App.Structs{tiago | github: :tihlok}
    assert App.Structs.has_github(tiago) == true

    inner = %App.Structs.Inner{is_ok: false}
    assert inner == %App.Structs.Inner{is_ok: false}

    tiago = %App.Structs{tiago | inner: inner}
    assert tiago == %App.Structs{
             age: 28,
             github: :tihlok,
             name: "Tiago",
             inner: %App.Structs.Inner{
               is_ok: false
             }
           }

    devs = [
      %{name: "Tiago", languages: [:elixir, :java, :js]},
      %{name: "Morgana", languages: [:miau]}
    ]
    elixir_devs = fn (:get, collection, next) ->
      for row <- collection do
        if :elixir in row.languages do
          next.(row)
        end
      end
    end

    assert get_in(devs, [Access.all(), :name]) == ["Tiago", "Morgana"]
    assert get_in(devs, [Access.all(), :languages]) == [[:elixir, :java, :js], [:miau]]
    assert get_in(devs, [Access.at(0), :languages]) == [:elixir, :java, :js]
    assert get_in(devs, [Access.at(1), :languages]) == [:miau]
    assert get_in(devs, [elixir_devs, :name]) == ["Tiago", nil]

    to_upcase = fn val -> {val, String.upcase(val)} end
    {_, upcased} = get_and_update_in(devs, [Access.all(), :name], to_upcase)
    assert get_in(upcased, [Access.all(), :name]) == ["TIAGO", "MORGANA"]
  end
end
