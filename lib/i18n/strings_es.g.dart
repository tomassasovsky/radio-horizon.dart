///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEs extends Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	// Translations
	@override late final TranslationsCommandsEs commands = TranslationsCommandsEs._(_root);
	@override late final TranslationsServicesEs services = TranslationsServicesEs._(_root);
	@override late final TranslationsErrorHandlerEs errorHandler = TranslationsErrorHandlerEs._(_root);
}

// Path: commands
class TranslationsCommandsEs extends TranslationsCommandsEn {
	TranslationsCommandsEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final TranslationsCommandsInfoEs info = TranslationsCommandsInfoEs._(_root);
	@override late final TranslationsCommandsSkipEs skip = TranslationsCommandsSkipEs._(_root);
	@override late final TranslationsCommandsStopEs stop = TranslationsCommandsStopEs._(_root);
	@override late final TranslationsCommandsLeaveEs leave = TranslationsCommandsLeaveEs._(_root);
	@override late final TranslationsCommandsJoinEs join = TranslationsCommandsJoinEs._(_root);
	@override late final TranslationsCommandsVolumeEs volume = TranslationsCommandsVolumeEs._(_root);
	@override late final TranslationsCommandsPauseEs pause = TranslationsCommandsPauseEs._(_root);
	@override late final TranslationsCommandsResumeEs resume = TranslationsCommandsResumeEs._(_root);
	@override late final TranslationsCommandsMusicEs music = TranslationsCommandsMusicEs._(_root);
	@override late final TranslationsCommandsRadioEs radio = TranslationsCommandsRadioEs._(_root);
}

// Path: services
class TranslationsServicesEs extends TranslationsServicesEn {
	TranslationsServicesEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final TranslationsServicesMusicEs music = TranslationsServicesMusicEs._(_root);
}

// Path: errorHandler
class TranslationsErrorHandlerEs extends TranslationsErrorHandlerEn {
	TranslationsErrorHandlerEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ha ocurrido un error';
	@override String get fallbackDescription => 'Tu comando no se ha podido ejecutar debido a un error desconocido. Por favor contacte a un desarrollador para más información.';
	@override String get musicConnectedToVC => 'Debo estar conectado a un canal de voz para ejecutar este comando';
	@override String get musicNotConnectedToVC => 'Ya estoy conectado a un canal de voz';
	@override String get musicSameVC => 'Debes estar en el mismo canal de voz que yo para ejecutar este comando';
	@override String get musicUserConnectedToVC => 'Debes estar conectado a un canal de voz para ejecutar este comando';
	@override late final TranslationsErrorHandlerCooldownEs cooldown = TranslationsErrorHandlerCooldownEs._(_root);
	@override late final TranslationsErrorHandlerUnauthorizedCommandEs unauthorizedCommand = TranslationsErrorHandlerUnauthorizedCommandEs._(_root);
	@override late final TranslationsErrorHandlerMissingArgumentsEs missingArguments = TranslationsErrorHandlerMissingArgumentsEs._(_root);
	@override late final TranslationsErrorHandlerInputParsingFailureEs inputParsingFailure = TranslationsErrorHandlerInputParsingFailureEs._(_root);
}

// Path: commands.info
class TranslationsCommandsInfoEs extends TranslationsCommandsInfoEn {
	TranslationsCommandsInfoEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'info';
	@override String get description => 'Muestra información sobre el bot';
	@override String get addToServer => 'Añadir Radio Horizon a mi servidor';
	@override String shardOf({required Object index, required Object count}) => 'Fragmento ${index} de ${count}';
	@override String get cachedGuilds => 'Servidores en caché';
	@override String get cachedUsers => 'Usuarios en caché';
	@override String get cachedChannels => 'Canales en caché';
	@override String get cachedVoiceStates => 'Estados de voz en caché';
	@override String get shardCount => 'Fragmentos';
	@override String get cachedMessages => 'Mensajes en caché';
	@override String get memoryUsage => 'Uso de memoria (current/RSS)';
	@override String get uptime => 'Tiempo de actividad';
	@override String get currentPlayers => 'Reproductores actuales';
	@override String get gatewayLatency => 'Latencia de la puerta de enlace';
	@override String get viewOnGithub => 'Ver en GitHub';
}

