defmodule ObanExporter.Plug.ObanCustomMetricPlug do
  use PromEx.Plugin

  import Ecto.Query
  require Logger

  alias ObanExporter.Repo

  @default_poll_rate 5_000

  @oban_job_event [:oban, :job, :count]

  @impl true
  def polling_metrics(_opts) do
    Polling.build(
      :oban_job_count_metrics,
      get_user_set_poll_rate(),
      {__MODULE__, :excute_oban_job_counts, []},
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

  def excute_oban_job_counts() do
    case exists_oban_job_table?() do
      true ->
        from(
          j in Oban.Job,
          group_by: [j.queue, j.state],
          select: {j.queue, j.state, count(j.id)}
        )
        |> Repo.all()
        |> Enum.each(fn {queue, state, count} ->
          :telemetry.execute(@oban_job_event, %{count: count}, %{queue: queue, state: state})
        end)

      false ->
        Logger.error("table \"oban_jobs\" does not exist")
    end
  end

  def exists_oban_job_table?() do
    {:ok, query_result} =
      ObanExporter.Repo.query(
        "SELECT table_name FROM information_schema.tables WHERE table_name = 'oban_jobs' AND table_schema = 'public'",
        []
      )

    not Enum.empty?(query_result.rows)
  end

  defp get_user_set_poll_rate() do
    Application.get_env(:oban_exporter, __MODULE__, @default_poll_rate)[:poll_rate]
  end
end
