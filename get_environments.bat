@echo off

CD .env
IF "%ERRORLEVEL%"=="0" (
    CD ../
) ELSE (
    rename .env .env.old
    echo Renamed .env to .env.old
    mkdir .env
    echo Created .env directory
)

SETLOCAL
CALL :PullEnvironmentVariables "development"
CALL :PullEnvironmentVariables "production"
EXIT /B %ERRORLEVEL%

:PullEnvironmentVariables
echo Getting for %~1...
CALL npx dotenv-vault pull %~1 .env/.env.%~1