// Path: commands.skip
class TranslationsCommandsSkipEs extends TranslationsCommandsSkipEn {
	TranslationsCommandsSkipEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'saltar';
	@override String get description => 'Salta a la siguiente canción en la cola';
	@override String get skipped => 'La canción actual ha sido saltada';
	@override String get nothingPlaying => 'La cola está vacía';
}

// Path: commands.stop
class TranslationsCommandsStopEs extends TranslationsCommandsStopEn {
	TranslationsCommandsStopEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'parar';
	@override String get description => 'Para la reproducción de música';
	@override String get stopped => 'La reproducción de música ha sido detenida';
}

// Path: commands.leave
class TranslationsCommandsLeaveEs extends TranslationsCommandsLeaveEn {
	TranslationsCommandsLeaveEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'dejar';
	@override String get description => 'Abandona el canal de voz';
	@override String get left => 'El canal de voz ha sido abandonado';
	@override String get leftDueToInactivity => 'El canal de voz ha sido abandonado debido a la inactividad';
}

// Path: commands.join
class TranslationsCommandsJoinEs extends TranslationsCommandsJoinEn {
	TranslationsCommandsJoinEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'unirse';
	@override String get description => 'Se une al canal de voz en el que estás';
	@override String get joined => 'Se ha unido al canal de voz';
}

// Path: commands.volume
class TranslationsCommandsVolumeEs extends TranslationsCommandsVolumeEn {
	TranslationsCommandsVolumeEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'volumen';
	@override String get description => 'Establece el volumen de la música';
	@override String get volumeDescription => 'El volumen para establecer, debe ser un valor entre 0 y 1000';
	@override String volumeSet({required Object volume}) => 'Volumen puesto en ${volume}';
}

// Path: commands.pause
class TranslationsCommandsPauseEs extends TranslationsCommandsPauseEn {
	TranslationsCommandsPauseEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'pausar';
	@override String get description => 'Pausa la reproducción de música';
	@override String get paused => 'La reproducción de música ha sido pausada';
}

// Path: commands.resume
class TranslationsCommandsResumeEs extends TranslationsCommandsResumeEn {
	TranslationsCommandsResumeEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'reanudar';
	@override String get description => 'Reanuda la reproducción de música';
	@override String get resumed => 'La reproducción de música ha sido reanudada';
}

// Path: commands.music
class TranslationsCommandsMusicEs extends TranslationsCommandsMusicEn {
	TranslationsCommandsMusicEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'musica';
	@override String get description => 'Comandos relacionados con la funcionalidad de música';
	@override late final TranslationsCommandsMusicChildrenEs children = TranslationsCommandsMusicChildrenEs._(_root);
}

// Path: commands.radio
class TranslationsCommandsRadioEs extends TranslationsCommandsRadioEn {
	TranslationsCommandsRadioEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'radio';
	@override String get description => 'Comandos relacionados con la funcionalidad de radio';
	@override late final TranslationsCommandsRadioChildrenEs children = TranslationsCommandsRadioChildrenEs._(_root);
}

// Path: services.music
class TranslationsServicesMusicEs extends TranslationsServicesMusicEn {
	TranslationsServicesMusicEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final TranslationsServicesMusicTrackStuckEs trackStuck = TranslationsServicesMusicTrackStuckEs._(_root);
	@override late final TranslationsServicesMusicTrackStartedEs trackStarted = TranslationsServicesMusicTrackStartedEs._(_root);
	@override late final TranslationsServicesMusicTrackExceptionEs trackException = TranslationsServicesMusicTrackExceptionEs._(_root);
}

// Path: errorHandler.cooldown
class TranslationsErrorHandlerCooldownEs extends TranslationsErrorHandlerCooldownEn {
	TranslationsErrorHandlerCooldownEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Commando en cooldown';
	@override String description({required Object inSeconds}) => 'No puedes usar este comando ahora mismo porque está en cooldown. Por favor espera ${inSeconds}s e inténtalo de nuevo.';
}

// Path: errorHandler.unauthorizedCommand
class TranslationsErrorHandlerUnauthorizedCommandEs extends TranslationsErrorHandlerUnauthorizedCommandEn {
	TranslationsErrorHandlerUnauthorizedCommandEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'No puedes usar este comando!';
	@override String get description => 'Este comando solo puede ser usado por determinados usuarios en determinados contextos. Verifica que tienes los permisos para ejecutar este comando, o contacte a un desarrollador para más información.';
}

