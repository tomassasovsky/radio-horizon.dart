@echo off
CALL docker-compose stop lavalink
CALL docker-compose stop radio_garden
CALL docker-compose up -d --force-recreate --no-deps --build