defmodule ObanExporterWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :oban_exporter

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_oban_exporter_key",
    signing_salt: "MglwhQ//"
  ]

  # socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]
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
