# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :blog,
  ecto_repos: [Blog.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :blog, BlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "O9e881vL79sWlovi1HdvXCUaJbklpVmwyLkuQ5fkNDerjq1frh3+UAuRtMVblw8w",
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Blog.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
