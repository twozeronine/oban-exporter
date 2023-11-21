# ObanExporter

## Release

## build

```
 docker build --build-arg _MIX_ENV=prod -t oban_exporter .
```

## run

### Requirement ENV

- DATABASE_URL : The URL specifying the database connection for use with the Elixir library Oban. This URL typically includes details such as the database type, username, password, host, and port.
- PGPOOL_SIZE : The size of the PostgreSQL connection pool.
- PORT : The port number on which the application should listen.
- SECRET_KEY_BASE ( optional ): 64 characters long, The Secret Key Base is a crucial secret key used in web applications like the Phoenix framework to enhance security and encrypt sensitive information such as session data. It must be securely stored, as its exposure could pose a serious threat to the application's security.

```
docker run -it -p 8080:8080 --e DATABASE_URL=${USER_DATABASE_URL} -e PGPOOL_SIZE=${YOUR_PG_POOL_SIZE}  ./.env oban_exporter

or

docker run -it -p 8080:8080 --env-file ./.env oban_exporter
```