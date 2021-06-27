defmodule App.Temperature do
  @moduledoc """
  Temperature Service
  """

  @base_url Application.get_env(:leaderboard, :openweathermap_base_url)
  @app_id Application.get_env(:leaderboard, :openweathermap_app_id)

  @doc """
  Get Endpoint URL

  ## Examples
      iex> App.Temperature.endpoint "Londrina"
      "http://api.openweathermap.org/data/2.5/weather?appid=22ed41bd5f74ad29481d98452e672c6e&q=Londrina"

      iex> App.Temperature.endpoint "Rio de Janeiro"
      "http://api.openweathermap.org/data/2.5/weather?appid=22ed41bd5f74ad29481d98452e672c6e&q=Rio%20de%20Janeiro"
  """
  def endpoint(location) do
    "#{@base_url}?appid=#{@app_id}&q=#{URI.encode(location)}"
  end

  @doc """
  Convert KELVIN to CELSIUS

  ## Examples
    iex> App.Temperature.kelvin_to_celsius 296.48
    23.3

    iex> App.Temperature.kelvin_to_celsius 320
    46.9
  """
  def kelvin_to_celsius(kelvin) do
    (kelvin - 273.15)
    |> Float.round(1)
  end

  @doc """
  Get the Temperature of a Location

  Returns Location temperature in Celsius
  "[LOCATION] 9.99 °C"
  """
  def of(location) when is_list(location) do
    manager_pid = spawn(__MODULE__, :manager, [[], Enum.count(location)])

    location
    |> Enum.map(fn l ->
      pid = spawn(__MODULE__, :get_temperature, [])
      send(pid, {manager_pid, l})
    end)
  end

  def of(location) do
    result =
      location
      |> endpoint
      |> HTTPoison.get()
      |> parse

    case result do
      {:ok, temp} ->
        "[#{location}] #{temp} °C"

      :error ->
        "[#{location}] not found"
    end
  end

  def get_temperature() do
    receive do
      {pid, location} -> send(pid, {:ok, of(location)})
      _ -> IO.puts("ERROR")
    end

    get_temperature()
  end

  def manager(locations \\ [], total) do
    receive do
      {:ok, temp} ->
        results = [temp | locations]

        if(Enum.count(results) == total) do
          send(self(), :exit)
        end

        manager(results, total)

      :exit ->
        IO.puts("=============== DONE ===============")

        IO.puts(
          locations
          |> Enum.sort()
          |> Enum.join("\n")
        )

        IO.puts("====================================")

      _ ->
        manager(locations, total)
    end
  end

  defp parse({:ok, %HTTPoison.Response{body: body, status_code: 200}}),
    do:
      body
      |> JSON.decode!()
      |> temperature

  defp parse(_), do: :error

  defp temperature(json) do
    try do
      temp =
        json["main"]["temp"]
        |> kelvin_to_celsius

      {:ok, temp}
    rescue
      _ -> :error
    end
  end
end
