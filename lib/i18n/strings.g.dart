/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 196 (98 per locale)
///
/// Built on 2023-10-01 at 23:21 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:slang/builder/model/node.dart';
import 'package:slang/slang.dart';
export 'package:slang/slang.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, StringsEn> {
  en(languageCode: 'en', build: StringsEn.build),
  es(languageCode: 'es', build: StringsEs.build);

  const AppLocale(
      {required this.languageCode,
      this.scriptCode,
      this.countryCode,
      required this.build}); // ignore: unused_element

  @override
  final String languageCode;
  @override
  final String? scriptCode;
  @override
  final String? countryCode;
  @override
  final TranslationBuilder<AppLocale, StringsEn> build;

  /// Gets current instance managed by [LocaleSettings].
  StringsEn get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of local).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = local.someKey.anotherKey;
/// String b = local['someKey.anotherKey']; // Only for edge cases!
StringsEn get local => LocaleSettings.instance.currentTranslations;

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseLocaleSettings<AppLocale, StringsEn> {
  LocaleSettings._() : super(utils: AppLocaleUtils.instance);

  static final instance = LocaleSettings._();

  // static aliases (checkout base methods for documentation)
  static AppLocale get currentLocale => instance.currentLocale;
  static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
  static AppLocale setLocale(AppLocale locale,
          {bool? listenToDeviceLocale = false}) =>
      instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
  static AppLocale setLocaleRaw(String rawLocale,
          {bool? listenToDeviceLocale = false}) =>
      instance.setLocaleRaw(rawLocale,
          listenToDeviceLocale: listenToDeviceLocale);
  @Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]')
  static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
  static void setPluralResolver(
          {String? language,
          AppLocale? locale,
          PluralResolver? cardinalResolver,
          PluralResolver? ordinalResolver}) =>
      instance.setPluralResolver(
        language: language,
        locale: locale,
        cardinalResolver: cardinalResolver,
        ordinalResolver: ordinalResolver,
      );
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, StringsEn> {
  AppLocaleUtils._()
      : super(baseLocale: _baseLocale, locales: AppLocale.values);

  static final instance = AppLocaleUtils._();

  // static aliases (checkout base methods for documentation)
  static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
  static AppLocale parseLocaleParts(
          {required String languageCode,
          String? scriptCode,
          String? countryCode}) =>
      instance.parseLocaleParts(
          languageCode: languageCode,
          scriptCode: scriptCode,
          countryCode: countryCode);
  static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class StringsEn implements BaseTranslations<AppLocale, StringsEn> {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  StringsEn.build(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.en,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <en>.
  @override
  final TranslationMetadata<AppLocale, StringsEn> $meta;

  /// Access flat map
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final StringsEn _root = this; // ignore: unused_field

  // Translations
  late final StringsCommandsEn commands = StringsCommandsEn._(_root);
  late final StringsServicesEn services = StringsServicesEn._(_root);
  late final StringsErrorHandlerEn errorHandler =
      StringsErrorHandlerEn._(_root);
}

// Path: commands
class StringsCommandsEn {
  StringsCommandsEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  late final StringsCommandsInfoEn info = StringsCommandsInfoEn._(_root);
  late final StringsCommandsSkipEn skip = StringsCommandsSkipEn._(_root);
  late final StringsCommandsStopEn stop = StringsCommandsStopEn._(_root);
  late final StringsCommandsLeaveEn leave = StringsCommandsLeaveEn._(_root);
  late final StringsCommandsJoinEn join = StringsCommandsJoinEn._(_root);
  late final StringsCommandsVolumeEn volume = StringsCommandsVolumeEn._(_root);
  late final StringsCommandsPauseEn pause = StringsCommandsPauseEn._(_root);
  late final StringsCommandsResumeEn resume = StringsCommandsResumeEn._(_root);
  late final StringsCommandsMusicEn music = StringsCommandsMusicEn._(_root);
  late final StringsCommandsRadioEn radio = StringsCommandsRadioEn._(_root);
}

// Path: services
class StringsServicesEn {
  StringsServicesEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  late final StringsServicesMusicEn music = StringsServicesMusicEn._(_root);
}

// Path: errorHandler
class StringsErrorHandlerEn {
  StringsErrorHandlerEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get title => 'An error has occurred';
  String get fallbackDescription =>
      'Your command couldn\'t be executed because of an error. Please contact a developer for more information.';
  String get musicConnectedToVC =>
      'I have to be in a voice channel to use this command';
  String get musicNotConnectedToVC =>
      'I\'m already connected to a voice channel';
  String get musicSameVC => 'I\'m already being used on other voice channel';
  String get musicUserConnectedToVC =>
      'You need to be connected to a voice channel to use this command';
  late final StringsErrorHandlerCooldownEn cooldown =
      StringsErrorHandlerCooldownEn._(_root);
  late final StringsErrorHandlerUnauthorizedCommandEn unauthorizedCommand =
      StringsErrorHandlerUnauthorizedCommandEn._(_root);
  late final StringsErrorHandlerMissingArgumentsEn missingArguments =
      StringsErrorHandlerMissingArgumentsEn._(_root);
  late final StringsErrorHandlerInputParsingFailureEn inputParsingFailure =
      StringsErrorHandlerInputParsingFailureEn._(_root);
}

// Path: commands.info
class StringsCommandsInfoEn {
  StringsCommandsInfoEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'info';
  String get description => 'Show information about the current project';
  String get addToServer => 'Add Radio Horizon to your server';
  String shardOf({required Object index, required Object count}) =>
      'Shard ${index} of ${count}';
  String get cachedGuilds => 'Cached guilds';
  String get cachedUsers => 'Cached users';
  String get cachedChannels => 'Cached channels';
  String get cachedVoiceStates => 'Cached voice states';
  String get shardCount => 'Shard count';
  String get cachedMessages => 'Cached messages';
  String get memoryUsage => 'Memory usage (current/RSS)';
  String get uptime => 'Uptime';
  String get currentPlayers => 'Current players';
  String get gatewayLatency => 'Gateway latency';
}

// Path: commands.skip
class StringsCommandsSkipEn {
  StringsCommandsSkipEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'skip';
  String get description => 'Skips the current song';
  String get skipped => 'Skipped current track';
  String get nothingPlaying => 'The queue is clear!';
}

// Path: commands.stop
class StringsCommandsStopEn {
  StringsCommandsStopEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'stop';
  String get description =>
      'Stops the current player and clears its track queue';
  String get stopped => 'Player stopped';
}

// Path: commands.leave
class StringsCommandsLeaveEn {
  StringsCommandsLeaveEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'leave';
  String get description => 'Leaves the current voice channel';
  String get left => 'Left voice channel';
  String get leftDueToInactivity => 'Left voice channel due to inactivity';
}

// Path: commands.join
class StringsCommandsJoinEn {
  StringsCommandsJoinEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'join';
  String get description => 'Joins the voice channel you are in';
  String get joined => 'Joined voice channel';
}

// Path: commands.volume
class StringsCommandsVolumeEn {
  StringsCommandsVolumeEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'volume';
  String get description => 'Sets the volume of the current player';
  String get volumeDescription =>
      'The volume to set, this value must be contained between 0 and 1000';
  String volumeSet({required Object volume}) => 'Volume set to ${volume}';
}

// Path: commands.pause
class StringsCommandsPauseEn {
  StringsCommandsPauseEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'pause';
  String get description => 'Pauses the current player';
  String get paused => 'Player paused';
}

// Path: commands.resume
class StringsCommandsResumeEn {
  StringsCommandsResumeEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'resume';
  String get description => 'Resumes the current player';
  String get resumed => 'Player resumed';
}

// Path: commands.music
class StringsCommandsMusicEn {
  StringsCommandsMusicEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'music';
  String get description => 'Music related commands';
  late final StringsCommandsMusicChildrenEn children =
      StringsCommandsMusicChildrenEn._(_root);
}

// Path: commands.radio
class StringsCommandsRadioEn {
  StringsCommandsRadioEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'radio';
  String get description => 'Radio related commands';
  late final StringsCommandsRadioChildrenEn children =
      StringsCommandsRadioChildrenEn._(_root);
}

// Path: services.music
class StringsServicesMusicEn {
  StringsServicesMusicEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  late final StringsServicesMusicTrackStuckEn trackStuck =
      StringsServicesMusicTrackStuckEn._(_root);
  late final StringsServicesMusicTrackStartedEn trackStarted =
      StringsServicesMusicTrackStartedEn._(_root);
  late final StringsServicesMusicTrackExceptionEn trackException =
      StringsServicesMusicTrackExceptionEn._(_root);
}

// Path: errorHandler.cooldown
class StringsErrorHandlerCooldownEn {
  StringsErrorHandlerCooldownEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get title => 'Command on cooldown';
  String description({required Object inSeconds}) =>
      'You can\'t use this command right now because it is on cooldown. Please wait ${inSeconds}s and try again.';
}

// Path: errorHandler.unauthorizedCommand
class StringsErrorHandlerUnauthorizedCommandEn {
  StringsErrorHandlerUnauthorizedCommandEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get title => 'You can\'t use this command!';
  String get description =>
      'This command can only be used by certain users in certain contexts. Check that you have permission to execute the command, or contact a developer for more information.';
}

// Path: errorHandler.missingArguments
class StringsErrorHandlerMissingArgumentsEn {
  StringsErrorHandlerMissingArgumentsEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get title => 'Not enough arguments';
  String get description =>
      'You didn\'t provide enough arguments for this command. Please try again and use the Slash Command menu for help, or contact a developer for more information.';
}

// Path: errorHandler.inputParsingFailure
class StringsErrorHandlerInputParsingFailureEn {
  StringsErrorHandlerInputParsingFailureEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get title => 'Couldn\'t parse input';
  String get description =>
      'Your command couldn\'t be executed because we were unable to understand your input. Please try again with different inputs or contact a developer for more information.';
}

// Path: commands.music.children
class StringsCommandsMusicChildrenEn {
  StringsCommandsMusicChildrenEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  late final StringsCommandsMusicChildrenPlayEn play =
      StringsCommandsMusicChildrenPlayEn._(_root);
}

// Path: commands.radio.children
class StringsCommandsRadioChildrenEn {
  StringsCommandsRadioChildrenEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  late final StringsCommandsRadioChildrenPlayEn play =
      StringsCommandsRadioChildrenPlayEn._(_root);
  late final StringsCommandsRadioChildrenRecognizeEn recognize =
      StringsCommandsRadioChildrenRecognizeEn._(_root);
  late final StringsCommandsRadioChildrenUpvoteEn upvote =
      StringsCommandsRadioChildrenUpvoteEn._(_root);
  late final StringsCommandsRadioChildrenPlayRandomEn playRandom =
      StringsCommandsRadioChildrenPlayRandomEn._(_root);
}

// Path: services.music.trackStuck
class StringsServicesMusicTrackStuckEn {
  StringsServicesMusicTrackStuckEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get title => 'Track stuck';
  String description(
          {required Object track,
          required Object uri,
          required Object requester}) =>
      'Track [${track}](${uri}}) stuck playing.\n\nRequested by <@${requester}>';
}

// Path: services.music.trackStarted
class StringsServicesMusicTrackStartedEn {
  StringsServicesMusicTrackStartedEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get title => 'Track started';
  String description(
          {required Object track,
          required Object uri,
          required Object requester}) =>
      'Track [${track}](${uri}}) started playing.\n\nRequested by <@${requester}>';
}

// Path: services.music.trackException
class StringsServicesMusicTrackExceptionEn {
  StringsServicesMusicTrackExceptionEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get title => 'Track exception';
  String description(
          {required Object track,
          required Object uri,
          required Object requester}) =>
      'Track [${track}](${uri}}) threw an exception.\n\nRequested by <@${requester}>';
}

// Path: commands.music.children.play
class StringsCommandsMusicChildrenPlayEn {
  StringsCommandsMusicChildrenPlayEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'play';
  String get description => 'Plays music based on the given query';
  String get queryDescription => 'The name/url of the song/playlist to play';
  String noResults({required Object query}) => 'No results found for ${query}';
  String playlistEnqueued({required Object name, required Object query}) =>
      'Playlist ${name} (${query}) enqueued';
  String songEnqueued({required Object title, required Object query}) =>
      'Song ${title} (${query}) enqueued';
}

// Path: commands.radio.children.play
class StringsCommandsRadioChildrenPlayEn {
  StringsCommandsRadioChildrenPlayEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'play';
  String get description => 'Plays a radio station based on the given query';
  String get queryDescription => 'The name of the radio station to play';
  String searching({required Object query}) =>
      'Searching for radio ${query}...';
  String noResults({required Object query}) => 'No results found for ${query}';
  String get startedPlaying => 'Started playing';
  String startedPlayingDescription(
          {required Object radio, required Object mention}) =>
      'Radio ${radio} started playing.\n\nRequested by ${mention}';
  String stationEnqueued({required Object name, required Object query}) =>
      'Station ${name} (${query}) enqueued';
}

// Path: commands.radio.children.recognize
class StringsCommandsRadioChildrenRecognizeEn {
  StringsCommandsRadioChildrenRecognizeEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'recognize';
  String get description => 'Recognizes the current song playing';
  String requestedBy({required Object mention}) => 'Requested by ${mention}';
  String get radioStationField => 'Radio Station';
  String get genreField => 'Genre';
  String get computationalTimeField => 'Computational time';
  late final StringsCommandsRadioChildrenRecognizeErrorsEn errors =
      StringsCommandsRadioChildrenRecognizeErrorsEn._(_root);
}

// Path: commands.radio.children.upvote
class StringsCommandsRadioChildrenUpvoteEn {
  StringsCommandsRadioChildrenUpvoteEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'upvote';
  String get description => 'Upvotes the current radio playing';
  String requestedBy({required Object mention}) => 'Requested by ${mention}';
  String get success => 'Voted successfully';
  String successDescription({required Object radio}) =>
      'You have successfully voted for the radio ${radio}! Thank you for your support :D';
  late final StringsCommandsRadioChildrenUpvoteErrorsEn errors =
      StringsCommandsRadioChildrenUpvoteErrorsEn._(_root);
}

// Path: commands.radio.children.playRandom
class StringsCommandsRadioChildrenPlayRandomEn {
  StringsCommandsRadioChildrenPlayRandomEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get command => 'play-random';
  String get description => 'Plays a random radio station';
  String get searching => 'Searching for a random radio station...';
  String get startedPlaying => 'Started playing';
  String startedPlayingDescription(
          {required Object radio, required Object mention}) =>
      'Radio ${radio} started playing.\n\nRequested by ${mention}';
  late final StringsCommandsRadioChildrenPlayRandomErrorsEn errors =
      StringsCommandsRadioChildrenPlayRandomErrorsEn._(_root);
}

// Path: commands.radio.children.recognize.errors
class StringsCommandsRadioChildrenRecognizeErrorsEn {
  StringsCommandsRadioChildrenRecognizeErrorsEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get title => 'An error occurred while recognizing the song';
  String get noRadioPlaying => 'Couldn\'t find a radio playing!';
  String get radioCantCommunicate =>
      'There was an error communicating with the server, please try again.';
  String get noResults => 'Couldn\'t identify the current song playing :(';
}

// Path: commands.radio.children.upvote.errors
class StringsCommandsRadioChildrenUpvoteErrorsEn {
  StringsCommandsRadioChildrenUpvoteErrorsEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get noRadioPlaying => 'Couldn\'t find a radio playing!';
}

// Path: commands.radio.children.playRandom.errors
class StringsCommandsRadioChildrenPlayRandomErrorsEn {
  StringsCommandsRadioChildrenPlayRandomErrorsEn._(this._root);

  final StringsEn _root; // ignore: unused_field

  // Translations
  String get noResults =>
      'Couldn\'t find a random radio station :( Try again later!';
}

// Path: <root>
class StringsEs extends StringsEn {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  StringsEs.build(
      {Map<String, Node>? overrides,
      PluralResolver? cardinalResolver,
      PluralResolver? ordinalResolver})
      : assert(overrides == null,
            'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.es,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ),
        super.build(
            cardinalResolver: cardinalResolver,
            ordinalResolver: ordinalResolver) {
    super.$meta.setFlatMapFunction(
        $meta.getTranslation); // copy base translations to super.$meta
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  /// Metadata for the translations of <es>.
  @override
  final TranslationMetadata<AppLocale, StringsEn> $meta;

  /// Access flat map
  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  @override
  late final StringsEs _root = this; // ignore: unused_field

  // Translations
  @override
  late final StringsCommandsEs commands = StringsCommandsEs._(_root);
  @override
  late final StringsServicesEs services = StringsServicesEs._(_root);
  @override
  late final StringsErrorHandlerEs errorHandler =
      StringsErrorHandlerEs._(_root);
}

// Path: commands
class StringsCommandsEs extends StringsCommandsEn {
  StringsCommandsEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  late final StringsCommandsInfoEs info = StringsCommandsInfoEs._(_root);
  @override
  late final StringsCommandsSkipEs skip = StringsCommandsSkipEs._(_root);
  @override
  late final StringsCommandsStopEs stop = StringsCommandsStopEs._(_root);
  @override
  late final StringsCommandsLeaveEs leave = StringsCommandsLeaveEs._(_root);
  @override
  late final StringsCommandsJoinEs join = StringsCommandsJoinEs._(_root);
  @override
  late final StringsCommandsVolumeEs volume = StringsCommandsVolumeEs._(_root);
  @override
  late final StringsCommandsPauseEs pause = StringsCommandsPauseEs._(_root);
  @override
  late final StringsCommandsResumeEs resume = StringsCommandsResumeEs._(_root);
  @override
  late final StringsCommandsMusicEs music = StringsCommandsMusicEs._(_root);
  @override
  late final StringsCommandsRadioEs radio = StringsCommandsRadioEs._(_root);
}

// Path: services
class StringsServicesEs extends StringsServicesEn {
  StringsServicesEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  late final StringsServicesMusicEs music = StringsServicesMusicEs._(_root);
}

// Path: errorHandler
class StringsErrorHandlerEs extends StringsErrorHandlerEn {
  StringsErrorHandlerEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ha ocurrido un error';
  @override
  String get fallbackDescription =>
      'Tu comando no se ha podido ejecutar debido a un error desconocido. Por favor contacte a un desarrollador para más información.';
  @override
  String get musicConnectedToVC =>
      'Debo estar conectado a un canal de voz para ejecutar este comando';
  @override
  String get musicNotConnectedToVC => 'Ya estoy conectado a un canal de voz';
  @override
  String get musicSameVC =>
      'Debes estar en el mismo canal de voz que yo para ejecutar este comando';
  @override
  String get musicUserConnectedToVC =>
      'Debes estar conectado a un canal de voz para ejecutar este comando';
  @override
  late final StringsErrorHandlerCooldownEs cooldown =
      StringsErrorHandlerCooldownEs._(_root);
  @override
  late final StringsErrorHandlerUnauthorizedCommandEs unauthorizedCommand =
      StringsErrorHandlerUnauthorizedCommandEs._(_root);
  @override
  late final StringsErrorHandlerMissingArgumentsEs missingArguments =
      StringsErrorHandlerMissingArgumentsEs._(_root);
  @override
  late final StringsErrorHandlerInputParsingFailureEs inputParsingFailure =
      StringsErrorHandlerInputParsingFailureEs._(_root);
}

// Path: commands.info
class StringsCommandsInfoEs extends StringsCommandsInfoEn {
  StringsCommandsInfoEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'info';
  @override
  String get description => 'Muestra información sobre el bot';
  @override
  String get addToServer => 'Añadir Radio Horizon a mi servidor';
  @override
  String shardOf({required Object index, required Object count}) =>
      'Fragmento ${index} de ${count}';
  @override
  String get cachedGuilds => 'Servidores en caché';
  @override
  String get cachedUsers => 'Usuarios en caché';
  @override
  String get cachedChannels => 'Canales en caché';
  @override
  String get cachedVoiceStates => 'Estados de voz en caché';
  @override
  String get shardCount => 'Fragmentos';
  @override
  String get cachedMessages => 'Mensajes en caché';
  @override
  String get memoryUsage => 'Uso de memoria (current/RSS)';
  @override
  String get uptime => 'Tiempo de actividad';
  @override
  String get currentPlayers => 'Reproductores actuales';
  @override
  String get gatewayLatency => 'Latencia de la puerta de enlace';
}

// Path: commands.skip
class StringsCommandsSkipEs extends StringsCommandsSkipEn {
  StringsCommandsSkipEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'saltar';
  @override
  String get description => 'Salta a la siguiente canción en la cola';
  @override
  String get skipped => 'La canción actual ha sido saltada';
  @override
  String get nothingPlaying => 'La cola está vacía';
}

// Path: commands.stop
class StringsCommandsStopEs extends StringsCommandsStopEn {
  StringsCommandsStopEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'parar';
  @override
  String get description => 'Para la reproducción de música';
  @override
  String get stopped => 'La reproducción de música ha sido detenida';
}

// Path: commands.leave
class StringsCommandsLeaveEs extends StringsCommandsLeaveEn {
  StringsCommandsLeaveEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'dejar';
  @override
  String get description => 'Abandona el canal de voz';
  @override
  String get left => 'El canal de voz ha sido abandonado';
  @override
  String get leftDueToInactivity =>
      'El canal de voz ha sido abandonado debido a la inactividad';
}

// Path: commands.join
class StringsCommandsJoinEs extends StringsCommandsJoinEn {
  StringsCommandsJoinEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'unirse';
  @override
  String get description => 'Se une al canal de voz en el que estás';
  @override
  String get joined => 'Se ha unido al canal de voz';
}

// Path: commands.volume
class StringsCommandsVolumeEs extends StringsCommandsVolumeEn {
  StringsCommandsVolumeEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'volumen';
  @override
  String get description => 'Establece el volumen de la música';
  @override
  String get volumeDescription =>
      'El volumen para establecer, debe ser un valor entre 0 y 1000';
  @override
  String volumeSet({required Object volume}) => 'Volumen puesto en ${volume}';
}

// Path: commands.pause
class StringsCommandsPauseEs extends StringsCommandsPauseEn {
  StringsCommandsPauseEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'pausar';
  @override
  String get description => 'Pausa la reproducción de música';
  @override
  String get paused => 'La reproducción de música ha sido pausada';
}

// Path: commands.resume
class StringsCommandsResumeEs extends StringsCommandsResumeEn {
  StringsCommandsResumeEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'reanudar';
  @override
  String get description => 'Reanuda la reproducción de música';
  @override
  String get resumed => 'La reproducción de música ha sido reanudada';
}

// Path: commands.music
class StringsCommandsMusicEs extends StringsCommandsMusicEn {
  StringsCommandsMusicEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'musica';
  @override
  String get description =>
      'Comandos relacionados con la funcionalidad de música';
  @override
  late final StringsCommandsMusicChildrenEs children =
      StringsCommandsMusicChildrenEs._(_root);
}

// Path: commands.radio
class StringsCommandsRadioEs extends StringsCommandsRadioEn {
  StringsCommandsRadioEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'radio';
  @override
  String get description =>
      'Comandos relacionados con la funcionalidad de radio';
  @override
  late final StringsCommandsRadioChildrenEs children =
      StringsCommandsRadioChildrenEs._(_root);
}

// Path: services.music
class StringsServicesMusicEs extends StringsServicesMusicEn {
  StringsServicesMusicEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  late final StringsServicesMusicTrackStuckEs trackStuck =
      StringsServicesMusicTrackStuckEs._(_root);
  @override
  late final StringsServicesMusicTrackStartedEs trackStarted =
      StringsServicesMusicTrackStartedEs._(_root);
  @override
  late final StringsServicesMusicTrackExceptionEs trackException =
      StringsServicesMusicTrackExceptionEs._(_root);
}

// Path: errorHandler.cooldown
class StringsErrorHandlerCooldownEs extends StringsErrorHandlerCooldownEn {
  StringsErrorHandlerCooldownEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Commando en cooldown';
  @override
  String description({required Object inSeconds}) =>
      'No puedes usar este comando ahora mismo porque está en cooldown. Por favor espera ${inSeconds}s e inténtalo de nuevo.';
}

// Path: errorHandler.unauthorizedCommand
class StringsErrorHandlerUnauthorizedCommandEs
    extends StringsErrorHandlerUnauthorizedCommandEn {
  StringsErrorHandlerUnauthorizedCommandEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'No puedes usar este comando!';
  @override
  String get description =>
      'Este comando solo puede ser usado por determinados usuarios en determinados contextos. Verifica que tienes los permisos para ejecutar este comando, o contacte a un desarrollador para más información.';
}

// Path: errorHandler.missingArguments
class StringsErrorHandlerMissingArgumentsEs
    extends StringsErrorHandlerMissingArgumentsEn {
  StringsErrorHandlerMissingArgumentsEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Faltan argumentos';
  @override
  String get description =>
      'No has proveido los argumentos necesarios para ejecutar esta función. Por favor inténtalo de nuevo y usa el Menú de Slash Command para ayuda, o contacta a un desarrollador para más información.';
}

// Path: errorHandler.inputParsingFailure
class StringsErrorHandlerInputParsingFailureEs
    extends StringsErrorHandlerInputParsingFailureEn {
  StringsErrorHandlerInputParsingFailureEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ha ocurrido un error al procesar tu entrada';
  @override
  String get description =>
      'No se ha podido ejecutar el comando ya que no hemos podido interpretar tus argumentos. Por favor inténtalo de nuevo y usa el Menú de Slash Command para ayuda, o contacta a un desarrollador para más información.';
}

// Path: commands.music.children
class StringsCommandsMusicChildrenEs extends StringsCommandsMusicChildrenEn {
  StringsCommandsMusicChildrenEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  late final StringsCommandsMusicChildrenPlayEs play =
      StringsCommandsMusicChildrenPlayEs._(_root);
}

// Path: commands.radio.children
class StringsCommandsRadioChildrenEs extends StringsCommandsRadioChildrenEn {
  StringsCommandsRadioChildrenEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  late final StringsCommandsRadioChildrenPlayEs play =
      StringsCommandsRadioChildrenPlayEs._(_root);
  @override
  late final StringsCommandsRadioChildrenRecognizeEs recognize =
      StringsCommandsRadioChildrenRecognizeEs._(_root);
  @override
  late final StringsCommandsRadioChildrenUpvoteEs upvote =
      StringsCommandsRadioChildrenUpvoteEs._(_root);
  @override
  late final StringsCommandsRadioChildrenPlayRandomEs playRandom =
      StringsCommandsRadioChildrenPlayRandomEs._(_root);
}

// Path: services.music.trackStuck
class StringsServicesMusicTrackStuckEs
    extends StringsServicesMusicTrackStuckEn {
  StringsServicesMusicTrackStuckEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'La canción se ha quedado atascada';
  @override
  String description(
          {required Object track,
          required Object uri,
          required Object requester}) =>
      'La pista [${track}](${uri}}) se ha quedado atascada.\n\nPedida por <@${requester}>';
}

// Path: services.music.trackStarted
class StringsServicesMusicTrackStartedEs
    extends StringsServicesMusicTrackStartedEn {
  StringsServicesMusicTrackStartedEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Se ha comenzado a reproducir';
  @override
  String description(
          {required Object track,
          required Object uri,
          required Object requester}) =>
      'La pista [${track}](${uri}}) se ha comenzado a reproducir.\n\nPedido por <@${requester}>';
}

// Path: services.music.trackException
class StringsServicesMusicTrackExceptionEs
    extends StringsServicesMusicTrackExceptionEn {
  StringsServicesMusicTrackExceptionEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ha ocurrido un error al reproducir la canción';
  @override
  String description(
          {required Object track,
          required Object uri,
          required Object requester}) =>
      'La pista [${track}](${uri}}) devolvió un error.\n\nPedido por <@${requester}>';
}

// Path: commands.music.children.play
class StringsCommandsMusicChildrenPlayEs
    extends StringsCommandsMusicChildrenPlayEn {
  StringsCommandsMusicChildrenPlayEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'reproducir';
  @override
  String get description => 'Reproduce música basada en una URL o una búsqueda';
  @override
  String get queryDescription => 'El nombre de una canción o una URL';
  @override
  String noResults({required Object query}) =>
      'No se encontraron resultados para ${query}';
  @override
  String playlistEnqueued({required Object name, required Object query}) =>
      'Lista de reproducción ${name} (${query}) añadida a la cola';
  @override
  String songEnqueued({required Object title, required Object query}) =>
      'Canción ${title} (${query}) añadida a la cola';
}

// Path: commands.radio.children.play
class StringsCommandsRadioChildrenPlayEs
    extends StringsCommandsRadioChildrenPlayEn {
  StringsCommandsRadioChildrenPlayEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'reproducir';
  @override
  String get description => 'Reproduce una radio basada en una búsqueda';
  @override
  String get queryDescription => 'El nombre de una estación de radio';
  @override
  String searching({required Object query}) => 'Buscando radio ${query}...';
  @override
  String noResults({required Object query}) =>
      'No se encontraron resultados para ${query}';
  @override
  String get startedPlaying => 'Se ha comenzado a reproducir';
  @override
  String startedPlayingDescription(
          {required Object radio, required Object mention}) =>
      'La radio ${radio} ha comenzado a reproducirse.\n\nPedido por ${mention}';
  @override
  String stationEnqueued({required Object name, required Object query}) =>
      'La radio ${name} (${query}) ha sido añadida a la cola';
}

// Path: commands.radio.children.recognize
class StringsCommandsRadioChildrenRecognizeEs
    extends StringsCommandsRadioChildrenRecognizeEn {
  StringsCommandsRadioChildrenRecognizeEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'reconocer';
  @override
  String get description =>
      'Reconoce la cancion que se está reproduciendo en la radio';
  @override
  String requestedBy({required Object mention}) => 'Pedido por ${mention}';
  @override
  String get radioStationField => 'Estación';
  @override
  String get genreField => 'Género';
  @override
  String get computationalTimeField => 'Tiempo de cálculo';
  @override
  late final StringsCommandsRadioChildrenRecognizeErrorsEs errors =
      StringsCommandsRadioChildrenRecognizeErrorsEs._(_root);
}

// Path: commands.radio.children.upvote
class StringsCommandsRadioChildrenUpvoteEs
    extends StringsCommandsRadioChildrenUpvoteEn {
  StringsCommandsRadioChildrenUpvoteEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'votar';
  @override
  String get description =>
      'Vota positivamente por la radio que se está reproduciendo';
  @override
  String requestedBy({required Object mention}) => 'Pedido por ${mention}';
  @override
  String get success => 'Voto positivo añadido';
  @override
  String successDescription({required Object radio}) =>
      'Has votado positivamente por la radio ${radio}! Gracias por tu apoyo :D';
  @override
  late final StringsCommandsRadioChildrenUpvoteErrorsEs errors =
      StringsCommandsRadioChildrenUpvoteErrorsEs._(_root);
}

// Path: commands.radio.children.playRandom
class StringsCommandsRadioChildrenPlayRandomEs
    extends StringsCommandsRadioChildrenPlayRandomEn {
  StringsCommandsRadioChildrenPlayRandomEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get command => 'play-random';
  @override
  String get description => 'Reproduce una radio aleatoria';
  @override
  String get searching => 'Buscando una radio aleatoria...';
  @override
  String get startedPlaying => 'Se ha comenzado a reproducir';
  @override
  String startedPlayingDescription(
          {required Object radio, required Object mention}) =>
      'La radio ${radio} ha comenzado a reproducirse.\n\nPedido por ${mention}';
  @override
  late final StringsCommandsRadioChildrenPlayRandomErrorsEs errors =
      StringsCommandsRadioChildrenPlayRandomErrorsEs._(_root);
}

// Path: commands.radio.children.recognize.errors
class StringsCommandsRadioChildrenRecognizeErrorsEs
    extends StringsCommandsRadioChildrenRecognizeErrorsEn {
  StringsCommandsRadioChildrenRecognizeErrorsEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get title => 'Ha ocurrido un error al reconocer la canción';
  @override
  String get noRadioPlaying => 'No se está reproduciendo ninguna radio';
  @override
  String get radioCantCommunicate =>
      'La radio no puede comunicarse con el servidor de reconocimiento de canciones. Inténtalo de nuevo más tarde';
  @override
  String get noResults =>
      'No se han encontrado resultados para la canción que se está reproduciendo :(';
}

// Path: commands.radio.children.upvote.errors
class StringsCommandsRadioChildrenUpvoteErrorsEs
    extends StringsCommandsRadioChildrenUpvoteErrorsEn {
  StringsCommandsRadioChildrenUpvoteErrorsEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get noRadioPlaying => 'No se está reproduciendo ninguna radio';
}

// Path: commands.radio.children.playRandom.errors
class StringsCommandsRadioChildrenPlayRandomErrorsEs
    extends StringsCommandsRadioChildrenPlayRandomErrorsEn {
  StringsCommandsRadioChildrenPlayRandomErrorsEs._(StringsEs root)
      : this._root = root,
        super._(root);

  @override
  final StringsEs _root; // ignore: unused_field

  // Translations
  @override
  String get noResults =>
      'No se ha podido encontrar una radio aleatoria :( Inténtalo de nuevo más tarde!';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on StringsEn {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'commands.info.command':
        return 'info';
      case 'commands.info.description':
        return 'Show information about the current project';
      case 'commands.info.addToServer':
        return 'Add Radio Horizon to your server';
      case 'commands.info.shardOf':
        return ({required Object index, required Object count}) =>
            'Shard ${index} of ${count}';
      case 'commands.info.cachedGuilds':
        return 'Cached guilds';
      case 'commands.info.cachedUsers':
        return 'Cached users';
      case 'commands.info.cachedChannels':
        return 'Cached channels';
      case 'commands.info.cachedVoiceStates':
        return 'Cached voice states';
      case 'commands.info.shardCount':
        return 'Shard count';
      case 'commands.info.cachedMessages':
        return 'Cached messages';
      case 'commands.info.memoryUsage':
        return 'Memory usage (current/RSS)';
      case 'commands.info.uptime':
        return 'Uptime';
      case 'commands.info.currentPlayers':
        return 'Current players';
      case 'commands.info.gatewayLatency':
        return 'Gateway latency';
      case 'commands.skip.command':
        return 'skip';
      case 'commands.skip.description':
        return 'Skips the current song';
      case 'commands.skip.skipped':
        return 'Skipped current track';
      case 'commands.skip.nothingPlaying':
        return 'The queue is clear!';
      case 'commands.stop.command':
        return 'stop';
      case 'commands.stop.description':
        return 'Stops the current player and clears its track queue';
      case 'commands.stop.stopped':
        return 'Player stopped';
      case 'commands.leave.command':
        return 'leave';
      case 'commands.leave.description':
        return 'Leaves the current voice channel';
      case 'commands.leave.left':
        return 'Left voice channel';
      case 'commands.leave.leftDueToInactivity':
        return 'Left voice channel due to inactivity';
      case 'commands.join.command':
        return 'join';
      case 'commands.join.description':
        return 'Joins the voice channel you are in';
      case 'commands.join.joined':
        return 'Joined voice channel';
      case 'commands.volume.command':
        return 'volume';
      case 'commands.volume.description':
        return 'Sets the volume of the current player';
      case 'commands.volume.volumeDescription':
        return 'The volume to set, this value must be contained between 0 and 1000';
      case 'commands.volume.volumeSet':
        return ({required Object volume}) => 'Volume set to ${volume}';
      case 'commands.pause.command':
        return 'pause';
      case 'commands.pause.description':
        return 'Pauses the current player';
      case 'commands.pause.paused':
        return 'Player paused';
      case 'commands.resume.command':
        return 'resume';
      case 'commands.resume.description':
        return 'Resumes the current player';
      case 'commands.resume.resumed':
        return 'Player resumed';
      case 'commands.music.command':
        return 'music';
      case 'commands.music.description':
        return 'Music related commands';
      case 'commands.music.children.play.command':
        return 'play';
      case 'commands.music.children.play.description':
        return 'Plays music based on the given query';
      case 'commands.music.children.play.queryDescription':
        return 'The name/url of the song/playlist to play';
      case 'commands.music.children.play.noResults':
        return ({required Object query}) => 'No results found for ${query}';
      case 'commands.music.children.play.playlistEnqueued':
        return ({required Object name, required Object query}) =>
            'Playlist ${name} (${query}) enqueued';
      case 'commands.music.children.play.songEnqueued':
        return ({required Object title, required Object query}) =>
            'Song ${title} (${query}) enqueued';
      case 'commands.radio.command':
        return 'radio';
      case 'commands.radio.description':
        return 'Radio related commands';
      case 'commands.radio.children.play.command':
        return 'play';
      case 'commands.radio.children.play.description':
        return 'Plays a radio station based on the given query';
      case 'commands.radio.children.play.queryDescription':
        return 'The name of the radio station to play';
      case 'commands.radio.children.play.searching':
        return ({required Object query}) => 'Searching for radio ${query}...';
      case 'commands.radio.children.play.noResults':
        return ({required Object query}) => 'No results found for ${query}';
      case 'commands.radio.children.play.startedPlaying':
        return 'Started playing';
      case 'commands.radio.children.play.startedPlayingDescription':
        return ({required Object radio, required Object mention}) =>
            'Radio ${radio} started playing.\n\nRequested by ${mention}';
      case 'commands.radio.children.play.stationEnqueued':
        return ({required Object name, required Object query}) =>
            'Station ${name} (${query}) enqueued';
      case 'commands.radio.children.recognize.command':
        return 'recognize';
      case 'commands.radio.children.recognize.description':
        return 'Recognizes the current song playing';
      case 'commands.radio.children.recognize.requestedBy':
        return ({required Object mention}) => 'Requested by ${mention}';
      case 'commands.radio.children.recognize.radioStationField':
        return 'Radio Station';
      case 'commands.radio.children.recognize.genreField':
        return 'Genre';
      case 'commands.radio.children.recognize.computationalTimeField':
        return 'Computational time';
      case 'commands.radio.children.recognize.errors.title':
        return 'An error occurred while recognizing the song';
      case 'commands.radio.children.recognize.errors.noRadioPlaying':
        return 'Couldn\'t find a radio playing!';
      case 'commands.radio.children.recognize.errors.radioCantCommunicate':
        return 'There was an error communicating with the server, please try again.';
      case 'commands.radio.children.recognize.errors.noResults':
        return 'Couldn\'t identify the current song playing :(';
      case 'commands.radio.children.upvote.command':
        return 'upvote';
      case 'commands.radio.children.upvote.description':
        return 'Upvotes the current radio playing';
      case 'commands.radio.children.upvote.requestedBy':
        return ({required Object mention}) => 'Requested by ${mention}';
      case 'commands.radio.children.upvote.success':
        return 'Voted successfully';
      case 'commands.radio.children.upvote.successDescription':
        return ({required Object radio}) =>
            'You have successfully voted for the radio ${radio}! Thank you for your support :D';
      case 'commands.radio.children.upvote.errors.noRadioPlaying':
        return 'Couldn\'t find a radio playing!';
      case 'commands.radio.children.playRandom.command':
        return 'play-random';
      case 'commands.radio.children.playRandom.description':
        return 'Plays a random radio station';
      case 'commands.radio.children.playRandom.searching':
        return 'Searching for a random radio station...';
      case 'commands.radio.children.playRandom.startedPlaying':
        return 'Started playing';
      case 'commands.radio.children.playRandom.startedPlayingDescription':
        return ({required Object radio, required Object mention}) =>
            'Radio ${radio} started playing.\n\nRequested by ${mention}';
      case 'commands.radio.children.playRandom.errors.noResults':
        return 'Couldn\'t find a random radio station :( Try again later!';
      case 'services.music.trackStuck.title':
        return 'Track stuck';
      case 'services.music.trackStuck.description':
        return (
                {required Object track,
                required Object uri,
                required Object requester}) =>
            'Track [${track}](${uri}}) stuck playing.\n\nRequested by <@${requester}>';
      case 'services.music.trackStarted.title':
        return 'Track started';
      case 'services.music.trackStarted.description':
        return (
                {required Object track,
                required Object uri,
                required Object requester}) =>
            'Track [${track}](${uri}}) started playing.\n\nRequested by <@${requester}>';
      case 'services.music.trackException.title':
        return 'Track exception';
      case 'services.music.trackException.description':
        return (
                {required Object track,
                required Object uri,
                required Object requester}) =>
            'Track [${track}](${uri}}) threw an exception.\n\nRequested by <@${requester}>';
      case 'errorHandler.title':
        return 'An error has occurred';
      case 'errorHandler.fallbackDescription':
        return 'Your command couldn\'t be executed because of an error. Please contact a developer for more information.';
      case 'errorHandler.musicConnectedToVC':
        return 'I have to be in a voice channel to use this command';
      case 'errorHandler.musicNotConnectedToVC':
        return 'I\'m already connected to a voice channel';
      case 'errorHandler.musicSameVC':
        return 'I\'m already being used on other voice channel';
      case 'errorHandler.musicUserConnectedToVC':
        return 'You need to be connected to a voice channel to use this command';
      case 'errorHandler.cooldown.title':
        return 'Command on cooldown';
      case 'errorHandler.cooldown.description':
        return ({required Object inSeconds}) =>
            'You can\'t use this command right now because it is on cooldown. Please wait ${inSeconds}s and try again.';
      case 'errorHandler.unauthorizedCommand.title':
        return 'You can\'t use this command!';
      case 'errorHandler.unauthorizedCommand.description':
        return 'This command can only be used by certain users in certain contexts. Check that you have permission to execute the command, or contact a developer for more information.';
      case 'errorHandler.missingArguments.title':
        return 'Not enough arguments';
      case 'errorHandler.missingArguments.description':
        return 'You didn\'t provide enough arguments for this command. Please try again and use the Slash Command menu for help, or contact a developer for more information.';
      case 'errorHandler.inputParsingFailure.title':
        return 'Couldn\'t parse input';
      case 'errorHandler.inputParsingFailure.description':
        return 'Your command couldn\'t be executed because we were unable to understand your input. Please try again with different inputs or contact a developer for more information.';
      default:
        return null;
    }
  }
}

extension on StringsEs {
  dynamic _flatMapFunction(String path) {
    switch (path) {
      case 'commands.info.command':
        return 'info';
      case 'commands.info.description':
        return 'Muestra información sobre el bot';
      case 'commands.info.addToServer':
        return 'Añadir Radio Horizon a mi servidor';
      case 'commands.info.shardOf':
        return ({required Object index, required Object count}) =>
            'Fragmento ${index} de ${count}';
      case 'commands.info.cachedGuilds':
        return 'Servidores en caché';
      case 'commands.info.cachedUsers':
        return 'Usuarios en caché';
      case 'commands.info.cachedChannels':
        return 'Canales en caché';
      case 'commands.info.cachedVoiceStates':
        return 'Estados de voz en caché';
      case 'commands.info.shardCount':
        return 'Fragmentos';
      case 'commands.info.cachedMessages':
        return 'Mensajes en caché';
      case 'commands.info.memoryUsage':
        return 'Uso de memoria (current/RSS)';
      case 'commands.info.uptime':
        return 'Tiempo de actividad';
      case 'commands.info.currentPlayers':
        return 'Reproductores actuales';
      case 'commands.info.gatewayLatency':
        return 'Latencia de la puerta de enlace';
      case 'commands.skip.command':
        return 'saltar';
      case 'commands.skip.description':
        return 'Salta a la siguiente canción en la cola';
      case 'commands.skip.skipped':
        return 'La canción actual ha sido saltada';
      case 'commands.skip.nothingPlaying':
        return 'La cola está vacía';
      case 'commands.stop.command':
        return 'parar';
      case 'commands.stop.description':
        return 'Para la reproducción de música';
      case 'commands.stop.stopped':
        return 'La reproducción de música ha sido detenida';
      case 'commands.leave.command':
        return 'dejar';
      case 'commands.leave.description':
        return 'Abandona el canal de voz';
      case 'commands.leave.left':
        return 'El canal de voz ha sido abandonado';
      case 'commands.leave.leftDueToInactivity':
        return 'El canal de voz ha sido abandonado debido a la inactividad';
      case 'commands.join.command':
        return 'unirse';
      case 'commands.join.description':
        return 'Se une al canal de voz en el que estás';
      case 'commands.join.joined':
        return 'Se ha unido al canal de voz';
      case 'commands.volume.command':
        return 'volumen';
      case 'commands.volume.description':
        return 'Establece el volumen de la música';
      case 'commands.volume.volumeDescription':
        return 'El volumen para establecer, debe ser un valor entre 0 y 1000';
      case 'commands.volume.volumeSet':
        return ({required Object volume}) => 'Volumen puesto en ${volume}';
      case 'commands.pause.command':
        return 'pausar';
      case 'commands.pause.description':
        return 'Pausa la reproducción de música';
      case 'commands.pause.paused':
        return 'La reproducción de música ha sido pausada';
      case 'commands.resume.command':
        return 'reanudar';
      case 'commands.resume.description':
        return 'Reanuda la reproducción de música';
      case 'commands.resume.resumed':
        return 'La reproducción de música ha sido reanudada';
      case 'commands.music.command':
        return 'musica';
      case 'commands.music.description':
        return 'Comandos relacionados con la funcionalidad de música';
      case 'commands.music.children.play.command':
        return 'reproducir';
      case 'commands.music.children.play.description':
        return 'Reproduce música basada en una URL o una búsqueda';
      case 'commands.music.children.play.queryDescription':
        return 'El nombre de una canción o una URL';
      case 'commands.music.children.play.noResults':
        return ({required Object query}) =>
            'No se encontraron resultados para ${query}';
      case 'commands.music.children.play.playlistEnqueued':
        return ({required Object name, required Object query}) =>
            'Lista de reproducción ${name} (${query}) añadida a la cola';
      case 'commands.music.children.play.songEnqueued':
        return ({required Object title, required Object query}) =>
            'Canción ${title} (${query}) añadida a la cola';
      case 'commands.radio.command':
        return 'radio';
      case 'commands.radio.description':
        return 'Comandos relacionados con la funcionalidad de radio';
      case 'commands.radio.children.play.command':
        return 'reproducir';
      case 'commands.radio.children.play.description':
        return 'Reproduce una radio basada en una búsqueda';
      case 'commands.radio.children.play.queryDescription':
        return 'El nombre de una estación de radio';
      case 'commands.radio.children.play.searching':
        return ({required Object query}) => 'Buscando radio ${query}...';
      case 'commands.radio.children.play.noResults':
        return ({required Object query}) =>
            'No se encontraron resultados para ${query}';
      case 'commands.radio.children.play.startedPlaying':
        return 'Se ha comenzado a reproducir';
      case 'commands.radio.children.play.startedPlayingDescription':
        return ({required Object radio, required Object mention}) =>
            'La radio ${radio} ha comenzado a reproducirse.\n\nPedido por ${mention}';
      case 'commands.radio.children.play.stationEnqueued':
        return ({required Object name, required Object query}) =>
            'La radio ${name} (${query}) ha sido añadida a la cola';
      case 'commands.radio.children.recognize.command':
        return 'reconocer';
      case 'commands.radio.children.recognize.description':
        return 'Reconoce la cancion que se está reproduciendo en la radio';
      case 'commands.radio.children.recognize.requestedBy':
        return ({required Object mention}) => 'Pedido por ${mention}';
      case 'commands.radio.children.recognize.radioStationField':
        return 'Estación';
      case 'commands.radio.children.recognize.genreField':
        return 'Género';
      case 'commands.radio.children.recognize.computationalTimeField':
        return 'Tiempo de cálculo';
      case 'commands.radio.children.recognize.errors.title':
        return 'Ha ocurrido un error al reconocer la canción';
      case 'commands.radio.children.recognize.errors.noRadioPlaying':
        return 'No se está reproduciendo ninguna radio';
      case 'commands.radio.children.recognize.errors.radioCantCommunicate':
        return 'La radio no puede comunicarse con el servidor de reconocimiento de canciones. Inténtalo de nuevo más tarde';
      case 'commands.radio.children.recognize.errors.noResults':
        return 'No se han encontrado resultados para la canción que se está reproduciendo :(';
      case 'commands.radio.children.upvote.command':
        return 'votar';
      case 'commands.radio.children.upvote.description':
        return 'Vota positivamente por la radio que se está reproduciendo';
      case 'commands.radio.children.upvote.requestedBy':
        return ({required Object mention}) => 'Pedido por ${mention}';
      case 'commands.radio.children.upvote.success':
        return 'Voto positivo añadido';
      case 'commands.radio.children.upvote.successDescription':
        return ({required Object radio}) =>
            'Has votado positivamente por la radio ${radio}! Gracias por tu apoyo :D';
      case 'commands.radio.children.upvote.errors.noRadioPlaying':
        return 'No se está reproduciendo ninguna radio';
      case 'commands.radio.children.playRandom.command':
        return 'play-random';
      case 'commands.radio.children.playRandom.description':
        return 'Reproduce una radio aleatoria';
      case 'commands.radio.children.playRandom.searching':
        return 'Buscando una radio aleatoria...';
      case 'commands.radio.children.playRandom.startedPlaying':
        return 'Se ha comenzado a reproducir';
      case 'commands.radio.children.playRandom.startedPlayingDescription':
        return ({required Object radio, required Object mention}) =>
            'La radio ${radio} ha comenzado a reproducirse.\n\nPedido por ${mention}';
      case 'commands.radio.children.playRandom.errors.noResults':
        return 'No se ha podido encontrar una radio aleatoria :( Inténtalo de nuevo más tarde!';
      case 'services.music.trackStuck.title':
        return 'La canción se ha quedado atascada';
      case 'services.music.trackStuck.description':
        return (
                {required Object track,
                required Object uri,
                required Object requester}) =>
            'La pista [${track}](${uri}}) se ha quedado atascada.\n\nPedida por <@${requester}>';
      case 'services.music.trackStarted.title':
        return 'Se ha comenzado a reproducir';
      case 'services.music.trackStarted.description':
        return (
                {required Object track,
                required Object uri,
                required Object requester}) =>
            'La pista [${track}](${uri}}) se ha comenzado a reproducir.\n\nPedido por <@${requester}>';
      case 'services.music.trackException.title':
        return 'Ha ocurrido un error al reproducir la canción';
      case 'services.music.trackException.description':
        return (
                {required Object track,
                required Object uri,
                required Object requester}) =>
            'La pista [${track}](${uri}}) devolvió un error.\n\nPedido por <@${requester}>';
      case 'errorHandler.title':
        return 'Ha ocurrido un error';
      case 'errorHandler.fallbackDescription':
        return 'Tu comando no se ha podido ejecutar debido a un error desconocido. Por favor contacte a un desarrollador para más información.';
      case 'errorHandler.musicConnectedToVC':
        return 'Debo estar conectado a un canal de voz para ejecutar este comando';
      case 'errorHandler.musicNotConnectedToVC':
        return 'Ya estoy conectado a un canal de voz';
      case 'errorHandler.musicSameVC':
        return 'Debes estar en el mismo canal de voz que yo para ejecutar este comando';
      case 'errorHandler.musicUserConnectedToVC':
        return 'Debes estar conectado a un canal de voz para ejecutar este comando';
      case 'errorHandler.cooldown.title':
        return 'Commando en cooldown';
      case 'errorHandler.cooldown.description':
        return ({required Object inSeconds}) =>
            'No puedes usar este comando ahora mismo porque está en cooldown. Por favor espera ${inSeconds}s e inténtalo de nuevo.';
      case 'errorHandler.unauthorizedCommand.title':
        return 'No puedes usar este comando!';
      case 'errorHandler.unauthorizedCommand.description':
        return 'Este comando solo puede ser usado por determinados usuarios en determinados contextos. Verifica que tienes los permisos para ejecutar este comando, o contacte a un desarrollador para más información.';
      case 'errorHandler.missingArguments.title':
        return 'Faltan argumentos';
      case 'errorHandler.missingArguments.description':
        return 'No has proveido los argumentos necesarios para ejecutar esta función. Por favor inténtalo de nuevo y usa el Menú de Slash Command para ayuda, o contacta a un desarrollador para más información.';
      case 'errorHandler.inputParsingFailure.title':
        return 'Ha ocurrido un error al procesar tu entrada';
      case 'errorHandler.inputParsingFailure.description':
        return 'No se ha podido ejecutar el comando ya que no hemos podido interpretar tus argumentos. Por favor inténtalo de nuevo y usa el Menú de Slash Command para ayuda, o contacta a un desarrollador para más información.';
      default:
        return null;
    }
  }
}
