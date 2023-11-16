defmodule ObanExporter.Plug.ObanCustomMetricPlug do
  use PromEx.Plugin

  import Ecto.Query

  alias ObanExporter.Repo

  @default_poll_rate 5_000

  @oban_job_event [:oban, :job, :count]

  @impl true
  def polling_metrics(opts) do
    poll_rate = Keyword.get(opts, :poll_rate, @default_poll_rate)

    Polling.build(
      :oban_job_count_metrics,
      poll_rate,
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
    from(
      j in Oban.Job,
      group_by: [j.queue, j.state],
      select: {j.queue, j.state, count(j.id)}
    )
    |> Repo.all()
    |> Enum.each(fn {queue, state, count} ->
      :telemetry.execute(@oban_job_event, %{count: count}, %{queue: queue, state: state})
    end)
  end
end