// Path: errorHandler.missingArguments
class TranslationsErrorHandlerMissingArgumentsEs extends TranslationsErrorHandlerMissingArgumentsEn {
	TranslationsErrorHandlerMissingArgumentsEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Faltan argumentos';
	@override String get description => 'No has proveido los argumentos necesarios para ejecutar esta función. Por favor inténtalo de nuevo y usa el Menú de Slash Command para ayuda, o contacta a un desarrollador para más información.';
}

// Path: errorHandler.inputParsingFailure
class TranslationsErrorHandlerInputParsingFailureEs extends TranslationsErrorHandlerInputParsingFailureEn {
	TranslationsErrorHandlerInputParsingFailureEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ha ocurrido un error al procesar tu entrada';
	@override String get description => 'No se ha podido ejecutar el comando ya que no hemos podido interpretar tus argumentos. Por favor inténtalo de nuevo y usa el Menú de Slash Command para ayuda, o contacta a un desarrollador para más información.';
}

// Path: commands.music.children
class TranslationsCommandsMusicChildrenEs extends TranslationsCommandsMusicChildrenEn {
	TranslationsCommandsMusicChildrenEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final TranslationsCommandsMusicChildrenPlayEs play = TranslationsCommandsMusicChildrenPlayEs._(_root);
}

// Path: commands.radio.children
class TranslationsCommandsRadioChildrenEs extends TranslationsCommandsRadioChildrenEn {
	TranslationsCommandsRadioChildrenEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final TranslationsCommandsRadioChildrenPlayEs play = TranslationsCommandsRadioChildrenPlayEs._(_root);
	@override late final TranslationsCommandsRadioChildrenRecognizeEs recognize = TranslationsCommandsRadioChildrenRecognizeEs._(_root);
	@override late final TranslationsCommandsRadioChildrenUpvoteEs upvote = TranslationsCommandsRadioChildrenUpvoteEs._(_root);
	@override late final TranslationsCommandsRadioChildrenPlayRandomEs playRandom = TranslationsCommandsRadioChildrenPlayRandomEs._(_root);
}

// Path: services.music.trackStuck
class TranslationsServicesMusicTrackStuckEs extends TranslationsServicesMusicTrackStuckEn {
	TranslationsServicesMusicTrackStuckEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'La canción se ha quedado atascada';
	@override String description({required Object track, required Object uri, required Object requester}) => 'La pista [${track}](${uri}}) se ha quedado atascada.\n\nPedida por <@${requester}>';
}

// Path: services.music.trackStarted
class TranslationsServicesMusicTrackStartedEs extends TranslationsServicesMusicTrackStartedEn {
	TranslationsServicesMusicTrackStartedEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Se ha comenzado a reproducir';
	@override String description({required Object track, required Object uri, required Object requester}) => 'La pista [${track}](${uri}}) se ha comenzado a reproducir.\n\nPedido por <@${requester}>';
}

// Path: services.music.trackException
class TranslationsServicesMusicTrackExceptionEs extends TranslationsServicesMusicTrackExceptionEn {
	TranslationsServicesMusicTrackExceptionEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ha ocurrido un error al reproducir la canción';
	@override String description({required Object track, required Object uri, required Object requester}) => 'La pista [${track}](${uri}}) devolvió un error.\n\nPedido por <@${requester}>';
}

// Path: commands.music.children.play
class TranslationsCommandsMusicChildrenPlayEs extends TranslationsCommandsMusicChildrenPlayEn {
	TranslationsCommandsMusicChildrenPlayEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'reproducir';
	@override String get description => 'Reproduce música basada en una URL o una búsqueda';
	@override String get queryDescription => 'El nombre de una canción o una URL';
	@override String noResults({required Object query}) => 'No se encontraron resultados para ${query}';
	@override String playlistEnqueued({required Object name, required Object query}) => 'Lista de reproducción ${name} (${query}) añadida a la cola';
	@override String songEnqueued({required Object title, required Object query}) => 'Canción ${title} (${query}) añadida a la cola';
	@override late final TranslationsCommandsMusicChildrenPlayChildrenEs children = TranslationsCommandsMusicChildrenPlayChildrenEs._(_root);
}

