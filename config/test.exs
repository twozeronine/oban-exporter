import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :oban_exporter, ObanExporter.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "127.0.0.1",
  database: "oban_exporter_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  port: 5432

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :oban_exporter, ObanExporterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "8e3jSbrJOW5i/NpL2ycLln50qLr6Dw+lhNuaE0bpmyBvswJwVL14GCEDEkYevu1p",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

config :oban_exporter, ObanExporter.Plug.ObanCustomMetricPlug, poll_rate: 5_000

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
