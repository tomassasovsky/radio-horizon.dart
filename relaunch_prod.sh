echo off

docker compose stop lavalink
docker compose stop radio_horizon

docker image rm ghcr.io/tomassasovsky/radio-horizon.dart:latest -f

docker rm lavalink -f
docker rm radio_horizon -f

docker compose -f docker-compose.prod.yml up -d --force-recreate --no-deps --build