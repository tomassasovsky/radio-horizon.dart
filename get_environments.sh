case "$OSTYPE" in
  darwin* | linux*) 
    if [[ -f ".env" ]]
    then
      $(mv .env .env.old)
      echo "Renamed .env to .env.old to be able to create the .env folder"
    fi
    if [[ ! -d ".env" ]]
    then
      mkdir .env
    fi

    get_environment_variables() {
      npx dotenv-vault pull $1 .env/.env.$1
    }

    get_environment_variables development
    get_environment_variables production
  ;;
  msys* | cygwin*)
    echo "Windows is not supported with this script"
    echo "Please use the get_environments.bat script"
  ;;
  *)
    echo "unknown system: $OSTYPE" 
    exit 127
  ;;
esac
