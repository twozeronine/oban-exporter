import Config

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      "yRVrJDw01zzHx601zl5s4Li0Lr/sMx/LTQEjRDwt3tCE2ueCtO7nNL4C/pYZcDoK"

  config :oban_exporter, ObanExporter.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("PGPOOL_SIZE") || "10"),
    prepare: :unnamed

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "8080")

  config :oban_exporter,
    poll_rate: System.get_env("POLL_RATE", "5000") |> String.to_integer(),
    debug_log: System.get_env("DEBUG_LOG", "false") |> String.to_existing_atom(),
    custom_execute: System.get_env("CUSTOM_EXECUTE", "nil") |> String.to_existing_atom()

  config :oban_exporter, ObanExporterWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [port: port],
    secret_key_base: secret_key_base,
    server: true
end
