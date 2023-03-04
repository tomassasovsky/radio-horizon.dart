@echo off
CALL docker-compose stop lavalink
CALL docker-compose stop radio_garden

@REM remove images
CALL docker image rm fredboat/lavalink:master -f
CALL docker image rm radio-gardendart-radio_garden:latest -f

@REM remove containers
CALL docker rm lavalink -f
CALL docker rm radio_garden -f

CALL docker-compose -f docker-compose.prod.yml up -d --force-recreate --no-deps --build