defmodule Learning do
  def hello do
    :world
  end

  def greet_for(name, greeting) do
    fn
      (^name) -> {:ok, "#{greeting}, #{name}!"}
      (_) -> {:error, "I don't know you..."}
    end
  end
end
