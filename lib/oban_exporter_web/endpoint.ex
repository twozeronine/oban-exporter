defmodule ObanExporterWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :oban_exporter

  @session_options [
    store: :cookie,
    key: "_oban_exporter_key",
    signing_salt: "MglwhQ//"
  ]

  plug PromEx.Plug, prom_ex_module: ObanExporter.PromEx

  plug Plug.RequestId

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug ObanExporterWeb.Router
end
