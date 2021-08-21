defmodule Math do
  @moduledoc """
    iex> Math.say 5 + 2
    "5 plus 2 is 7"

    iex> Math.say 11 + 9
    "11 plus 9 is 20"

    iex> Math.say 5 * 2
    "5 times 2 is 10"
  """
  defmacro say({:+, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      "#{lhs} plus #{rhs} is #{lhs + rhs}"
    end
  end

  defmacro say({:*, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      "#{lhs} times #{rhs} is #{lhs * rhs}"
    end
  end
end
