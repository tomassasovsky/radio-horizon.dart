///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final TranslationsCommandsEn commands = TranslationsCommandsEn.internal(_root);
	late final TranslationsServicesEn services = TranslationsServicesEn.internal(_root);
	late final TranslationsErrorHandlerEn errorHandler = TranslationsErrorHandlerEn.internal(_root);
}

// Path: commands
class TranslationsCommandsEn {
	TranslationsCommandsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsCommandsInfoEn info = TranslationsCommandsInfoEn.internal(_root);
	late final TranslationsCommandsSkipEn skip = TranslationsCommandsSkipEn.internal(_root);
	late final TranslationsCommandsStopEn stop = TranslationsCommandsStopEn.internal(_root);
	late final TranslationsCommandsLeaveEn leave = TranslationsCommandsLeaveEn.internal(_root);
	late final TranslationsCommandsJoinEn join = TranslationsCommandsJoinEn.internal(_root);
	late final TranslationsCommandsVolumeEn volume = TranslationsCommandsVolumeEn.internal(_root);
	late final TranslationsCommandsPauseEn pause = TranslationsCommandsPauseEn.internal(_root);
	late final TranslationsCommandsResumeEn resume = TranslationsCommandsResumeEn.internal(_root);
	late final TranslationsCommandsMusicEn music = TranslationsCommandsMusicEn.internal(_root);
	late final TranslationsCommandsRadioEn radio = TranslationsCommandsRadioEn.internal(_root);
}

// Path: services
class TranslationsServicesEn {
	TranslationsServicesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsServicesMusicEn music = TranslationsServicesMusicEn.internal(_root);
}

// Path: errorHandler
class TranslationsErrorHandlerEn {
	TranslationsErrorHandlerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'An error has occurred';
	String get fallbackDescription => 'Your command couldn\'t be executed because of an error. Please contact a developer for more information.';
	String get musicConnectedToVC => 'I have to be in a voice channel to use this command';
	String get musicNotConnectedToVC => 'I\'m already connected to a voice channel';
	String get musicSameVC => 'I\'m already being used on other voice channel';
	String get musicUserConnectedToVC => 'You need to be connected to a voice channel to use this command';
	late final TranslationsErrorHandlerCooldownEn cooldown = TranslationsErrorHandlerCooldownEn.internal(_root);
	late final TranslationsErrorHandlerUnauthorizedCommandEn unauthorizedCommand = TranslationsErrorHandlerUnauthorizedCommandEn.internal(_root);
	late final TranslationsErrorHandlerMissingArgumentsEn missingArguments = TranslationsErrorHandlerMissingArgumentsEn.internal(_root);
	late final TranslationsErrorHandlerInputParsingFailureEn inputParsingFailure = TranslationsErrorHandlerInputParsingFailureEn.internal(_root);
}

// Path: commands.info
class TranslationsCommandsInfoEn {
	TranslationsCommandsInfoEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'info';
	String get description => 'Show information about the current project';
	String get addToServer => 'Add Radio Horizon to your server';
	String shardOf({required Object index, required Object count}) => 'Shard ${index} of ${count}';
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
	String get viewOnGithub => 'View on GitHub';
}

// Path: commands.skip
class TranslationsCommandsSkipEn {
	TranslationsCommandsSkipEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'skip';
	String get description => 'Skips the current song';
	String get skipped => 'Skipped current track';
	String get nothingPlaying => 'The queue is clear!';
}

// Path: commands.stop
class TranslationsCommandsStopEn {
	TranslationsCommandsStopEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'stop';
	String get description => 'Stops the current player and clears its track queue';
	String get stopped => 'Player stopped';
}

// Path: commands.leave
class TranslationsCommandsLeaveEn {
	TranslationsCommandsLeaveEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'leave';
	String get description => 'Leaves the current voice channel';
	String get left => 'Left voice channel';
	String get leftDueToInactivity => 'Left voice channel due to inactivity';
}

// Path: commands.join
class TranslationsCommandsJoinEn {
	TranslationsCommandsJoinEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'join';
	String get description => 'Joins the voice channel you are in';
	String get joined => 'Joined voice channel';
}

