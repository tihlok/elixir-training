use Mix.Config

IO.puts "LOADING #{Mix.env}.exs CONFIG FILE..."
import_config "#{Mix.env}.exs"
