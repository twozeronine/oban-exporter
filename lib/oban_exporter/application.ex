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
        # Start the Telemetry supervisor
        # Start the Endpoint (http/https)
        ObanExporterWeb.Endpoint
        # Start a worker by calling: ObanExporter.Worker.start_link(arg)
        # {ObanExporter.Worker, arg}
      ] ++
        case Mix.env() != :test do
          true -> [ObanExporter.PromEx]
          _ -> []
        end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ObanExporter.Supervisor]
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