// Path: commands.volume
class TranslationsCommandsVolumeEn {
	TranslationsCommandsVolumeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'volume';
	String get description => 'Sets the volume of the current player';
	String get volumeDescription => 'The volume to set, this value must be contained between 0 and 1000';
	String volumeSet({required Object volume}) => 'Volume set to ${volume}';
}

// Path: commands.pause
class TranslationsCommandsPauseEn {
	TranslationsCommandsPauseEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'pause';
	String get description => 'Pauses the current player';
	String get paused => 'Player paused';
}

// Path: commands.resume
class TranslationsCommandsResumeEn {
	TranslationsCommandsResumeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'resume';
	String get description => 'Resumes the current player';
	String get resumed => 'Player resumed';
}

// Path: commands.music
class TranslationsCommandsMusicEn {
	TranslationsCommandsMusicEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'music';
	String get description => 'Music related commands';
	late final TranslationsCommandsMusicChildrenEn children = TranslationsCommandsMusicChildrenEn.internal(_root);
}

// Path: commands.radio
class TranslationsCommandsRadioEn {
	TranslationsCommandsRadioEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'radio';
	String get description => 'Radio related commands';
	late final TranslationsCommandsRadioChildrenEn children = TranslationsCommandsRadioChildrenEn.internal(_root);
}

// Path: services.music
class TranslationsServicesMusicEn {
	TranslationsServicesMusicEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsServicesMusicTrackStuckEn trackStuck = TranslationsServicesMusicTrackStuckEn.internal(_root);
	late final TranslationsServicesMusicTrackStartedEn trackStarted = TranslationsServicesMusicTrackStartedEn.internal(_root);
	late final TranslationsServicesMusicTrackExceptionEn trackException = TranslationsServicesMusicTrackExceptionEn.internal(_root);
}

// Path: errorHandler.cooldown
class TranslationsErrorHandlerCooldownEn {
	TranslationsErrorHandlerCooldownEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Command on cooldown';
	String description({required Object inSeconds}) => 'You can\'t use this command right now because it is on cooldown. Please wait ${inSeconds}s and try again.';
}

// Path: errorHandler.unauthorizedCommand
class TranslationsErrorHandlerUnauthorizedCommandEn {
	TranslationsErrorHandlerUnauthorizedCommandEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'You can\'t use this command!';
	String get description => 'This command can only be used by certain users in certain contexts. Check that you have permission to execute the command, or contact a developer for more information.';
}

// Path: errorHandler.missingArguments
class TranslationsErrorHandlerMissingArgumentsEn {
	TranslationsErrorHandlerMissingArgumentsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Not enough arguments';
	String get description => 'You didn\'t provide enough arguments for this command. Please try again and use the Slash Command menu for help, or contact a developer for more information.';
}

// Path: errorHandler.inputParsingFailure
class TranslationsErrorHandlerInputParsingFailureEn {
	TranslationsErrorHandlerInputParsingFailureEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Couldn\'t parse input';
	String get description => 'Your command couldn\'t be executed because we were unable to understand your input. Please try again with different inputs or contact a developer for more information.';
}

// Path: commands.music.children
class TranslationsCommandsMusicChildrenEn {
	TranslationsCommandsMusicChildrenEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsCommandsMusicChildrenPlayEn play = TranslationsCommandsMusicChildrenPlayEn.internal(_root);
}

// Path: commands.radio.children
class TranslationsCommandsRadioChildrenEn {
	TranslationsCommandsRadioChildrenEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsCommandsRadioChildrenPlayEn play = TranslationsCommandsRadioChildrenPlayEn.internal(_root);
	late final TranslationsCommandsRadioChildrenRecognizeEn recognize = TranslationsCommandsRadioChildrenRecognizeEn.internal(_root);
	late final TranslationsCommandsRadioChildrenUpvoteEn upvote = TranslationsCommandsRadioChildrenUpvoteEn.internal(_root);
	late final TranslationsCommandsRadioChildrenPlayRandomEn playRandom = TranslationsCommandsRadioChildrenPlayRandomEn.internal(_root);
}