// Path: commands.radio.children.play
class TranslationsCommandsRadioChildrenPlayEs extends TranslationsCommandsRadioChildrenPlayEn {
	TranslationsCommandsRadioChildrenPlayEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'reproducir';
	@override String get description => 'Reproduce una radio basada en una búsqueda';
	@override String get queryDescription => 'El nombre de una estación de radio';
	@override String searching({required Object query}) => 'Buscando radio ${query}...';
	@override String noResults({required Object query}) => 'No se encontraron resultados para ${query}';
	@override String get startedPlaying => 'Se ha comenzado a reproducir';
	@override String startedPlayingDescription({required Object radio, required Object mention}) => 'La radio ${radio} ha comenzado a reproducirse.\n\nPedido por ${mention}';
	@override String stationEnqueued({required Object name, required Object query}) => 'La radio ${name} (${query}) ha sido añadida a la cola';
}

// Path: commands.radio.children.recognize
class TranslationsCommandsRadioChildrenRecognizeEs extends TranslationsCommandsRadioChildrenRecognizeEn {
	TranslationsCommandsRadioChildrenRecognizeEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'reconocer';
	@override String get description => 'Reconoce la cancion que se está reproduciendo en la radio';
	@override String requestedBy({required Object mention}) => 'Pedido por ${mention}';
	@override String get radioStationField => 'Estación';
	@override String get genreField => 'Género';
	@override String get computationalTimeField => 'Tiempo de cálculo';
	@override late final TranslationsCommandsRadioChildrenRecognizeErrorsEs errors = TranslationsCommandsRadioChildrenRecognizeErrorsEs._(_root);
}

// Path: commands.radio.children.upvote
class TranslationsCommandsRadioChildrenUpvoteEs extends TranslationsCommandsRadioChildrenUpvoteEn {
	TranslationsCommandsRadioChildrenUpvoteEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'votar';
	@override String get description => 'Vota positivamente por la radio que se está reproduciendo';
	@override String requestedBy({required Object mention}) => 'Pedido por ${mention}';
	@override String get success => 'Voto positivo añadido';
	@override String successDescription({required Object radio}) => 'Has votado positivamente por la radio ${radio}! Gracias por tu apoyo :D';
	@override late final TranslationsCommandsRadioChildrenUpvoteErrorsEs errors = TranslationsCommandsRadioChildrenUpvoteErrorsEs._(_root);
}

// Path: commands.radio.children.playRandom
class TranslationsCommandsRadioChildrenPlayRandomEs extends TranslationsCommandsRadioChildrenPlayRandomEn {
	TranslationsCommandsRadioChildrenPlayRandomEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'play-random';
	@override String get description => 'Reproduce una radio aleatoria';
	@override String get searching => 'Buscando una radio aleatoria...';
	@override String get startedPlaying => 'Se ha comenzado a reproducir';
	@override String startedPlayingDescription({required Object radio, required Object mention}) => 'La radio ${radio} ha comenzado a reproducirse.\n\nPedido por ${mention}';
	@override late final TranslationsCommandsRadioChildrenPlayRandomErrorsEs errors = TranslationsCommandsRadioChildrenPlayRandomErrorsEs._(_root);
}

// Path: commands.music.children.play.children
class TranslationsCommandsMusicChildrenPlayChildrenEs extends TranslationsCommandsMusicChildrenPlayChildrenEn {
	TranslationsCommandsMusicChildrenPlayChildrenEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final TranslationsCommandsMusicChildrenPlayChildrenYoutubeEs youtube = TranslationsCommandsMusicChildrenPlayChildrenYoutubeEs._(_root);
	@override late final TranslationsCommandsMusicChildrenPlayChildrenDeezerEs deezer = TranslationsCommandsMusicChildrenPlayChildrenDeezerEs._(_root);
}

// Path: commands.radio.children.recognize.errors
class TranslationsCommandsRadioChildrenRecognizeErrorsEs extends TranslationsCommandsRadioChildrenRecognizeErrorsEn {
	TranslationsCommandsRadioChildrenRecognizeErrorsEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ha ocurrido un error al reconocer la canción';
	@override String get noRadioPlaying => 'No se está reproduciendo ninguna radio';
	@override String get radioCantCommunicate => 'La radio no puede comunicarse con el servidor de reconocimiento de canciones. Inténtalo de nuevo más tarde';
	@override String get noResults => 'No se han encontrado resultados para la canción que se está reproduciendo :(';
}

