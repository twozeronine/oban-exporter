import Config

config :oban_exporter, ObanExporter.Repo,
  username: "postgres",
  password: "postgres",
  hostname: System.get_env("PG_HOST", "localhost"),
  database: "oban_exporter_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10,
  port: 5432

config :oban_exporter, ObanExporterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "8e3jSbrJOW5i/NpL2ycLln50qLr6Dw+lhNuaE0bpmyBvswJwVL14GCEDEkYevu1p",
  server: false

config :logger, level: :warning

config :oban_exporter,
    poll_rate: 5_000,
    debug_log: false


config :phoenix, :plug_init_mode, :runtime
