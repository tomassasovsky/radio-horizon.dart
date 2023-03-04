echo off

docker compose stop lavalink
docker compose stop radio_garden

docker image rm fredboat/lavalink:master -f
docker image rm radio-gardendart-radio_garden:latest -f

docker rm lavalink -f
docker rm radio_garden -f

docker compose -f docker-compose.prod.yml up -d --force-recreate --no-deps --build