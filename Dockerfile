FROM dart:3.13.4 AS build

ARG dart_entryfile

WORKDIR /app
COPY pubspec.* /app/
COPY shazam_client /app/shazam_client
RUN dart pub get

COPY . /app
RUN dart pub get

RUN dart run nyxx_commands:compile bin/$dart_entryfile -o bot.dart --no-compile
RUN dart compile exe bot.dart -o bot
EXPOSE 8080
EXPOSE 2333

CMD [ "./bot" ]
