defmodule RPGWeb.UserView do
  use RPGWeb, :view

  alias RPG.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end
end
