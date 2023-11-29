defmodule ObanExporter.Plug.ObanCustomMetricPlugTest do
  use ObanExporter.DataCase

  alias ObanExporter.Plug.ObanCustomMetricPlug

  describe "excute_oban_job_counts" do
    test "excute_oban_job_counts" do
      assert :ok == ObanCustomMetricPlug.excute_oban_job_counts()

      assert_receive {:telemetry_event, [:oban, :job, :count], %{count: _},
                      %{state: "available", queue: "default"}},
                     1000
    end
  end
end
