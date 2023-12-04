defmodule ObanExporter.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        ObanExporter.Repo,
        ObanExporter.PromEx,
        ObanExporterWeb.Endpoint
      ]

    opts = [
      strategy: :one_for_one,
      name: ObanExporter.Supervisor,
      max_seonds: 1,
      max_restarts: 1_000_000_000
    ]

    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    ObanExporterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
