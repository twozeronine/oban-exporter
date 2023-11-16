defmodule ObanExporter.Repo do
  use Ecto.Repo,
    otp_app: :oban_exporter,
    adapter: Ecto.Adapters.Postgres
end
