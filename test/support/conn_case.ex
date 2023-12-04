defmodule ObanExporterWeb.ConnCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Plug.Conn
      import Phoenix.ConnTest
      import ObanExporterWeb.ConnCase

      alias ObanExporterWeb.Router.Helpers, as: Routes

      @endpoint ObanExporterWeb.Endpoint
    end
  end

  setup tags do
    ObanExporter.DataCase.setup_sandbox(tags)
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end
end
