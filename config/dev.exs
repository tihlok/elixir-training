use Mix.Config

config :leaderboard,
  env: :DEV,
  openweathermap_base_url: "http://api.openweathermap.org/data/2.5/weather",
  openweathermap_app_id: "22ed41bd5f74ad29481d98452e672c6e"

config :git_hooks,
  auto_install: true,
  verbose: true,
  hooks: [
    pre_commit: [
      tasks: [
        {:cmd, "echo 'executing git pre hook'"},
        {:cmd, "mix format"},
        {:cmd, "mix hex.outdated"},
        {:cmd, "mix test --color --cover"},
        {:cmd, "echo 'success!'"}
      ]
    ]
  ]
