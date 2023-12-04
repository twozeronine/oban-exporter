defmodule ObanExporter.DataCase do
  use ExUnit.CaseTemplate

  @oban_job_event [:oban, :job, :count]

  using do
    quote do
      alias ObanExporter.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import ObanExporter.DataCase
    end
  end

  setup tags do
    ObanExporter.DataCase.setup_sandbox(tags)

    :ok =
      :telemetry.attach(
        "test_handler",
        @oban_job_event,
        fn name, measurements, metadata, _config ->
          :ok
          send(self(), {:telemetry_event, name, measurements, metadata})
        end,
        nil
      )

    :ok
  end

  def setup_sandbox(tags) do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(ObanExporter.Repo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
  end

  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