// Path: services.music.trackStuck
class TranslationsServicesMusicTrackStuckEn {
	TranslationsServicesMusicTrackStuckEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Track stuck';
	String description({required Object track, required Object uri, required Object requester}) => 'Track [${track}](${uri}}) stuck playing.\n\nRequested by <@${requester}>';
}

// Path: services.music.trackStarted
class TranslationsServicesMusicTrackStartedEn {
	TranslationsServicesMusicTrackStartedEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Track started';
	String description({required Object track, required Object uri, required Object requester}) => 'Track [${track}](${uri}}) started playing.\n\nRequested by <@${requester}>';
}

// Path: services.music.trackException
class TranslationsServicesMusicTrackExceptionEn {
	TranslationsServicesMusicTrackExceptionEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Track exception';
	String description({required Object track, required Object uri, required Object requester}) => 'Track [${track}](${uri}}) threw an exception.\n\nRequested by <@${requester}>';
}

// Path: commands.music.children.play
class TranslationsCommandsMusicChildrenPlayEn {
	TranslationsCommandsMusicChildrenPlayEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'play';
	String get description => 'Plays music based on the given query';
	String get queryDescription => 'The name/url of the song/playlist to play';
	String noResults({required Object query}) => 'No results found for ${query}';
	String playlistEnqueued({required Object name, required Object query}) => 'Playlist ${name} (${query}) enqueued';
	String songEnqueued({required Object title, required Object query}) => 'Song ${title} (${query}) enqueued';
	late final TranslationsCommandsMusicChildrenPlayChildrenEn children = TranslationsCommandsMusicChildrenPlayChildrenEn.internal(_root);
}

// Path: commands.radio.children.play
class TranslationsCommandsRadioChildrenPlayEn {
	TranslationsCommandsRadioChildrenPlayEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'play';
	String get description => 'Plays a radio station based on the given query';
	String get queryDescription => 'The name of the radio station to play';
	String searching({required Object query}) => 'Searching for radio ${query}...';
	String noResults({required Object query}) => 'No results found for ${query}';
	String get startedPlaying => 'Started playing';
	String startedPlayingDescription({required Object radio, required Object mention}) => 'Radio ${radio} started playing.\n\nRequested by ${mention}';
	String stationEnqueued({required Object name, required Object query}) => 'Station ${name} (${query}) enqueued';
}

// Path: commands.radio.children.recognize
class TranslationsCommandsRadioChildrenRecognizeEn {
	TranslationsCommandsRadioChildrenRecognizeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'recognize';
	String get description => 'Recognizes the current song playing';
	String requestedBy({required Object mention}) => 'Requested by ${mention}';
	String get radioStationField => 'Radio Station';
	String get genreField => 'Genre';
	String get computationalTimeField => 'Computational time';
	late final TranslationsCommandsRadioChildrenRecognizeErrorsEn errors = TranslationsCommandsRadioChildrenRecognizeErrorsEn.internal(_root);
}

// Path: commands.radio.children.upvote
class TranslationsCommandsRadioChildrenUpvoteEn {
	TranslationsCommandsRadioChildrenUpvoteEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'upvote';
	String get description => 'Upvotes the current radio playing';
	String requestedBy({required Object mention}) => 'Requested by ${mention}';
	String get success => 'Voted successfully';
	String successDescription({required Object radio}) => 'You have successfully voted for the radio ${radio}! Thank you for your support :D';
	late final TranslationsCommandsRadioChildrenUpvoteErrorsEn errors = TranslationsCommandsRadioChildrenUpvoteErrorsEn.internal(_root);
}

// Path: commands.radio.children.playRandom
class TranslationsCommandsRadioChildrenPlayRandomEn {
	TranslationsCommandsRadioChildrenPlayRandomEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'play-random';
	String get description => 'Plays a random radio station';
	String get searching => 'Searching for a random radio station...';
	String get startedPlaying => 'Started playing';
	String startedPlayingDescription({required Object radio, required Object mention}) => 'Radio ${radio} started playing.\n\nRequested by ${mention}';
	late final TranslationsCommandsRadioChildrenPlayRandomErrorsEn errors = TranslationsCommandsRadioChildrenPlayRandomErrorsEn.internal(_root);
}

