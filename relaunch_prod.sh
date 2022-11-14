echo off

docker-compose stop lavalink
docker-compose stop radio_garden
docker-compose -f docker-compose.prod.yml up -d --force-recreate --no-deps --build