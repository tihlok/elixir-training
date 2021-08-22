defmodule ControlFlow do
  @doc """
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

  @doc """
    iex> ControlFlow.my_if 2 == 5, do: "correct", else: "incorrect"
    "incorrect"

    iex> ControlFlow.my_if 5 == 5, do: "correct", else: "incorrect"
    "correct"
  """
  defmacro my_if(exppression, do: if_block), do: if(exppression, do: if_block, else: nil)

  defmacro my_if(exppression, do: if_block, else: else_block) do
    quote do
      case unquote(exppression) do
        result when result in [false, nil] -> unquote(else_block)
        _ -> unquote(if_block)
      end
    end
  end

  defmacro while(expression, do: block) do
    quote do
      try do
        for _ <- ControlFlow.infinite() do
          if unquote(expression) do
            unquote(block)
          else
            ControlFlow.break()
          end
        end
      catch
        :break -> :ok
      end
    end
  end

  def break, do: throw(:break)
  def infinite, do: Stream.cycle([:ok])
end
