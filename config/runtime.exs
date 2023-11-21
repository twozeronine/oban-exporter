import Config

if System.get_env("PHX_SERVER") do
  config :oban_exporter, ObanExporterWeb.Endpoint, server: true
end

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      environment variable DATABASE_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  config :oban_exporter, ObanExporter.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("PGPOOL_SIZE") || "10")

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "8080")

  config :oban_exporter, ObanExporterWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [port: port],
    secret_key_base: "yRVrJDw01zzHx601zl5s4Li0Lr/sMx/LTQEjRDwt3tCE2ueCtO7nNL4C/pYZcDoK",
    server: true
end