// Path: commands.radio.children.upvote.errors
class TranslationsCommandsRadioChildrenUpvoteErrorsEs extends TranslationsCommandsRadioChildrenUpvoteErrorsEn {
	TranslationsCommandsRadioChildrenUpvoteErrorsEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get noRadioPlaying => 'No se está reproduciendo ninguna radio';
}

// Path: commands.radio.children.playRandom.errors
class TranslationsCommandsRadioChildrenPlayRandomErrorsEs extends TranslationsCommandsRadioChildrenPlayRandomErrorsEn {
	TranslationsCommandsRadioChildrenPlayRandomErrorsEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get noResults => 'No se ha podido encontrar una radio aleatoria :( Inténtalo de nuevo más tarde!';
}

// Path: commands.music.children.play.children.youtube
class TranslationsCommandsMusicChildrenPlayChildrenYoutubeEs extends TranslationsCommandsMusicChildrenPlayChildrenYoutubeEn {
	TranslationsCommandsMusicChildrenPlayChildrenYoutubeEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'youtube';
	@override String get description => 'Reproduce música de YouTube';
	@override String searching({required Object query}) => 'Buscando ${query} en YouTube...';
	@override String noResults({required Object query}) => 'No se encontraron resultados para ${query}';
}

// Path: commands.music.children.play.children.deezer
class TranslationsCommandsMusicChildrenPlayChildrenDeezerEs extends TranslationsCommandsMusicChildrenPlayChildrenDeezerEn {
	TranslationsCommandsMusicChildrenPlayChildrenDeezerEs._(TranslationsEs root) : this._root = root, super.internal(root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get command => 'deezer';
	@override String get description => 'Reproduce música de Deezer';
	@override String searching({required Object query}) => 'Buscando ${query} en Deezer...';
	@override String noResults({required Object query}) => 'No se encontraron resultados para ${query}';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'commands.info.command': return 'info';
			case 'commands.info.description': return 'Muestra información sobre el bot';
			case 'commands.info.addToServer': return 'Añadir Radio Horizon a mi servidor';
			case 'commands.info.shardOf': return ({required Object index, required Object count}) => 'Fragmento ${index} de ${count}';
			case 'commands.info.cachedGuilds': return 'Servidores en caché';
			case 'commands.info.cachedUsers': return 'Usuarios en caché';
			case 'commands.info.cachedChannels': return 'Canales en caché';
			case 'commands.info.cachedVoiceStates': return 'Estados de voz en caché';
			case 'commands.info.shardCount': return 'Fragmentos';
			case 'commands.info.cachedMessages': return 'Mensajes en caché';
			case 'commands.info.memoryUsage': return 'Uso de memoria (current/RSS)';
			case 'commands.info.uptime': return 'Tiempo de actividad';
			case 'commands.info.currentPlayers': return 'Reproductores actuales';
			case 'commands.info.gatewayLatency': return 'Latencia de la puerta de enlace';
			case 'commands.info.viewOnGithub': return 'Ver en GitHub';
			case 'commands.skip.command': return 'saltar';
			case 'commands.skip.description': return 'Salta a la siguiente canción en la cola';
			case 'commands.skip.skipped': return 'La canción actual ha sido saltada';
			case 'commands.skip.nothingPlaying': return 'La cola está vacía';
			case 'commands.stop.command': return 'parar';
			case 'commands.stop.description': return 'Para la reproducción de música';
			case 'commands.stop.stopped': return 'La reproducción de música ha sido detenida';
			case 'commands.leave.command': return 'dejar';
			case 'commands.leave.description': return 'Abandona el canal de voz';
			case 'commands.leave.left': return 'El canal de voz ha sido abandonado';
			case 'commands.leave.leftDueToInactivity': return 'El canal de voz ha sido abandonado debido a la inactividad';
			case 'commands.join.command': return 'unirse';
			case 'commands.join.description': return 'Se une al canal de voz en el que estás';
			case 'commands.join.joined': return 'Se ha unido al canal de voz';
			case 'commands.volume.command': return 'volumen';
			case 'commands.volume.description': return 'Establece el volumen de la música';
			case 'commands.volume.volumeDescription': return 'El volumen para establecer, debe ser un valor entre 0 y 1000';
			case 'commands.volume.volumeSet': return ({required Object volume}) => 'Volumen puesto en ${volume}';
			case 'commands.pause.command': return 'pausar';
			case 'commands.pause.description': return 'Pausa la reproducción de música';
			case 'commands.pause.paused': return 'La reproducción de música ha sido pausada';
			case 'commands.resume.command': return 'reanudar';
			case 'commands.resume.description': return 'Reanuda la reproducción de música';
			case 'commands.resume.resumed': return 'La reproducción de música ha sido reanudada';
			case 'commands.music.command': return 'musica';
			case 'commands.music.description': return 'Comandos relacionados con la funcionalidad de música';
			case 'commands.music.children.play.command': return 'reproducir';
			case 'commands.music.children.play.description': return 'Reproduce música basada en una URL o una búsqueda';
			case 'commands.music.children.play.queryDescription': return 'El nombre de una canción o una URL';
			case 'commands.music.children.play.noResults': return ({required Object query}) => 'No se encontraron resultados para ${query}';
			case 'commands.music.children.play.playlistEnqueued': return ({required Object name, required Object query}) => 'Lista de reproducción ${name} (${query}) añadida a la cola';
			case 'commands.music.children.play.songEnqueued': return ({required Object title, required Object query}) => 'Canción ${title} (${query}) añadida a la cola';
			case 'commands.music.children.play.children.youtube.command': return 'youtube';
			case 'commands.music.children.play.children.youtube.description': return 'Reproduce música de YouTube';
			case 'commands.music.children.play.children.youtube.searching': return ({required Object query}) => 'Buscando ${query} en YouTube...';
			case 'commands.music.children.play.children.youtube.noResults': return ({required Object query}) => 'No se encontraron resultados para ${query}';
			case 'commands.music.children.play.children.deezer.command': return 'deezer';
			case 'commands.music.children.play.children.deezer.description': return 'Reproduce música de Deezer';
			case 'commands.music.children.play.children.deezer.searching': return ({required Object query}) => 'Buscando ${query} en Deezer...';
			case 'commands.music.children.play.children.deezer.noResults': return ({required Object query}) => 'No se encontraron resultados para ${query}';
			case 'commands.radio.command': return 'radio';
			case 'commands.radio.description': return 'Comandos relacionados con la funcionalidad de radio';
			case 'commands.radio.children.play.command': return 'reproducir';
			case 'commands.radio.children.play.description': return 'Reproduce una radio basada en una búsqueda';
			case 'commands.radio.children.play.queryDescription': return 'El nombre de una estación de radio';
			case 'commands.radio.children.play.searching': return ({required Object query}) => 'Buscando radio ${query}...';
			case 'commands.radio.children.play.noResults': return ({required Object query}) => 'No se encontraron resultados para ${query}';
			case 'commands.radio.children.play.startedPlaying': return 'Se ha comenzado a reproducir';
			case 'commands.radio.children.play.startedPlayingDescription': return ({required Object radio, required Object mention}) => 'La radio ${radio} ha comenzado a reproducirse.\n\nPedido por ${mention}';
			case 'commands.radio.children.play.stationEnqueued': return ({required Object name, required Object query}) => 'La radio ${name} (${query}) ha sido añadida a la cola';
			case 'commands.radio.children.recognize.command': return 'reconocer';
			case 'commands.radio.children.recognize.description': return 'Reconoce la cancion que se está reproduciendo en la radio';
			case 'commands.radio.children.recognize.requestedBy': return ({required Object mention}) => 'Pedido por ${mention}';
			case 'commands.radio.children.recognize.radioStationField': return 'Estación';
			case 'commands.radio.children.recognize.genreField': return 'Género';
			case 'commands.radio.children.recognize.computationalTimeField': return 'Tiempo de cálculo';
			case 'commands.radio.children.recognize.errors.title': return 'Ha ocurrido un error al reconocer la canción';
			case 'commands.radio.children.recognize.errors.noRadioPlaying': return 'No se está reproduciendo ninguna radio';
			case 'commands.radio.children.recognize.errors.radioCantCommunicate': return 'La radio no puede comunicarse con el servidor de reconocimiento de canciones. Inténtalo de nuevo más tarde';
			case 'commands.radio.children.recognize.errors.noResults': return 'No se han encontrado resultados para la canción que se está reproduciendo :(';
			case 'commands.radio.children.upvote.command': return 'votar';
			case 'commands.radio.children.upvote.description': return 'Vota positivamente por la radio que se está reproduciendo';
			case 'commands.radio.children.upvote.requestedBy': return ({required Object mention}) => 'Pedido por ${mention}';
			case 'commands.radio.children.upvote.success': return 'Voto positivo añadido';
			case 'commands.radio.children.upvote.successDescription': return ({required Object radio}) => 'Has votado positivamente por la radio ${radio}! Gracias por tu apoyo :D';
			case 'commands.radio.children.upvote.errors.noRadioPlaying': return 'No se está reproduciendo ninguna radio';
			case 'commands.radio.children.playRandom.command': return 'play-random';
			case 'commands.radio.children.playRandom.description': return 'Reproduce una radio aleatoria';
			case 'commands.radio.children.playRandom.searching': return 'Buscando una radio aleatoria...';
			case 'commands.radio.children.playRandom.startedPlaying': return 'Se ha comenzado a reproducir';
			case 'commands.radio.children.playRandom.startedPlayingDescription': return ({required Object radio, required Object mention}) => 'La radio ${radio} ha comenzado a reproducirse.\n\nPedido por ${mention}';
			case 'commands.radio.children.playRandom.errors.noResults': return 'No se ha podido encontrar una radio aleatoria :( Inténtalo de nuevo más tarde!';
			case 'services.music.trackStuck.title': return 'La canción se ha quedado atascada';
			case 'services.music.trackStuck.description': return ({required Object track, required Object uri, required Object requester}) => 'La pista [${track}](${uri}}) se ha quedado atascada.\n\nPedida por <@${requester}>';
			case 'services.music.trackStarted.title': return 'Se ha comenzado a reproducir';
			case 'services.music.trackStarted.description': return ({required Object track, required Object uri, required Object requester}) => 'La pista [${track}](${uri}}) se ha comenzado a reproducir.\n\nPedido por <@${requester}>';
			case 'services.music.trackException.title': return 'Ha ocurrido un error al reproducir la canción';
			case 'services.music.trackException.description': return ({required Object track, required Object uri, required Object requester}) => 'La pista [${track}](${uri}}) devolvió un error.\n\nPedido por <@${requester}>';
			case 'errorHandler.title': return 'Ha ocurrido un error';
			case 'errorHandler.fallbackDescription': return 'Tu comando no se ha podido ejecutar debido a un error desconocido. Por favor contacte a un desarrollador para más información.';
			case 'errorHandler.musicConnectedToVC': return 'Debo estar conectado a un canal de voz para ejecutar este comando';
			case 'errorHandler.musicNotConnectedToVC': return 'Ya estoy conectado a un canal de voz';
			case 'errorHandler.musicSameVC': return 'Debes estar en el mismo canal de voz que yo para ejecutar este comando';
			case 'errorHandler.musicUserConnectedToVC': return 'Debes estar conectado a un canal de voz para ejecutar este comando';
			case 'errorHandler.cooldown.title': return 'Commando en cooldown';
			case 'errorHandler.cooldown.description': return ({required Object inSeconds}) => 'No puedes usar este comando ahora mismo porque está en cooldown. Por favor espera ${inSeconds}s e inténtalo de nuevo.';
			case 'errorHandler.unauthorizedCommand.title': return 'No puedes usar este comando!';
			case 'errorHandler.unauthorizedCommand.description': return 'Este comando solo puede ser usado por determinados usuarios en determinados contextos. Verifica que tienes los permisos para ejecutar este comando, o contacte a un desarrollador para más información.';
			case 'errorHandler.missingArguments.title': return 'Faltan argumentos';
			case 'errorHandler.missingArguments.description': return 'No has proveido los argumentos necesarios para ejecutar esta función. Por favor inténtalo de nuevo y usa el Menú de Slash Command para ayuda, o contacta a un desarrollador para más información.';
			case 'errorHandler.inputParsingFailure.title': return 'Ha ocurrido un error al procesar tu entrada';
			case 'errorHandler.inputParsingFailure.description': return 'No se ha podido ejecutar el comando ya que no hemos podido interpretar tus argumentos. Por favor inténtalo de nuevo y usa el Menú de Slash Command para ayuda, o contacta a un desarrollador para más información.';
			default: return null;
		}
	}
}

