# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ObanExporter.Repo.insert!(%ObanExporter.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule TestWorker do
  use Oban.Worker, queue: :default

  @impl Oban.Worker
  def perform(_job) do
    :ok
  end
end

# ObanCustomMetricplug retrieves the repo as soon as the application is executed, and if there is no seed, an error occurs.
# Therefore, you need to fill in at least one seed at test time.
%{id: 1, user_id: 1}
|> Oban.Job.new(queue: :default, worker: TestWorker)
|> ObanExporter.Repo.insert()
