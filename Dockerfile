FROM dart:stable AS build

ARG dart_entryfile

WORKDIR /app
COPY pubspec.* /app/
COPY shazam_client /app/
RUN dart pub get

COPY . /app
COPY . /app
RUN dart pub get

RUN dart run nyxx_commands:compile bin/$dart_entryfile -o bot.dart
EXPOSE 8080
EXPOSE 2333

CMD [ "./bot.exe" ]
