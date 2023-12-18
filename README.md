<p align="center">
 <img alt="Oban Exporter logo" src="https://github.com/twozeronine/oban-exporter/assets/67315288/87c76f06-d6e9-4cf0-820f-45286feeac3a" width="240">
</p>

<p align="center">
 Exporting Oban work Metrics as Prometheus Metrics.
</p>


<p align="center">
  <a href="https://github.com/twozeronine/oban-exporter/actions/workflows/build_and_test.yml">
    <img alt="Build and Test" src="https://github.com/twozeronine/oban-exporter/actions/workflows/build_and_test.yml/badge.svg">
  </a>
  <a href="https://github.com/twozeronine/oban-exporter/actions/workflows/build_and_test.yml">
    <img alt="Image build and push" src="https://github.com/twozeronine/oban-exporter/actions/workflows/image_build_and_push.yml/badge.svg">
  </a>
</p>

<center>

### ⚙️ Requirement ENV 

| env |  default value | 
|  -  |       -        |
| DATABASE_URL  | X |
| PGPOOL_SIZE  | "10" |
| PORT |  "8080" |
| POLL_RATE |  5000 |
| SECRET_KEY_BASE | optional |
| DEBUG_LOG | false |

</center>

----

- DATABASE_URL : The URL specifying the database connection for use with the Elixir library Oban. This URL typically includes details such as the database type, username, password, host, and port.

- PGPOOL_SIZE : The size of the PostgreSQL connection pool.

- PORT : The port number on which the application should listen.

- POLL_RATE : 
`poll rate` refers to the frequency or interval at which a system or application collects metric data, typically used in monitoring systems. It represents how often metrics are sampled to track the state and performance of the system. The poll rate determines the balance between real-time monitoring and resource utilization.

- SECRET_KEY_BASE : 64 characters long, The Secret Key Base is a crucial secret key used in web applications like the Phoenix framework to enhance security and encrypt sensitive information such as session data. It must be securely stored, as its exposure could pose a serious threat to the application's security.

- DEBUG_LOG : Enable logs needed for debugging. If you want to see logs from cloud services or other services you use, enable them

```
docker run -it -p 8080:8080 --e DATABASE_URL=${USER_DATABASE_URL} ./.env oban-exporter
```

### Features

After running the image, you can access ```${OBAN_EXPORTER_ENDPOINT}/metrics``` to see the metrics of the Oban job.

Example Image)

![image](https://github.com/twozeronine/oban-exporter/assets/67315288/210c5e84-3741-493d-8712-7608a6199610)

### Custom Execute

You can use custom execute

- CUSTOM_EXECUTE : custom execute takes metrics and lets you use whatever metrics you want.

Example)

```elixir
    # metrics are metric map %{queue: queue, count: count, state: state}
    # queue is queue name
    # count is job's count
    # state is Oban.Jobs.state [:available, :retryable, :cancelled, :executing, :discarded, :completed, :scheduled]

  You can insert custom execute

  custom_execute: "
    sum = Enum.filter(metrics, fn %{queue: queue} -> queue == \"work\" end)
    |> Enum.reduce(0, fn %{count: count, state: state}, acc ->
      if state == :executing or state == :available do
        acc + count
      else
        acc
      end
    end)

    :telemetry.execute([:oban, :job, :count], %{count: sum}, %{queue: \"work\", state: \"sum_executing_available\"})
  "
```
