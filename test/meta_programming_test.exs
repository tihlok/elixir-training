defmodule MetaPrograming do
  use ExUnit.Case, async: true
  @moduletag :meta

  doctest Math
  doctest ControlFlow
  doctest Mod
  doctest MyMod

  test "Mod/MyMod friendly_info" do
    assert MyMod.friendly_info() == {:ok, MyMod}
  end

  test "var!" do
    ast =
      quote do
        if var!(meaning_to_life) == 42 do
          "it's true"
        else
          "it remains to be seen"
        end
      end

    assert Code.eval_quoted(ast, meaning_to_life: 42) == {"it's true", [meaning_to_life: 42]}

    assert Code.eval_quoted(ast, meaning_to_life: 10) ==
             {"it remains to be seen", [meaning_to_life: 10]}
  end

  describe "bindings" do
    test "dont binding" do
      name = "Tiago"
      Mod.dont_bind_name("Morgana")
      assert name == "Tiago"
    end

    test "binding" do
      name = "Tiago"
      Mod.bind_name("Morgana")
      assert name == "Morgana"
    end
  end

  test "my_if" do
    result =
      ControlFlow.my_if 1 == 1 do
        "it is equals"
      else
        "not equals"
      end

    assert result == "it is equals"
  end

  @tag :loop
  test "while loop" do
    import ControlFlow

    run_loop = fn time ->
      pid = spawn(fn -> :timer.sleep(time) end)

      while Process.alive?(pid) do
        IO.puts("#{inspect(:erlang.time())} still alive...")
        :timer.sleep(100)
      end
    end

    run_loop.(400)
  end

  @tag :loop
  test "while loop, sending pids" do
    import ControlFlow

    pid =
      spawn(fn ->
        while true do
          receive do
            :stop ->
              IO.puts("Stopping...")
              break

            message ->
              IO.puts("Got #{inspect(message)}")
          end
        end
      end)

    assert Process.alive?(pid) == true

    send(pid, :hello)
    assert Process.alive?(pid) == true

    send(pid, :ping)
    assert Process.alive?(pid) == true

    send(pid, :stop)
    :timer.sleep(1000)
    assert Process.alive?(pid) == false
  end
end
