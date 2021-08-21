defmodule ControlFlow do
  @moduledoc """
    iex> ControlFlow.unless 2 == 5, do: "block entered"
    "block entered"

    iex> ControlFlow.unless 5 == 5, do: "block entered"
    nil
  """
  defmacro unless(expression, do: block) do
    quote do
      if !unquote(expression), do: unquote(block)
    end
  end
end
