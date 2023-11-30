defmodule ObanExporter.Fixtures.ObanFixture do
  defmodule TestWorker do
    use Oban.Worker, queue: :default

    @impl Oban.Worker
    def perform(_job) do
      :ok
    end
  end

  def oban_job_fixture(attrs \\ %{}) do
    attrs
    |> Oban.Job.new(queue: :default, worker: TestWorker)
    |> ObanExporter.Repo.insert()
  end
end
