import Config

config :oban_exporter,
  ecto_repos: [ObanExporter.Repo]

config :oban_exporter, ObanExporterWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ObanExporterWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: ObanExporter.PubSub,
  live_view: [signing_salt: "Kjf+8UOX"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
