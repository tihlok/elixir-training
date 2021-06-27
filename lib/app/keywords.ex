defmodule App.Keywords do
  @moduledoc """
  Keywords Service
  """

  @doc """
  Merge two keywords
  ## Examples
      iex> App.Keywords.merge [], []
      []
  """
  def merge(keywords, options) do
    Keyword.merge(keywords, options)
  end

  @doc """
  Get JOB level
  ## Examples
      iex> App.Keywords.job_level %{name: "Test", years_of_experience: 0}
      "Test is TRAINEE"

      iex> App.Keywords.job_level %{name: "Test", years_of_experience: 1}
      "Test is TRAINEE"

      iex> App.Keywords.job_level %{name: "Test", years_of_experience: 2}
      "Test is JUNIOR"

      iex> App.Keywords.job_level %{name: "Test", years_of_experience: 4}
      "Test is JUNIOR"

      iex> App.Keywords.job_level %{name: "Test", years_of_experience: 5}
      "Test is MID"

      iex> App.Keywords.job_level %{name: "Test", years_of_experience: 9}
      "Test is MID"

      iex> App.Keywords.job_level %{name: "Test", years_of_experience: 10}
      "Test is SENIOR"

      iex> App.Keywords.job_level %{name: "Test", years_of_experience: 100}
      "Test is probably dead :("
  """
  def job_level(%{name: name, years_of_experience: years})
      when years >= 100 do
    "#{name} is probably dead :("
  end

  def job_level(%{name: name, years_of_experience: years})
      when years >= 10 do
    "#{name} is SENIOR"
  end

  def job_level(%{name: name, years_of_experience: years})
      when years >= 5 do
    "#{name} is MID"
  end

  def job_level(%{name: name, years_of_experience: years})
      when years >= 2 do
    "#{name} is JUNIOR"
  end

  def job_level(%{name: name, years_of_experience: _}) do
    "#{name} is TRAINEE"
  end
end
