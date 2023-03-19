FROM dart:2.19.0 AS build

ARG dart_entryfile

WORKDIR /app
COPY pubspec.* /app/
RUN dart pub get

COPY . /app
COPY /radiobrowser_config /radiobrowser_config
RUN dart pub get --offline

RUN dart run nyxx_commands:compile bin/$dart_entryfile -o bot.dart
EXPOSE 8080
EXPOSE 2333

CMD [ "./bot.exe" ]
