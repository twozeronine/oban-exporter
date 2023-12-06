defmodule ObanExporter.Plug.ObanCustomMetricPlug do
  use PromEx.Plugin

  import Ecto.Query
  require Logger

  alias Oban.Job
  alias ObanExporter.Repo

  @default_poll_rate 5_000
  @oban_job_event [:oban, :job, :count]

  @impl true
  def polling_metrics(_opts) do
    Polling.build(
      :oban_job_count_metrics,
      Application.get_env(:oban_exporter, :poll_rate, @default_poll_rate),
      {__MODULE__, :start, []},
      [
        last_value(
          [:oban, :job, :count],
          event_name: @oban_job_event,
          measurement: :count,
          description: "Oban job count",
          tags: [:queue, :state]
        )
      ]
    )
  end

  def start() do
    if Ecto.Adapters.SQL.table_exists?(Repo, Job.__schema__(:source)) do
      Logger.info("table oban jobs exist")
      execute()
      Logger.info("execute success")
    else
      Logger.error("table \"oban_jobs\" does not exist")
    end
  end

  defp execute() do
    Logger.info("get oban job states")

    for state <- Job.states() do
      Logger.info("get all queues now state: #{state}")

      for queue <- Repo.all(from j in Job, group_by: [j.queue], select: j.queue) do
        Logger.info("get #{state} state #{queue} queue count")

        count =
          Repo.aggregate(
            from(j in Job,
              where: j.state == ^(state |> Atom.to_string()) and j.queue == ^queue
            ),
            :count
          )

        Logger.info("execute metrics")
        :telemetry.execute(@oban_job_event, %{count: count}, %{queue: queue, state: state})
      end
    end

    :ok
  end
end
