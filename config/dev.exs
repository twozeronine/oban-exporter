import Config

config :oban_exporter, ObanExporter.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "prometheus_elixir_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 5,
  port: 5432

config :oban_exporter, ObanExporterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "So5QmaOGS4/lBzYqE7ZtFsCH7eg3x+7lRial4EIJ8o2zHgwBcjplQoBy2+LWtMjT",
  watchers: []

config :oban_exporter, ObanCustomMetricPlug,
  queue: "work",
  states: ["available", "executing"],
  aggregate: :sum

config :oban_exporter, poll_rate: 5_000

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
