defmodule App.Guess do
  @moduledoc """
  Guess Service
  """

  @doc """
  ## Examples
      iex> App.Guess.play 500
      {:ok, 1, 500}

      iex> App.Guess.play 500, 1..1000
      {:ok, 1, 500}

      iex> App.Guess.play 250, 1..1000
      {:ok, 2, 250}

      iex> App.Guess.play 273, 1..1000
      {:ok, 7, 273}

      iex> App.Guess.play 1500, 1..1000
      {:not_in_range, 0, 1500}

      iex> App.Guess.play -1, 1..1000
      {:not_in_range, 0, -1}

      iex> App.Guess.play "my string", 1..1000
      {:not_a_number, 0, "my string"}

      iex> App.Guess.play :atom_whatever, 1..1000
      {:not_a_number, 0, :atom_whatever}
  """
  def play(number, first..last) when is_number(number) and (number < first or number > last) do
    {:not_in_range, 0, number}
  end

  def play(number, range \\ 1..1000) when is_number(number) do
    first..last = range
    play_guess(number, range, 1, div(last, 2))
  end

  def play(wrong, _) do
    {:not_a_number, 0, wrong}
  end

  defp play_guess(number, first..last, count, guess) when number === guess do
    {:ok, count, number}
  end

  defp play_guess(number, first..last, count, guess) when guess > number do
    new_guess =
      (first + guess)
      |> div(2)

    play_guess(number, first..guess, count + 1, new_guess)
  end

  defp play_guess(number, first..last, count, guess) when guess < number do
    new_guess =
      (guess + last)
      |> div(2)

    play_guess(number, guess..last, count + 1, new_guess)
  end
end
