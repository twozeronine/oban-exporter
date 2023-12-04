defmodule ObanExporter.PromEx do
  use PromEx, otp_app: :oban_exporter

  @impl true
  def plugins() do
    [ObanExporter.Plug.ObanCustomMetricPlug]
  end

  @impl true
  def dashboard_assigns() do
    [
      datasource_id: "Prometheus",
      default_selected_interval: "30s"
    ]
  end

  @impl true
  def dashboards() do
    []
  end
end
