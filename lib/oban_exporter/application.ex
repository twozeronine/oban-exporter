defmodule ObanExporter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        # Start the Ecto repository
        ObanExporter.Repo,
        ObanExporter.PromEx,
        # Start the Telemetry supervisor
        # Start the Endpoint (http/https)
        ObanExporterWeb.Endpoint
        # Start a worker by calling: ObanExporter.Worker.start_link(arg)
        # {ObanExporter.Worker, arg}
      ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [
      strategy: :one_for_one,
      name: ObanExporter.Supervisor,
      max_seonds: 1,
      max_restarts: 1_000_000_000
    ]

    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ObanExporterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
