defmodule Mod do
  defmacro definfo do
    IO.puts("> In macro's context (#{__MODULE__}).")

    quote do
      IO.puts("> > In caller's context (#{__MODULE__}).")

      def friendly_info do
        IO.puts("> > > Module: #{__MODULE__}")
        IO.puts("> > > Functions: #{inspect(__MODULE__.__info__(:functions))}")
        {:ok, __MODULE__}
      end
    end
  end

  defmacro dont_bind_name(string) do
    quote do
      name = unquote(string)
    end
  end

  defmacro bind_name(string) do
    quote do
      # [var!] allows override hygiene and rebind [name] to a new value
      var!(name) = unquote(string)
    end
  end
end

defmodule MyMod do
  require Mod

  @moduledoc """
    iex> MyMod.friendly_info
    {:ok, MyMod}

    iex> name = "Tiago"
    iex> Mod.dont_bind_name("Morgana")
    iex> name
    "Tiago"

    iex> name = "Tiago"
    iex> Mod.bind_name("Morgana")
    iex> name
    "Morgana"
  """
  Mod.definfo()
end
