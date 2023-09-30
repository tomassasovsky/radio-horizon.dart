echo off

docker compose stop lavalink
docker compose stop radio_horizon

docker image rm radio-horizondart-radio_horizon:latest -f

docker rm lavalink -f
docker rm radio_horizon -f

docker compose -f docker-compose.yml up -d --force-recreate --no-deps --build