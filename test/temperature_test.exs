defmodule TemperatureTest do
  use ExUnit.Case, async: true
  @moduletag :temperature

  doctest App.Temperature

  test "should return a encoded endpoint when take a location" do
    endpoint = App.Temperature.endpoint "Londrina"
    assert endpoint == "http://api.openweathermap.org/data/2.5/weather?appid=22ed41bd5f74ad29481d98452e672c6e&q=Londrina"
  end

  test "should convert Kelvin to Celsius" do
    temperature = App.Temperature.kelvin_to_celsius 296.48
    assert temperature == 23.3
  end

  @tag :net
  test "should get temperature when is a valid location" do
    temperature = App.Temperature.of "Londrina"
    assert String.contains?(temperature, "Londrina") == true
  end

  @tag :net
  test "should get temperature of multiple cities, sync" do
    cities = ["Londrina", "Maringá", "Rio de Janeiro", "Cuiabá", "São Paulo"]
    temperatures = cities
                   |> Enum.map(&(App.Temperature.of(&1)))
                   |> Enum.join("\n")
    IO.puts temperatures
    assert String.contains?(temperatures, "Londrina") == true
    assert String.contains?(temperatures, "Maringá") == true
    assert String.contains?(temperatures, "Rio de Janeiro") == true
    assert String.contains?(temperatures, "Cuiabá") == true
    assert String.contains?(temperatures, "São Paulo") == true
  end

  @tag :net
  test "should get temperature of multiple cities, parallel" do
    cities = ["Londrina", "Maringá", "Rio de Janeiro", "Cuiabá", "São Paulo"]
    App.Temperature.of cities
  end

  @tag :net
  test "should not get temperature when is a invalid location" do
    temperature = App.Temperature.of "Not A Valid Place"
    assert temperature == "[Not A Valid Place] not found"
  end
end
