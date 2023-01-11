## Radio Garden Discord Bot

[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]

**Radio Garden Discord Bot** is a Discord radio playing bot that brings a whole new level of listening experience to your server. With its powerful song recognition technology, radio-garden.dart can identify and announce the songs currently playing on the radio, making it easy to keep track of your favorite tunes. Whether you're a music lover, DJ or just looking for an easy way to discover new music, radio-garden.dart is the perfect companion.

Features
- A wide range of radio stations from around the world
- Song recognition technology to announce the songs currently playing
- Easy to use commands
- Customizable settings to fit your server needs


---

## Getting Started 🚀

### Getting environment variables


```sh
bash get_environments.sh
```

### Running the server on Docker

```sh
bash relaunch_prod.sh #Or relaunch.sh if working in dev
```

### Running the server on a Dev Container ⚡

By running the server in a dev container you'll be able to use zsh and you'll not need to wait for docker to rebuild every time you want to test a change in the code.


- Install Dev Containers in VS Code.
- Press F1 and run `Rebuild and Reopen in container`.

From there you can run:

```dart
dart bin/radio_garden_development.dart
```


## Running Tests with coverage 🧪

To run all unit tests use the following command:

```sh
$ dart pub global activate coverage 1.2.0
$ dart test --coverage=coverage
$ dart pub global run coverage:format_coverage --lcov --in=coverage --out=coverage/lcov.info
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov)
.

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

## Maintainers
- [@tomassasovsky](https://github.com/tomassasovsky)
- [@jorger5](https://github.com/jorger5)
- [@NazarenoCavazzon](https://github.com/NazarenoCavazzon)
- [@tomasatisocco](https://github.com/tomasatisocco)

## Credits

Huge shoutout to the developers of [nyxx](https://github.com/nyxx-discord) and [Radio Garden](https://radio.garden) for their incredible work. Without the amazing contributions of these developers, creating our Discord radio-playing bot wouldn't have been possible.

## Contact Us

If you have any issues or suggestions, feel free to join our Discord server: https://discord.gg/tPKheWzKD8 and contact one of the team members: Tomás Sasovsky, Jorge Rincón Arias, Nazareno Cavazzon, and Tomás Tisocco.
You can also email me at to.sasovsky@gmail.com for any inquiries.

## Disclaimer

We do not own or claim to own any of the radio stations provided by the bot. All credit for the radio stations goes to their respective owners.

---

[coverage_badge]: coverage_badge.svg
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
