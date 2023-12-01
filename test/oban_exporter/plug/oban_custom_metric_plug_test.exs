defmodule ObanExporter.Plug.ObanCustomMetricPlugTest do
  use ObanExporter.DataCase

  alias ObanExporter.Plug.ObanCustomMetricPlug
  alias ObanExporter.Fixtures.ObanFixture

  describe "excute_oban_job_counts" do
    setup do
      {:ok, _oban_job} = ObanFixture.oban_job_fixture(%{id: 1, user_id: 1})
      :ok
    end

    test "excute_oban_job_counts" do
      assert :ok == ObanCustomMetricPlug.excute_oban_job_counts()

      assert_receive {:telemetry_event, [:oban, :job, :count], %{count: _},
                      %{state: _, queue: "default"}},
                     1000

      assert_receive {:telemetry_event, [:oban, :job, :count], %{count: _},
                      %{state: _, queue: "default"}},
                     1000

      assert_receive {:telemetry_event, [:oban, :job, :count], %{count: _},
                      %{state: _, queue: "default"}},
                     1000

      assert_receive {:telemetry_event, [:oban, :job, :count], %{count: _},
                      %{state: _, queue: "default"}},
                     1000

      assert_receive {:telemetry_event, [:oban, :job, :count], %{count: _},
                      %{state: _, queue: "default"}},
                     1000

      assert_receive {:telemetry_event, [:oban, :job, :count], %{count: _},
                      %{state: _, queue: "default"}},
                     1000

      assert_receive {:telemetry_event, [:oban, :job, :count], %{count: _},
                      %{state: _, queue: "default"}},
                     1000
    end
  end
end