// Path: commands.music.children.play.children
class TranslationsCommandsMusicChildrenPlayChildrenEn {
	TranslationsCommandsMusicChildrenPlayChildrenEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsCommandsMusicChildrenPlayChildrenYoutubeEn youtube = TranslationsCommandsMusicChildrenPlayChildrenYoutubeEn.internal(_root);
	late final TranslationsCommandsMusicChildrenPlayChildrenDeezerEn deezer = TranslationsCommandsMusicChildrenPlayChildrenDeezerEn.internal(_root);
}

// Path: commands.radio.children.recognize.errors
class TranslationsCommandsRadioChildrenRecognizeErrorsEn {
	TranslationsCommandsRadioChildrenRecognizeErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'An error occurred while recognizing the song';
	String get noRadioPlaying => 'Couldn\'t find a radio playing!';
	String get radioCantCommunicate => 'There was an error communicating with the server, please try again.';
	String get noResults => 'Couldn\'t identify the current song playing :(';
}

// Path: commands.radio.children.upvote.errors
class TranslationsCommandsRadioChildrenUpvoteErrorsEn {
	TranslationsCommandsRadioChildrenUpvoteErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get noRadioPlaying => 'Couldn\'t find a radio playing!';
}

// Path: commands.radio.children.playRandom.errors
class TranslationsCommandsRadioChildrenPlayRandomErrorsEn {
	TranslationsCommandsRadioChildrenPlayRandomErrorsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get noResults => 'Couldn\'t find a random radio station :( Try again later!';
}

// Path: commands.music.children.play.children.youtube
class TranslationsCommandsMusicChildrenPlayChildrenYoutubeEn {
	TranslationsCommandsMusicChildrenPlayChildrenYoutubeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'youtube';
	String get description => 'Plays music from YouTube';
	String searching({required Object query}) => 'Searching for ${query} on YouTube...';
	String noResults({required Object query}) => 'No results found for ${query}';
}

