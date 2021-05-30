defmodule LeaderboardTest do
  use ExUnit.Case, async: true
  @moduletag :leaderboard

  doctest App.Leaderboard

  test "should get ENV" do
    assert App.Leaderboard.env == :TEST
  end
end
