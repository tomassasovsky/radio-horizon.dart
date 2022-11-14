echo off

docker-compose stop lavalink
docker-compose stop radio_garden
docker-compose up -d --force-recreate --no-deps --build