// Path: commands.music.children.play.children.deezer
class TranslationsCommandsMusicChildrenPlayChildrenDeezerEn {
	TranslationsCommandsMusicChildrenPlayChildrenDeezerEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get command => 'deezer';
	String get description => 'Plays music from Deezer';
	String searching({required Object query}) => 'Searching for ${query} on Deezer...';
	String noResults({required Object query}) => 'No results found for ${query}';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'commands.info.command': return 'info';
			case 'commands.info.description': return 'Show information about the current project';
			case 'commands.info.addToServer': return 'Add Radio Horizon to your server';
			case 'commands.info.shardOf': return ({required Object index, required Object count}) => 'Shard ${index} of ${count}';
			case 'commands.info.cachedGuilds': return 'Cached guilds';
			case 'commands.info.cachedUsers': return 'Cached users';
			case 'commands.info.cachedChannels': return 'Cached channels';
			case 'commands.info.cachedVoiceStates': return 'Cached voice states';
			case 'commands.info.shardCount': return 'Shard count';
			case 'commands.info.cachedMessages': return 'Cached messages';
			case 'commands.info.memoryUsage': return 'Memory usage (current/RSS)';
			case 'commands.info.uptime': return 'Uptime';
			case 'commands.info.currentPlayers': return 'Current players';
			case 'commands.info.gatewayLatency': return 'Gateway latency';
			case 'commands.info.viewOnGithub': return 'View on GitHub';
			case 'commands.skip.command': return 'skip';
			case 'commands.skip.description': return 'Skips the current song';
			case 'commands.skip.skipped': return 'Skipped current track';
			case 'commands.skip.nothingPlaying': return 'The queue is clear!';
			case 'commands.stop.command': return 'stop';
			case 'commands.stop.description': return 'Stops the current player and clears its track queue';
			case 'commands.stop.stopped': return 'Player stopped';
			case 'commands.leave.command': return 'leave';
			case 'commands.leave.description': return 'Leaves the current voice channel';
			case 'commands.leave.left': return 'Left voice channel';
			case 'commands.leave.leftDueToInactivity': return 'Left voice channel due to inactivity';
			case 'commands.join.command': return 'join';
			case 'commands.join.description': return 'Joins the voice channel you are in';
			case 'commands.join.joined': return 'Joined voice channel';
			case 'commands.volume.command': return 'volume';
			case 'commands.volume.description': return 'Sets the volume of the current player';
			case 'commands.volume.volumeDescription': return 'The volume to set, this value must be contained between 0 and 1000';
			case 'commands.volume.volumeSet': return ({required Object volume}) => 'Volume set to ${volume}';
			case 'commands.pause.command': return 'pause';
			case 'commands.pause.description': return 'Pauses the current player';
			case 'commands.pause.paused': return 'Player paused';
			case 'commands.resume.command': return 'resume';
			case 'commands.resume.description': return 'Resumes the current player';
			case 'commands.resume.resumed': return 'Player resumed';
			case 'commands.music.command': return 'music';
			case 'commands.music.description': return 'Music related commands';
			case 'commands.music.children.play.command': return 'play';
			case 'commands.music.children.play.description': return 'Plays music based on the given query';
			case 'commands.music.children.play.queryDescription': return 'The name/url of the song/playlist to play';
			case 'commands.music.children.play.noResults': return ({required Object query}) => 'No results found for ${query}';
			case 'commands.music.children.play.playlistEnqueued': return ({required Object name, required Object query}) => 'Playlist ${name} (${query}) enqueued';
			case 'commands.music.children.play.songEnqueued': return ({required Object title, required Object query}) => 'Song ${title} (${query}) enqueued';
			case 'commands.music.children.play.children.youtube.command': return 'youtube';
			case 'commands.music.children.play.children.youtube.description': return 'Plays music from YouTube';
			case 'commands.music.children.play.children.youtube.searching': return ({required Object query}) => 'Searching for ${query} on YouTube...';
			case 'commands.music.children.play.children.youtube.noResults': return ({required Object query}) => 'No results found for ${query}';
			case 'commands.music.children.play.children.deezer.command': return 'deezer';
			case 'commands.music.children.play.children.deezer.description': return 'Plays music from Deezer';
			case 'commands.music.children.play.children.deezer.searching': return ({required Object query}) => 'Searching for ${query} on Deezer...';
			case 'commands.music.children.play.children.deezer.noResults': return ({required Object query}) => 'No results found for ${query}';
			case 'commands.radio.command': return 'radio';
			case 'commands.radio.description': return 'Radio related commands';
			case 'commands.radio.children.play.command': return 'play';
			case 'commands.radio.children.play.description': return 'Plays a radio station based on the given query';
			case 'commands.radio.children.play.queryDescription': return 'The name of the radio station to play';
			case 'commands.radio.children.play.searching': return ({required Object query}) => 'Searching for radio ${query}...';
			case 'commands.radio.children.play.noResults': return ({required Object query}) => 'No results found for ${query}';
			case 'commands.radio.children.play.startedPlaying': return 'Started playing';
			case 'commands.radio.children.play.startedPlayingDescription': return ({required Object radio, required Object mention}) => 'Radio ${radio} started playing.\n\nRequested by ${mention}';
			case 'commands.radio.children.play.stationEnqueued': return ({required Object name, required Object query}) => 'Station ${name} (${query}) enqueued';
			case 'commands.radio.children.recognize.command': return 'recognize';
			case 'commands.radio.children.recognize.description': return 'Recognizes the current song playing';
			case 'commands.radio.children.recognize.requestedBy': return ({required Object mention}) => 'Requested by ${mention}';
			case 'commands.radio.children.recognize.radioStationField': return 'Radio Station';
			case 'commands.radio.children.recognize.genreField': return 'Genre';
			case 'commands.radio.children.recognize.computationalTimeField': return 'Computational time';
			case 'commands.radio.children.recognize.errors.title': return 'An error occurred while recognizing the song';
			case 'commands.radio.children.recognize.errors.noRadioPlaying': return 'Couldn\'t find a radio playing!';
			case 'commands.radio.children.recognize.errors.radioCantCommunicate': return 'There was an error communicating with the server, please try again.';
			case 'commands.radio.children.recognize.errors.noResults': return 'Couldn\'t identify the current song playing :(';
			case 'commands.radio.children.upvote.command': return 'upvote';
			case 'commands.radio.children.upvote.description': return 'Upvotes the current radio playing';
			case 'commands.radio.children.upvote.requestedBy': return ({required Object mention}) => 'Requested by ${mention}';
			case 'commands.radio.children.upvote.success': return 'Voted successfully';
			case 'commands.radio.children.upvote.successDescription': return ({required Object radio}) => 'You have successfully voted for the radio ${radio}! Thank you for your support :D';
			case 'commands.radio.children.upvote.errors.noRadioPlaying': return 'Couldn\'t find a radio playing!';
			case 'commands.radio.children.playRandom.command': return 'play-random';
			case 'commands.radio.children.playRandom.description': return 'Plays a random radio station';
			case 'commands.radio.children.playRandom.searching': return 'Searching for a random radio station...';
			case 'commands.radio.children.playRandom.startedPlaying': return 'Started playing';
			case 'commands.radio.children.playRandom.startedPlayingDescription': return ({required Object radio, required Object mention}) => 'Radio ${radio} started playing.\n\nRequested by ${mention}';
			case 'commands.radio.children.playRandom.errors.noResults': return 'Couldn\'t find a random radio station :( Try again later!';
			case 'services.music.trackStuck.title': return 'Track stuck';
			case 'services.music.trackStuck.description': return ({required Object track, required Object uri, required Object requester}) => 'Track [${track}](${uri}}) stuck playing.\n\nRequested by <@${requester}>';
			case 'services.music.trackStarted.title': return 'Track started';
			case 'services.music.trackStarted.description': return ({required Object track, required Object uri, required Object requester}) => 'Track [${track}](${uri}}) started playing.\n\nRequested by <@${requester}>';
			case 'services.music.trackException.title': return 'Track exception';
			case 'services.music.trackException.description': return ({required Object track, required Object uri, required Object requester}) => 'Track [${track}](${uri}}) threw an exception.\n\nRequested by <@${requester}>';
			case 'errorHandler.title': return 'An error has occurred';
			case 'errorHandler.fallbackDescription': return 'Your command couldn\'t be executed because of an error. Please contact a developer for more information.';
			case 'errorHandler.musicConnectedToVC': return 'I have to be in a voice channel to use this command';
			case 'errorHandler.musicNotConnectedToVC': return 'I\'m already connected to a voice channel';
			case 'errorHandler.musicSameVC': return 'I\'m already being used on other voice channel';
			case 'errorHandler.musicUserConnectedToVC': return 'You need to be connected to a voice channel to use this command';
			case 'errorHandler.cooldown.title': return 'Command on cooldown';
			case 'errorHandler.cooldown.description': return ({required Object inSeconds}) => 'You can\'t use this command right now because it is on cooldown. Please wait ${inSeconds}s and try again.';
			case 'errorHandler.unauthorizedCommand.title': return 'You can\'t use this command!';
			case 'errorHandler.unauthorizedCommand.description': return 'This command can only be used by certain users in certain contexts. Check that you have permission to execute the command, or contact a developer for more information.';
			case 'errorHandler.missingArguments.title': return 'Not enough arguments';
			case 'errorHandler.missingArguments.description': return 'You didn\'t provide enough arguments for this command. Please try again and use the Slash Command menu for help, or contact a developer for more information.';
			case 'errorHandler.inputParsingFailure.title': return 'Couldn\'t parse input';
			case 'errorHandler.inputParsingFailure.description': return 'Your command couldn\'t be executed because we were unable to understand your input. Please try again with different inputs or contact a developer for more information.';
			default: return null;
		}
	}
}

