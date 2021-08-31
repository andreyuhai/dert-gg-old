# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :derdini_gg,
  namespace: DerdiniGG,
  ecto_repos: [DerdiniGG.Repo]

config :derdini_gg_web,
  namespace: DerdiniGGWeb,
  ecto_repos: [DerdiniGG.Repo],
  generators: [context_app: :derdini_gg]

# Configures the endpoint
config :derdini_gg_web, DerdiniGGWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "D+MwgY1nCbumtXQH6FqrykwSMGq/FtUVC2AYhfX2SAJaIpkIW5wbLrgtDRUDALkQ",
  render_errors: [view: DerdiniGGWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DerdiniGG.PubSub,
  live_view: [signing_salt: "ksLtQzcf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Ueberauth config
config :ueberauth, Ueberauth,
  providers: [
    identity: {Ueberauth.Strategy.Identity, [
      param_nesting: "account",
      request_path: "/register",
      callback_path: "/register",
      callback_methods: ["POST"]
    ]}
  ]

# Guardian config
config :derdini_gg, DerdiniGGWeb.Authentication,
  issuer: "derdini_gg",
  secret_key: System.get_env("GUARDIAN_SECRET_KEY")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
