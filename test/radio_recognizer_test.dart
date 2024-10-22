import 'package:injector/injector.dart';
import 'package:radio_horizon/radio_horizon.dart';
import 'package:retry/retry.dart';
import 'package:sentry/sentry.dart';
import 'package:sentry_logging/sentry_logging.dart';
import 'package:shazam_client/shazam_client.dart';
import 'package:test/test.dart';

void main() {
  var recognitionSampleDuration = 10;

  setUpAll(() async {
    dotEnvFlavour = DotEnvFlavour.development;
    dotEnvFlavour.initialize();

    await Sentry.init(
      (options) {
        options
          ..dsn = sentryDsn
          ..environment = dotEnvFlavour.name
          ..release = packageVersion
          ..debug = dotEnvFlavour == DotEnvFlavour.development
          ..attachStacktrace = true
          ..sampleRate = 1.0
          ..sendDefaultPii = true
          ..tracesSampleRate = 1.0
          ..addIntegration(LoggingIntegration());
      },
    );

    Injector.appInstance
      ..registerSingleton(ShazamClient.localhost)
      ..registerSingleton(SongRecognitionService.new);
  });

  test(
    'test description',
    () async {
      SongModel? result;
      await retry(
        () async {
          result = await SongRecognitionService().identify(
            'https://ais-edge49-nyc04.cdnstream.com/2281_128.mp3',
            recognitionSampleDuration,
          );
        },
        maxDelay: const Duration(minutes: 2),
        retryIf: (e) => true,
        onRetry: (e) {
          recognitionSampleDuration +=
              (recognitionSampleDuration * 0.25).toInt();
        },
      ).timeout(const Duration(minutes: 1));

      expect(result, isNotNull);
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
