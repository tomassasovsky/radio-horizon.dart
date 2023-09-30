@echo off
CALL docker-compose stop lavalink
CALL docker-compose stop radio_horizon

@REM remove images
CALL docker image rm radio-horizondart-radio_horizon:latest -f

@REM remove containers
CALL docker rm lavalink -f
CALL docker rm radio_horizon -f

CALL docker-compose -f docker-compose.yml up -d --force-recreate --no-deps --build