// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_recognition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SongRecognitionResponse _$$_SongRecognitionResponseFromJson(
        Map<String, dynamic> json) =>
    _$_SongRecognitionResponse(
      metadata: json['metadata'] == null
          ? null
          : Metadata.fromJson(json['metadata'] as Map<String, dynamic>),
      status: json['status'] == null
          ? null
          : Status.fromJson(json['status'] as Map<String, dynamic>),
      resultType: json['resultType'] as int?,
    );

Map<String, dynamic> _$$_SongRecognitionResponseToJson(
        _$_SongRecognitionResponse instance) =>
    <String, dynamic>{
      'metadata': instance.metadata,
      'status': instance.status,
      'resultType': instance.resultType,
    };

_$_Metadata _$$_MetadataFromJson(Map<String, dynamic> json) => _$_Metadata(
      timestampUtc: json['timestampUtc'] == null
          ? null
          : DateTime.parse(json['timestampUtc'] as String),
      music: (json['music'] as List<dynamic>?)
          ?.map((e) => Music.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MetadataToJson(_$_Metadata instance) =>
    <String, dynamic>{
      'timestampUtc': instance.timestampUtc?.toIso8601String(),
      'music': instance.music,
    };

_$_Music _$$_MusicFromJson(Map<String, dynamic> json) => _$_Music(
      dbBeginTimeOffsetMs: json['dbBeginTimeOffsetMs'] as int?,
      dbEndTimeOffsetMs: json['dbEndTimeOffsetMs'] as int?,
      sampleBeginTimeOffsetMs: json['sampleBeginTimeOffsetMs'] as int?,
      sampleEndTimeOffsetMs: json['sampleEndTimeOffsetMs'] as int?,
      playOffsetMs: json['playOffsetMs'] as int?,
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => MusicAlbum.fromJson(e as Map<String, dynamic>))
          .toList(),
      lyrics: json['lyrics'] == null
          ? null
          : Lyrics.fromJson(json['lyrics'] as Map<String, dynamic>),
      acrid: json['acrid'] as String?,
      album: json['album'] == null
          ? null
          : MusicAlbum.fromJson(json['album'] as Map<String, dynamic>),
      rightsClaim: (json['rightsClaim'] as List<dynamic>?)
          ?.map((e) => RightsClaim.fromJson(e as Map<String, dynamic>))
          .toList(),
      externalIds: json['externalIds'] == null
          ? null
          : ExternalIds.fromJson(json['externalIds'] as Map<String, dynamic>),
      resultFrom: json['resultFrom'] as int?,
      contributors: json['contributors'] == null
          ? null
          : Contributors.fromJson(json['contributors'] as Map<String, dynamic>),
      title: json['title'] as String?,
      langs: (json['langs'] as List<dynamic>?)
          ?.map((e) => Lang.fromJson(e as Map<String, dynamic>))
          .toList(),
      language: json['language'] as String?,
      durationMs: json['durationMs'] as int?,
      label: json['label'] as String?,
      externalMetadata: json['externalMetadata'] == null
          ? null
          : ExternalMetadata.fromJson(
              json['externalMetadata'] as Map<String, dynamic>),
      score: json['score'] as int?,
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
      releaseByTerritories: (json['releaseByTerritories'] as List<dynamic>?)
          ?.map((e) => ReleaseByTerritory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MusicToJson(_$_Music instance) => <String, dynamic>{
      'dbBeginTimeOffsetMs': instance.dbBeginTimeOffsetMs,
      'dbEndTimeOffsetMs': instance.dbEndTimeOffsetMs,
      'sampleBeginTimeOffsetMs': instance.sampleBeginTimeOffsetMs,
      'sampleEndTimeOffsetMs': instance.sampleEndTimeOffsetMs,
      'playOffsetMs': instance.playOffsetMs,
      'artists': instance.artists,
      'lyrics': instance.lyrics,
      'acrid': instance.acrid,
      'album': instance.album,
      'rightsClaim': instance.rightsClaim,
      'externalIds': instance.externalIds,
      'resultFrom': instance.resultFrom,
      'contributors': instance.contributors,
      'title': instance.title,
      'langs': instance.langs,
      'language': instance.language,
      'durationMs': instance.durationMs,
      'label': instance.label,
      'externalMetadata': instance.externalMetadata,
      'score': instance.score,
      'genres': instance.genres,
      'releaseDate': instance.releaseDate?.toIso8601String(),
      'releaseByTerritories': instance.releaseByTerritories,
    };

_$_MusicAlbum _$$_MusicAlbumFromJson(Map<String, dynamic> json) =>
    _$_MusicAlbum(
      name: json['name'] as String?,
      langs: (json['langs'] as List<dynamic>?)
          ?.map((e) => Lang.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_MusicAlbumToJson(_$_MusicAlbum instance) =>
    <String, dynamic>{
      'name': instance.name,
      'langs': instance.langs,
    };

_$_Lang _$$_LangFromJson(Map<String, dynamic> json) => _$_Lang(
      code: json['code'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_LangToJson(_$_Lang instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

_$_Contributors _$$_ContributorsFromJson(Map<String, dynamic> json) =>
    _$_Contributors(
      composers: (json['composers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lyricists: (json['lyricists'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ContributorsToJson(_$_Contributors instance) =>
    <String, dynamic>{
      'composers': instance.composers,
      'lyricists': instance.lyricists,
    };

_$_ExternalIds _$$_ExternalIdsFromJson(Map<String, dynamic> json) =>
    _$_ExternalIds(
      iswc: json['iswc'] as String?,
      isrc: json['isrc'] as String?,
      upc: json['upc'] as String?,
    );

Map<String, dynamic> _$$_ExternalIdsToJson(_$_ExternalIds instance) =>
    <String, dynamic>{
      'iswc': instance.iswc,
      'isrc': instance.isrc,
      'upc': instance.upc,
    };

_$_ExternalMetadata _$$_ExternalMetadataFromJson(Map<String, dynamic> json) =>
    _$_ExternalMetadata(
      musicbrainz: (json['musicbrainz'] as List<dynamic>?)
          ?.map((e) => Musicbrainz.fromJson(e as Map<String, dynamic>))
          .toList(),
      deezer: json['deezer'] == null
          ? null
          : Deezer.fromJson(json['deezer'] as Map<String, dynamic>),
      spotify: json['spotify'] == null
          ? null
          : Deezer.fromJson(json['spotify'] as Map<String, dynamic>),
      musicstory: json['musicstory'] == null
          ? null
          : Musicstory.fromJson(json['musicstory'] as Map<String, dynamic>),
      youtube: json['youtube'] == null
          ? null
          : Youtube.fromJson(json['youtube'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ExternalMetadataToJson(_$_ExternalMetadata instance) =>
    <String, dynamic>{
      'musicbrainz': instance.musicbrainz,
      'deezer': instance.deezer,
      'spotify': instance.spotify,
      'musicstory': instance.musicstory,
      'youtube': instance.youtube,
    };

_$_Deezer _$$_DeezerFromJson(Map<String, dynamic> json) => _$_Deezer(
      track: json['track'] == null
          ? null
          : TrackClass.fromJson(json['track'] as Map<String, dynamic>),
      artists: (json['artists'] as List<dynamic>?)
          ?.map((e) => TrackClass.fromJson(e as Map<String, dynamic>))
          .toList(),
      album: json['album'] == null
          ? null
          : TrackClass.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_DeezerToJson(_$_Deezer instance) => <String, dynamic>{
      'track': instance.track,
      'artists': instance.artists,
      'album': instance.album,
    };

_$_TrackClass _$$_TrackClassFromJson(Map<String, dynamic> json) =>
    _$_TrackClass(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$_TrackClassToJson(_$_TrackClass instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

_$_Musicbrainz _$$_MusicbrainzFromJson(Map<String, dynamic> json) =>
    _$_Musicbrainz(
      track: json['track'] == null
          ? null
          : TrackClass.fromJson(json['track'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MusicbrainzToJson(_$_Musicbrainz instance) =>
    <String, dynamic>{
      'track': instance.track,
    };

_$_Musicstory _$$_MusicstoryFromJson(Map<String, dynamic> json) =>
    _$_Musicstory(
      track: json['track'] == null
          ? null
          : TrackClass.fromJson(json['track'] as Map<String, dynamic>),
      album: json['album'] == null
          ? null
          : TrackClass.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MusicstoryToJson(_$_Musicstory instance) =>
    <String, dynamic>{
      'track': instance.track,
      'album': instance.album,
    };

_$_Youtube _$$_YoutubeFromJson(Map<String, dynamic> json) => _$_Youtube(
      vid: json['vid'] as String?,
    );

Map<String, dynamic> _$$_YoutubeToJson(_$_Youtube instance) =>
    <String, dynamic>{
      'vid': instance.vid,
    };

_$_Genre _$$_GenreFromJson(Map<String, dynamic> json) => _$_Genre(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_GenreToJson(_$_Genre instance) => <String, dynamic>{
      'name': instance.name,
    };

_$_Lyrics _$$_LyricsFromJson(Map<String, dynamic> json) => _$_Lyrics(
      copyrights: (json['copyrights'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_LyricsToJson(_$_Lyrics instance) => <String, dynamic>{
      'copyrights': instance.copyrights,
    };

_$_ReleaseByTerritory _$$_ReleaseByTerritoryFromJson(
        Map<String, dynamic> json) =>
    _$_ReleaseByTerritory(
      territories: (json['territories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
    );

Map<String, dynamic> _$$_ReleaseByTerritoryToJson(
        _$_ReleaseByTerritory instance) =>
    <String, dynamic>{
      'territories': instance.territories,
      'releaseDate': instance.releaseDate?.toIso8601String(),
    };

_$_RightsClaim _$$_RightsClaimFromJson(Map<String, dynamic> json) =>
    _$_RightsClaim(
      distributor: json['distributor'] == null
          ? null
          : Distributor.fromJson(json['distributor'] as Map<String, dynamic>),
      rightsOwners: (json['rightsOwners'] as List<dynamic>?)
          ?.map((e) => RightsOwner.fromJson(e as Map<String, dynamic>))
          .toList(),
      rightsClaimPolicy: json['rightsClaimPolicy'] as String?,
      territories: (json['territories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_RightsClaimToJson(_$_RightsClaim instance) =>
    <String, dynamic>{
      'distributor': instance.distributor,
      'rightsOwners': instance.rightsOwners,
      'rightsClaimPolicy': instance.rightsClaimPolicy,
      'territories': instance.territories,
    };

_$_Distributor _$$_DistributorFromJson(Map<String, dynamic> json) =>
    _$_Distributor(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_DistributorToJson(_$_Distributor instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

_$_RightsOwner _$$_RightsOwnerFromJson(Map<String, dynamic> json) =>
    _$_RightsOwner(
      name: json['name'] as String?,
      sharePercentage: json['sharePercentage'] as int?,
    );

Map<String, dynamic> _$$_RightsOwnerToJson(_$_RightsOwner instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sharePercentage': instance.sharePercentage,
    };

_$_Status _$$_StatusFromJson(Map<String, dynamic> json) => _$_Status(
      msg: json['msg'] as String?,
      version: json['version'] as String?,
      code: json['code'] as int?,
    );

Map<String, dynamic> _$$_StatusToJson(_$_Status instance) => <String, dynamic>{
      'msg': instance.msg,
      'version': instance.version,
      'code': instance.code,
    };
