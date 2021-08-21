defmodule MyList do
  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)
  def len(_), do: :not_a_list

  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]
  def square(_), do: :not_a_list

  def map([], _func), do: []
  def map([head | tail], func), do: [func.(head) | map(tail, func)]
  def map(_, _), do: :invalid_params

  def swap([]), do: []
  def swap([a, b | tail]), do: [b, a | swap(tail)]
  def swap([_]), do: raise "error swapping list with odd number of elements"
end
