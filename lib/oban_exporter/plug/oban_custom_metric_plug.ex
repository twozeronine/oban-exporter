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
      debug_log("table oban jobs exist")
      execute()
      debug_log("execute success")
      :ok
    else
      Logger.error("table \"oban_jobs\" does not exist")
    end
  end

  defp execute() do
    debug_log("Execute metrics through all states defined in the Oban job queue system.")

    for state <- Job.states() do
      for queue <- Repo.all(from j in Job, group_by: [j.queue], select: j.queue) do
        count =
          Repo.aggregate(
            from(j in Job,
              where: j.state == ^(state |> Atom.to_string()) and j.queue == ^queue
            ),
            :count
          )

        :telemetry.execute(@oban_job_event, %{count: count}, %{queue: queue, state: state})
      end
    end
  end

  defp debug_log(log) do
    if Application.get_env(:oban_exporter, :debug_log, false) do
      Logger.info(log)
    end
  end
end
