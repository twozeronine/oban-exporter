# ObanExporter

## Release

## build

```
 docker build --build-arg _MIX_ENV=prod -t oban_exporter .
```

## run

### Requirement ENV

| env |  default value | 
|  -  |       -        |
| DATABASE_URL  | X |
| PGPOOL_SIZE  | "10" |
| PORT |  "8080" |
| POLL_RATE |  5000 |
| SECRET_KEY_BASE | optional |
| OBAN_ADAPTER | "postgres" |

- DATABASE_URL : The URL specifying the database connection for use with the Elixir library Oban. This URL typically includes details such as the database type, username, password, host, and port.

- PGPOOL_SIZE : The size of the PostgreSQL connection pool.

- PORT : The port number on which the application should listen.

- POLL_RATE : 
`poll rate` refers to the frequency or interval at which a system or application collects metric data, typically used in monitoring systems. It represents how often metrics are sampled to track the state and performance of the system. The poll rate determines the balance between real-time monitoring and resource utilization.

- SECRET_KEY_BASE : 64 characters long, The Secret Key Base is a crucial secret key used in web applications like the Phoenix framework to enhance security and encrypt sensitive information such as session data. It must be securely stored, as its exposure could pose a serious threat to the application's security.

- OBAN_ADAPTER : environment variable configures the database adapter for use in oban_exporter.
Oban is utilized for managing background jobs, and this variable determines which
database to use. Accepted values for OBAN_ADAPTER include "postgres" and "pg_bouncer".

```
docker run -it -p 8080:8080 --e DATABASE_URL=${USER_DATABASE_URL} ./.env oban_exporter

or

docker run -it -p 8080:8080 --env-file ./.env oban_exporter
```