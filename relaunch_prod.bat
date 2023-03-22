@echo off
CALL docker-compose stop lavalink
CALL docker-compose stop radio_horizon

@REM remove images
CALL docker image rm fredboat/lavalink:master -f
CALL docker image rm ghcr.io/tomassasovsky/radio-horizon.dart:latest -f

@REM remove containers
CALL docker rm lavalink -f
CALL docker rm radio_horizon -f

CALL docker-compose -f docker-compose.prod.yml up -d --force-recreate --no-deps --build