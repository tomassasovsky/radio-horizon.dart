# Use the official Dart image as the base
FROM dart:stable AS build

# Set the working directory
WORKDIR /app
COPY pubspec.* /app/
RUN dart pub get

# Copy the rest of the application code
COPY . /app
RUN dart pub get

# Compile the Dart script to a native executable (optional but recommended)
RUN dart compile exe update_lavalink_config.dart -o update_lavalink_config

# Set the entrypoint to the compiled executable
ENTRYPOINT ["./update_lavalink_config"]

# Default arguments (can be overridden)
CMD []
