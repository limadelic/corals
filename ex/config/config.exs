# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

config :reef,
  generators: [context_app: false]

# Configures the endpoint
config :reef, Reef.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kJsYs4/xz/6ULjAVNoP0md1hSmkI0IdN3st01NPUBkdoz1/jBOHU3BvG2uN3j8n7",
  render_errors: [view: Reef.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Reef.PubSub,
  live_view: [signing_salt: "c85ve1+H"]

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#

config :phoenix, :json_library, Jason
# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
