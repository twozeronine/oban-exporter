defmodule ObanExporterWeb.Router do
  use ObanExporterWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ObanExporterWeb do
    pipe_through :api
  end
end
