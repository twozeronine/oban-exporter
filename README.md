# ObanExporter

## Release

## build

```
 docker build --build-arg _MIX_ENV=prod -t oban_exporter .
```

## run

### Requirement ENV

- DATABASE_URL : Your database url
- PGPOOL_SIZE : PGPOOL_SIZE
- PORT : PORT

```
docker run -it -p 8080:8080 --e DATABASE_URL=${USER_DATABASE_URL} -e PGPOOL_SIZE=${YOUR_PG_POOL_SIZE}  ./.env oban_exporter

or

docker run -it -p 8080:8080 --env-file ./.env oban_exporter
```