defmodule App.Structs.Inner do
  defstruct is_ok: true
end

defmodule App.Structs do
  defstruct name: "", age: 0, github: :none, inner: %App.Structs.Inner{}

  def has_github(%App.Structs{github: github}) when github == :none, do: false
  def has_github(%App.Structs{github: _}), do: true
end
