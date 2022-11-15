// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'song_recognition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SongRecognitionResponse _$SongRecognitionResponseFromJson(
    Map<String, dynamic> json) {
  return _SongRecognitionResponse.fromJson(json);
}

/// @nodoc
mixin _$SongRecognitionResponse {
  Metadata? get metadata => throw _privateConstructorUsedError;
  Status? get status => throw _privateConstructorUsedError;
  int? get resultType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SongRecognitionResponseCopyWith<SongRecognitionResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SongRecognitionResponseCopyWith<$Res> {
  factory $SongRecognitionResponseCopyWith(SongRecognitionResponse value,
          $Res Function(SongRecognitionResponse) then) =
      _$SongRecognitionResponseCopyWithImpl<$Res, SongRecognitionResponse>;
  @useResult
  $Res call({Metadata? metadata, Status? status, int? resultType});

  $MetadataCopyWith<$Res>? get metadata;
  $StatusCopyWith<$Res>? get status;
}

/// @nodoc
class _$SongRecognitionResponseCopyWithImpl<$Res,
        $Val extends SongRecognitionResponse>
    implements $SongRecognitionResponseCopyWith<$Res> {
  _$SongRecognitionResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metadata = freezed,
    Object? status = freezed,
    Object? resultType = freezed,
  }) {
    return _then(_value.copyWith(
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status?,
      resultType: freezed == resultType
          ? _value.resultType
          : resultType // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $MetadataCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $MetadataCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $StatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SongRecognitionResponseCopyWith<$Res>
    implements $SongRecognitionResponseCopyWith<$Res> {
  factory _$$_SongRecognitionResponseCopyWith(_$_SongRecognitionResponse value,
          $Res Function(_$_SongRecognitionResponse) then) =
      __$$_SongRecognitionResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Metadata? metadata, Status? status, int? resultType});

  @override
  $MetadataCopyWith<$Res>? get metadata;
  @override
  $StatusCopyWith<$Res>? get status;
}

/// @nodoc
class __$$_SongRecognitionResponseCopyWithImpl<$Res>
    extends _$SongRecognitionResponseCopyWithImpl<$Res,
        _$_SongRecognitionResponse>
    implements _$$_SongRecognitionResponseCopyWith<$Res> {
  __$$_SongRecognitionResponseCopyWithImpl(_$_SongRecognitionResponse _value,
      $Res Function(_$_SongRecognitionResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? metadata = freezed,
    Object? status = freezed,
    Object? resultType = freezed,
  }) {
    return _then(_$_SongRecognitionResponse(
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Metadata?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status?,
      resultType: freezed == resultType
          ? _value.resultType
          : resultType // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SongRecognitionResponse implements _SongRecognitionResponse {
  const _$_SongRecognitionResponse(
      {this.metadata, this.status, this.resultType});

  factory _$_SongRecognitionResponse.fromJson(Map<String, dynamic> json) =>
      _$$_SongRecognitionResponseFromJson(json);

  @override
  final Metadata? metadata;
  @override
  final Status? status;
  @override
  final int? resultType;

  @override
  String toString() {
    return 'SongRecognitionResponse(metadata: $metadata, status: $status, resultType: $resultType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SongRecognitionResponse &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.resultType, resultType) ||
                other.resultType == resultType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, metadata, status, resultType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SongRecognitionResponseCopyWith<_$_SongRecognitionResponse>
      get copyWith =>
          __$$_SongRecognitionResponseCopyWithImpl<_$_SongRecognitionResponse>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SongRecognitionResponseToJson(
      this,
    );
  }
}

abstract class _SongRecognitionResponse implements SongRecognitionResponse {
  const factory _SongRecognitionResponse(
      {final Metadata? metadata,
      final Status? status,
      final int? resultType}) = _$_SongRecognitionResponse;

  factory _SongRecognitionResponse.fromJson(Map<String, dynamic> json) =
      _$_SongRecognitionResponse.fromJson;

  @override
  Metadata? get metadata;
  @override
  Status? get status;
  @override
  int? get resultType;
  @override
  @JsonKey(ignore: true)
  _$$_SongRecognitionResponseCopyWith<_$_SongRecognitionResponse>
      get copyWith => throw _privateConstructorUsedError;
}

Metadata _$MetadataFromJson(Map<String, dynamic> json) {
  return _Metadata.fromJson(json);
}

/// @nodoc
mixin _$Metadata {
  DateTime? get timestampUtc => throw _privateConstructorUsedError;
  List<Music>? get music => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MetadataCopyWith<Metadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetadataCopyWith<$Res> {
  factory $MetadataCopyWith(Metadata value, $Res Function(Metadata) then) =
      _$MetadataCopyWithImpl<$Res, Metadata>;
  @useResult
  $Res call({DateTime? timestampUtc, List<Music>? music});
}

/// @nodoc
class _$MetadataCopyWithImpl<$Res, $Val extends Metadata>
    implements $MetadataCopyWith<$Res> {
  _$MetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestampUtc = freezed,
    Object? music = freezed,
  }) {
    return _then(_value.copyWith(
      timestampUtc: freezed == timestampUtc
          ? _value.timestampUtc
          : timestampUtc // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      music: freezed == music
          ? _value.music
          : music // ignore: cast_nullable_to_non_nullable
              as List<Music>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MetadataCopyWith<$Res> implements $MetadataCopyWith<$Res> {
  factory _$$_MetadataCopyWith(
          _$_Metadata value, $Res Function(_$_Metadata) then) =
      __$$_MetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime? timestampUtc, List<Music>? music});
}

/// @nodoc
class __$$_MetadataCopyWithImpl<$Res>
    extends _$MetadataCopyWithImpl<$Res, _$_Metadata>
    implements _$$_MetadataCopyWith<$Res> {
  __$$_MetadataCopyWithImpl(
      _$_Metadata _value, $Res Function(_$_Metadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timestampUtc = freezed,
    Object? music = freezed,
  }) {
    return _then(_$_Metadata(
      timestampUtc: freezed == timestampUtc
          ? _value.timestampUtc
          : timestampUtc // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      music: freezed == music
          ? _value._music
          : music // ignore: cast_nullable_to_non_nullable
              as List<Music>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Metadata implements _Metadata {
  const _$_Metadata({this.timestampUtc, final List<Music>? music})
      : _music = music;

  factory _$_Metadata.fromJson(Map<String, dynamic> json) =>
      _$$_MetadataFromJson(json);

  @override
  final DateTime? timestampUtc;
  final List<Music>? _music;
  @override
  List<Music>? get music {
    final value = _music;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Metadata(timestampUtc: $timestampUtc, music: $music)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Metadata &&
            (identical(other.timestampUtc, timestampUtc) ||
                other.timestampUtc == timestampUtc) &&
            const DeepCollectionEquality().equals(other._music, _music));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, timestampUtc, const DeepCollectionEquality().hash(_music));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MetadataCopyWith<_$_Metadata> get copyWith =>
      __$$_MetadataCopyWithImpl<_$_Metadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MetadataToJson(
      this,
    );
  }
}

abstract class _Metadata implements Metadata {
  const factory _Metadata(
      {final DateTime? timestampUtc, final List<Music>? music}) = _$_Metadata;

  factory _Metadata.fromJson(Map<String, dynamic> json) = _$_Metadata.fromJson;

  @override
  DateTime? get timestampUtc;
  @override
  List<Music>? get music;
  @override
  @JsonKey(ignore: true)
  _$$_MetadataCopyWith<_$_Metadata> get copyWith =>
      throw _privateConstructorUsedError;
}

Music _$MusicFromJson(Map<String, dynamic> json) {
  return _Music.fromJson(json);
}

/// @nodoc
mixin _$Music {
  int? get dbBeginTimeOffsetMs => throw _privateConstructorUsedError;
  int? get dbEndTimeOffsetMs => throw _privateConstructorUsedError;
  int? get sampleBeginTimeOffsetMs => throw _privateConstructorUsedError;
  int? get sampleEndTimeOffsetMs => throw _privateConstructorUsedError;
  int? get playOffsetMs => throw _privateConstructorUsedError;
  List<MusicAlbum>? get artists => throw _privateConstructorUsedError;
  Lyrics? get lyrics => throw _privateConstructorUsedError;
  String? get acrid => throw _privateConstructorUsedError;
  MusicAlbum? get album => throw _privateConstructorUsedError;
  List<RightsClaim>? get rightsClaim => throw _privateConstructorUsedError;
  ExternalIds? get externalIds => throw _privateConstructorUsedError;
  int? get resultFrom => throw _privateConstructorUsedError;
  Contributors? get contributors => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  List<Lang>? get langs => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  int? get durationMs => throw _privateConstructorUsedError;
  String? get label => throw _privateConstructorUsedError;
  ExternalMetadata? get externalMetadata => throw _privateConstructorUsedError;
  int? get score => throw _privateConstructorUsedError;
  List<Genre>? get genres => throw _privateConstructorUsedError;
  DateTime? get releaseDate => throw _privateConstructorUsedError;
  List<ReleaseByTerritory>? get releaseByTerritories =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MusicCopyWith<Music> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicCopyWith<$Res> {
  factory $MusicCopyWith(Music value, $Res Function(Music) then) =
      _$MusicCopyWithImpl<$Res, Music>;
  @useResult
  $Res call(
      {int? dbBeginTimeOffsetMs,
      int? dbEndTimeOffsetMs,
      int? sampleBeginTimeOffsetMs,
      int? sampleEndTimeOffsetMs,
      int? playOffsetMs,
      List<MusicAlbum>? artists,
      Lyrics? lyrics,
      String? acrid,
      MusicAlbum? album,
      List<RightsClaim>? rightsClaim,
      ExternalIds? externalIds,
      int? resultFrom,
      Contributors? contributors,
      String? title,
      List<Lang>? langs,
      String? language,
      int? durationMs,
      String? label,
      ExternalMetadata? externalMetadata,
      int? score,
      List<Genre>? genres,
      DateTime? releaseDate,
      List<ReleaseByTerritory>? releaseByTerritories});

  $LyricsCopyWith<$Res>? get lyrics;
  $MusicAlbumCopyWith<$Res>? get album;
  $ExternalIdsCopyWith<$Res>? get externalIds;
  $ContributorsCopyWith<$Res>? get contributors;
  $ExternalMetadataCopyWith<$Res>? get externalMetadata;
}

/// @nodoc
class _$MusicCopyWithImpl<$Res, $Val extends Music>
    implements $MusicCopyWith<$Res> {
  _$MusicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbBeginTimeOffsetMs = freezed,
    Object? dbEndTimeOffsetMs = freezed,
    Object? sampleBeginTimeOffsetMs = freezed,
    Object? sampleEndTimeOffsetMs = freezed,
    Object? playOffsetMs = freezed,
    Object? artists = freezed,
    Object? lyrics = freezed,
    Object? acrid = freezed,
    Object? album = freezed,
    Object? rightsClaim = freezed,
    Object? externalIds = freezed,
    Object? resultFrom = freezed,
    Object? contributors = freezed,
    Object? title = freezed,
    Object? langs = freezed,
    Object? language = freezed,
    Object? durationMs = freezed,
    Object? label = freezed,
    Object? externalMetadata = freezed,
    Object? score = freezed,
    Object? genres = freezed,
    Object? releaseDate = freezed,
    Object? releaseByTerritories = freezed,
  }) {
    return _then(_value.copyWith(
      dbBeginTimeOffsetMs: freezed == dbBeginTimeOffsetMs
          ? _value.dbBeginTimeOffsetMs
          : dbBeginTimeOffsetMs // ignore: cast_nullable_to_non_nullable
              as int?,
      dbEndTimeOffsetMs: freezed == dbEndTimeOffsetMs
          ? _value.dbEndTimeOffsetMs
          : dbEndTimeOffsetMs // ignore: cast_nullable_to_non_nullable
              as int?,
      sampleBeginTimeOffsetMs: freezed == sampleBeginTimeOffsetMs
          ? _value.sampleBeginTimeOffsetMs
          : sampleBeginTimeOffsetMs // ignore: cast_nullable_to_non_nullable
              as int?,
      sampleEndTimeOffsetMs: freezed == sampleEndTimeOffsetMs
          ? _value.sampleEndTimeOffsetMs
          : sampleEndTimeOffsetMs // ignore: cast_nullable_to_non_nullable
              as int?,
      playOffsetMs: freezed == playOffsetMs
          ? _value.playOffsetMs
          : playOffsetMs // ignore: cast_nullable_to_non_nullable
              as int?,
      artists: freezed == artists
          ? _value.artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<MusicAlbum>?,
      lyrics: freezed == lyrics
          ? _value.lyrics
          : lyrics // ignore: cast_nullable_to_non_nullable
              as Lyrics?,
      acrid: freezed == acrid
          ? _value.acrid
          : acrid // ignore: cast_nullable_to_non_nullable
              as String?,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as MusicAlbum?,
      rightsClaim: freezed == rightsClaim
          ? _value.rightsClaim
          : rightsClaim // ignore: cast_nullable_to_non_nullable
              as List<RightsClaim>?,
      externalIds: freezed == externalIds
          ? _value.externalIds
          : externalIds // ignore: cast_nullable_to_non_nullable
              as ExternalIds?,
      resultFrom: freezed == resultFrom
          ? _value.resultFrom
          : resultFrom // ignore: cast_nullable_to_non_nullable
              as int?,
      contributors: freezed == contributors
          ? _value.contributors
          : contributors // ignore: cast_nullable_to_non_nullable
              as Contributors?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      langs: freezed == langs
          ? _value.langs
          : langs // ignore: cast_nullable_to_non_nullable
              as List<Lang>?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMs: freezed == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      externalMetadata: freezed == externalMetadata
          ? _value.externalMetadata
          : externalMetadata // ignore: cast_nullable_to_non_nullable
              as ExternalMetadata?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
      genres: freezed == genres
          ? _value.genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      releaseByTerritories: freezed == releaseByTerritories
          ? _value.releaseByTerritories
          : releaseByTerritories // ignore: cast_nullable_to_non_nullable
              as List<ReleaseByTerritory>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LyricsCopyWith<$Res>? get lyrics {
    if (_value.lyrics == null) {
      return null;
    }

    return $LyricsCopyWith<$Res>(_value.lyrics!, (value) {
      return _then(_value.copyWith(lyrics: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MusicAlbumCopyWith<$Res>? get album {
    if (_value.album == null) {
      return null;
    }

    return $MusicAlbumCopyWith<$Res>(_value.album!, (value) {
      return _then(_value.copyWith(album: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ExternalIdsCopyWith<$Res>? get externalIds {
    if (_value.externalIds == null) {
      return null;
    }

    return $ExternalIdsCopyWith<$Res>(_value.externalIds!, (value) {
      return _then(_value.copyWith(externalIds: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ContributorsCopyWith<$Res>? get contributors {
    if (_value.contributors == null) {
      return null;
    }

    return $ContributorsCopyWith<$Res>(_value.contributors!, (value) {
      return _then(_value.copyWith(contributors: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ExternalMetadataCopyWith<$Res>? get externalMetadata {
    if (_value.externalMetadata == null) {
      return null;
    }

    return $ExternalMetadataCopyWith<$Res>(_value.externalMetadata!, (value) {
      return _then(_value.copyWith(externalMetadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MusicCopyWith<$Res> implements $MusicCopyWith<$Res> {
  factory _$$_MusicCopyWith(_$_Music value, $Res Function(_$_Music) then) =
      __$$_MusicCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? dbBeginTimeOffsetMs,
      int? dbEndTimeOffsetMs,
      int? sampleBeginTimeOffsetMs,
      int? sampleEndTimeOffsetMs,
      int? playOffsetMs,
      List<MusicAlbum>? artists,
      Lyrics? lyrics,
      String? acrid,
      MusicAlbum? album,
      List<RightsClaim>? rightsClaim,
      ExternalIds? externalIds,
      int? resultFrom,
      Contributors? contributors,
      String? title,
      List<Lang>? langs,
      String? language,
      int? durationMs,
      String? label,
      ExternalMetadata? externalMetadata,
      int? score,
      List<Genre>? genres,
      DateTime? releaseDate,
      List<ReleaseByTerritory>? releaseByTerritories});

  @override
  $LyricsCopyWith<$Res>? get lyrics;
  @override
  $MusicAlbumCopyWith<$Res>? get album;
  @override
  $ExternalIdsCopyWith<$Res>? get externalIds;
  @override
  $ContributorsCopyWith<$Res>? get contributors;
  @override
  $ExternalMetadataCopyWith<$Res>? get externalMetadata;
}

/// @nodoc
class __$$_MusicCopyWithImpl<$Res> extends _$MusicCopyWithImpl<$Res, _$_Music>
    implements _$$_MusicCopyWith<$Res> {
  __$$_MusicCopyWithImpl(_$_Music _value, $Res Function(_$_Music) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dbBeginTimeOffsetMs = freezed,
    Object? dbEndTimeOffsetMs = freezed,
    Object? sampleBeginTimeOffsetMs = freezed,
    Object? sampleEndTimeOffsetMs = freezed,
    Object? playOffsetMs = freezed,
    Object? artists = freezed,
    Object? lyrics = freezed,
    Object? acrid = freezed,
    Object? album = freezed,
    Object? rightsClaim = freezed,
    Object? externalIds = freezed,
    Object? resultFrom = freezed,
    Object? contributors = freezed,
    Object? title = freezed,
    Object? langs = freezed,
    Object? language = freezed,
    Object? durationMs = freezed,
    Object? label = freezed,
    Object? externalMetadata = freezed,
    Object? score = freezed,
    Object? genres = freezed,
    Object? releaseDate = freezed,
    Object? releaseByTerritories = freezed,
  }) {
    return _then(_$_Music(
      dbBeginTimeOffsetMs: freezed == dbBeginTimeOffsetMs
          ? _value.dbBeginTimeOffsetMs
          : dbBeginTimeOffsetMs // ignore: cast_nullable_to_non_nullable
              as int?,
      dbEndTimeOffsetMs: freezed == dbEndTimeOffsetMs
          ? _value.dbEndTimeOffsetMs
          : dbEndTimeOffsetMs // ignore: cast_nullable_to_non_nullable
              as int?,
      sampleBeginTimeOffsetMs: freezed == sampleBeginTimeOffsetMs
          ? _value.sampleBeginTimeOffsetMs
          : sampleBeginTimeOffsetMs // ignore: cast_nullable_to_non_nullable
              as int?,
      sampleEndTimeOffsetMs: freezed == sampleEndTimeOffsetMs
          ? _value.sampleEndTimeOffsetMs
          : sampleEndTimeOffsetMs // ignore: cast_nullable_to_non_nullable
              as int?,
      playOffsetMs: freezed == playOffsetMs
          ? _value.playOffsetMs
          : playOffsetMs // ignore: cast_nullable_to_non_nullable
              as int?,
      artists: freezed == artists
          ? _value._artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<MusicAlbum>?,
      lyrics: freezed == lyrics
          ? _value.lyrics
          : lyrics // ignore: cast_nullable_to_non_nullable
              as Lyrics?,
      acrid: freezed == acrid
          ? _value.acrid
          : acrid // ignore: cast_nullable_to_non_nullable
              as String?,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as MusicAlbum?,
      rightsClaim: freezed == rightsClaim
          ? _value._rightsClaim
          : rightsClaim // ignore: cast_nullable_to_non_nullable
              as List<RightsClaim>?,
      externalIds: freezed == externalIds
          ? _value.externalIds
          : externalIds // ignore: cast_nullable_to_non_nullable
              as ExternalIds?,
      resultFrom: freezed == resultFrom
          ? _value.resultFrom
          : resultFrom // ignore: cast_nullable_to_non_nullable
              as int?,
      contributors: freezed == contributors
          ? _value.contributors
          : contributors // ignore: cast_nullable_to_non_nullable
              as Contributors?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      langs: freezed == langs
          ? _value._langs
          : langs // ignore: cast_nullable_to_non_nullable
              as List<Lang>?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      durationMs: freezed == durationMs
          ? _value.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int?,
      label: freezed == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      externalMetadata: freezed == externalMetadata
          ? _value.externalMetadata
          : externalMetadata // ignore: cast_nullable_to_non_nullable
              as ExternalMetadata?,
      score: freezed == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int?,
      genres: freezed == genres
          ? _value._genres
          : genres // ignore: cast_nullable_to_non_nullable
              as List<Genre>?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      releaseByTerritories: freezed == releaseByTerritories
          ? _value._releaseByTerritories
          : releaseByTerritories // ignore: cast_nullable_to_non_nullable
              as List<ReleaseByTerritory>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Music implements _Music {
  const _$_Music(
      {this.dbBeginTimeOffsetMs,
      this.dbEndTimeOffsetMs,
      this.sampleBeginTimeOffsetMs,
      this.sampleEndTimeOffsetMs,
      this.playOffsetMs,
      final List<MusicAlbum>? artists,
      this.lyrics,
      this.acrid,
      this.album,
      final List<RightsClaim>? rightsClaim,
      this.externalIds,
      this.resultFrom,
      this.contributors,
      this.title,
      final List<Lang>? langs,
      this.language,
      this.durationMs,
      this.label,
      this.externalMetadata,
      this.score,
      final List<Genre>? genres,
      this.releaseDate,
      final List<ReleaseByTerritory>? releaseByTerritories})
      : _artists = artists,
        _rightsClaim = rightsClaim,
        _langs = langs,
        _genres = genres,
        _releaseByTerritories = releaseByTerritories;

  factory _$_Music.fromJson(Map<String, dynamic> json) =>
      _$$_MusicFromJson(json);

  @override
  final int? dbBeginTimeOffsetMs;
  @override
  final int? dbEndTimeOffsetMs;
  @override
  final int? sampleBeginTimeOffsetMs;
  @override
  final int? sampleEndTimeOffsetMs;
  @override
  final int? playOffsetMs;
  final List<MusicAlbum>? _artists;
  @override
  List<MusicAlbum>? get artists {
    final value = _artists;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Lyrics? lyrics;
  @override
  final String? acrid;
  @override
  final MusicAlbum? album;
  final List<RightsClaim>? _rightsClaim;
  @override
  List<RightsClaim>? get rightsClaim {
    final value = _rightsClaim;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ExternalIds? externalIds;
  @override
  final int? resultFrom;
  @override
  final Contributors? contributors;
  @override
  final String? title;
  final List<Lang>? _langs;
  @override
  List<Lang>? get langs {
    final value = _langs;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? language;
  @override
  final int? durationMs;
  @override
  final String? label;
  @override
  final ExternalMetadata? externalMetadata;
  @override
  final int? score;
  final List<Genre>? _genres;
  @override
  List<Genre>? get genres {
    final value = _genres;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? releaseDate;
  final List<ReleaseByTerritory>? _releaseByTerritories;
  @override
  List<ReleaseByTerritory>? get releaseByTerritories {
    final value = _releaseByTerritories;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Music(dbBeginTimeOffsetMs: $dbBeginTimeOffsetMs, dbEndTimeOffsetMs: $dbEndTimeOffsetMs, sampleBeginTimeOffsetMs: $sampleBeginTimeOffsetMs, sampleEndTimeOffsetMs: $sampleEndTimeOffsetMs, playOffsetMs: $playOffsetMs, artists: $artists, lyrics: $lyrics, acrid: $acrid, album: $album, rightsClaim: $rightsClaim, externalIds: $externalIds, resultFrom: $resultFrom, contributors: $contributors, title: $title, langs: $langs, language: $language, durationMs: $durationMs, label: $label, externalMetadata: $externalMetadata, score: $score, genres: $genres, releaseDate: $releaseDate, releaseByTerritories: $releaseByTerritories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Music &&
            (identical(other.dbBeginTimeOffsetMs, dbBeginTimeOffsetMs) ||
                other.dbBeginTimeOffsetMs == dbBeginTimeOffsetMs) &&
            (identical(other.dbEndTimeOffsetMs, dbEndTimeOffsetMs) ||
                other.dbEndTimeOffsetMs == dbEndTimeOffsetMs) &&
            (identical(
                    other.sampleBeginTimeOffsetMs, sampleBeginTimeOffsetMs) ||
                other.sampleBeginTimeOffsetMs == sampleBeginTimeOffsetMs) &&
            (identical(other.sampleEndTimeOffsetMs, sampleEndTimeOffsetMs) ||
                other.sampleEndTimeOffsetMs == sampleEndTimeOffsetMs) &&
            (identical(other.playOffsetMs, playOffsetMs) ||
                other.playOffsetMs == playOffsetMs) &&
            const DeepCollectionEquality().equals(other._artists, _artists) &&
            (identical(other.lyrics, lyrics) || other.lyrics == lyrics) &&
            (identical(other.acrid, acrid) || other.acrid == acrid) &&
            (identical(other.album, album) || other.album == album) &&
            const DeepCollectionEquality()
                .equals(other._rightsClaim, _rightsClaim) &&
            (identical(other.externalIds, externalIds) ||
                other.externalIds == externalIds) &&
            (identical(other.resultFrom, resultFrom) ||
                other.resultFrom == resultFrom) &&
            (identical(other.contributors, contributors) ||
                other.contributors == contributors) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._langs, _langs) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.externalMetadata, externalMetadata) ||
                other.externalMetadata == externalMetadata) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            const DeepCollectionEquality()
                .equals(other._releaseByTerritories, _releaseByTerritories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        dbBeginTimeOffsetMs,
        dbEndTimeOffsetMs,
        sampleBeginTimeOffsetMs,
        sampleEndTimeOffsetMs,
        playOffsetMs,
        const DeepCollectionEquality().hash(_artists),
        lyrics,
        acrid,
        album,
        const DeepCollectionEquality().hash(_rightsClaim),
        externalIds,
        resultFrom,
        contributors,
        title,
        const DeepCollectionEquality().hash(_langs),
        language,
        durationMs,
        label,
        externalMetadata,
        score,
        const DeepCollectionEquality().hash(_genres),
        releaseDate,
        const DeepCollectionEquality().hash(_releaseByTerritories)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MusicCopyWith<_$_Music> get copyWith =>
      __$$_MusicCopyWithImpl<_$_Music>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MusicToJson(
      this,
    );
  }
}

abstract class _Music implements Music {
  const factory _Music(
      {final int? dbBeginTimeOffsetMs,
      final int? dbEndTimeOffsetMs,
      final int? sampleBeginTimeOffsetMs,
      final int? sampleEndTimeOffsetMs,
      final int? playOffsetMs,
      final List<MusicAlbum>? artists,
      final Lyrics? lyrics,
      final String? acrid,
      final MusicAlbum? album,
      final List<RightsClaim>? rightsClaim,
      final ExternalIds? externalIds,
      final int? resultFrom,
      final Contributors? contributors,
      final String? title,
      final List<Lang>? langs,
      final String? language,
      final int? durationMs,
      final String? label,
      final ExternalMetadata? externalMetadata,
      final int? score,
      final List<Genre>? genres,
      final DateTime? releaseDate,
      final List<ReleaseByTerritory>? releaseByTerritories}) = _$_Music;

  factory _Music.fromJson(Map<String, dynamic> json) = _$_Music.fromJson;

  @override
  int? get dbBeginTimeOffsetMs;
  @override
  int? get dbEndTimeOffsetMs;
  @override
  int? get sampleBeginTimeOffsetMs;
  @override
  int? get sampleEndTimeOffsetMs;
  @override
  int? get playOffsetMs;
  @override
  List<MusicAlbum>? get artists;
  @override
  Lyrics? get lyrics;
  @override
  String? get acrid;
  @override
  MusicAlbum? get album;
  @override
  List<RightsClaim>? get rightsClaim;
  @override
  ExternalIds? get externalIds;
  @override
  int? get resultFrom;
  @override
  Contributors? get contributors;
  @override
  String? get title;
  @override
  List<Lang>? get langs;
  @override
  String? get language;
  @override
  int? get durationMs;
  @override
  String? get label;
  @override
  ExternalMetadata? get externalMetadata;
  @override
  int? get score;
  @override
  List<Genre>? get genres;
  @override
  DateTime? get releaseDate;
  @override
  List<ReleaseByTerritory>? get releaseByTerritories;
  @override
  @JsonKey(ignore: true)
  _$$_MusicCopyWith<_$_Music> get copyWith =>
      throw _privateConstructorUsedError;
}

MusicAlbum _$MusicAlbumFromJson(Map<String, dynamic> json) {
  return _MusicAlbum.fromJson(json);
}

/// @nodoc
mixin _$MusicAlbum {
  String? get name => throw _privateConstructorUsedError;
  List<Lang>? get langs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MusicAlbumCopyWith<MusicAlbum> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicAlbumCopyWith<$Res> {
  factory $MusicAlbumCopyWith(
          MusicAlbum value, $Res Function(MusicAlbum) then) =
      _$MusicAlbumCopyWithImpl<$Res, MusicAlbum>;
  @useResult
  $Res call({String? name, List<Lang>? langs});
}

/// @nodoc
class _$MusicAlbumCopyWithImpl<$Res, $Val extends MusicAlbum>
    implements $MusicAlbumCopyWith<$Res> {
  _$MusicAlbumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? langs = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      langs: freezed == langs
          ? _value.langs
          : langs // ignore: cast_nullable_to_non_nullable
              as List<Lang>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MusicAlbumCopyWith<$Res>
    implements $MusicAlbumCopyWith<$Res> {
  factory _$$_MusicAlbumCopyWith(
          _$_MusicAlbum value, $Res Function(_$_MusicAlbum) then) =
      __$$_MusicAlbumCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, List<Lang>? langs});
}

/// @nodoc
class __$$_MusicAlbumCopyWithImpl<$Res>
    extends _$MusicAlbumCopyWithImpl<$Res, _$_MusicAlbum>
    implements _$$_MusicAlbumCopyWith<$Res> {
  __$$_MusicAlbumCopyWithImpl(
      _$_MusicAlbum _value, $Res Function(_$_MusicAlbum) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? langs = freezed,
  }) {
    return _then(_$_MusicAlbum(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      langs: freezed == langs
          ? _value._langs
          : langs // ignore: cast_nullable_to_non_nullable
              as List<Lang>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MusicAlbum implements _MusicAlbum {
  const _$_MusicAlbum({this.name, final List<Lang>? langs}) : _langs = langs;

  factory _$_MusicAlbum.fromJson(Map<String, dynamic> json) =>
      _$$_MusicAlbumFromJson(json);

  @override
  final String? name;
  final List<Lang>? _langs;
  @override
  List<Lang>? get langs {
    final value = _langs;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MusicAlbum(name: $name, langs: $langs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MusicAlbum &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._langs, _langs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_langs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MusicAlbumCopyWith<_$_MusicAlbum> get copyWith =>
      __$$_MusicAlbumCopyWithImpl<_$_MusicAlbum>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MusicAlbumToJson(
      this,
    );
  }
}

abstract class _MusicAlbum implements MusicAlbum {
  const factory _MusicAlbum({final String? name, final List<Lang>? langs}) =
      _$_MusicAlbum;

  factory _MusicAlbum.fromJson(Map<String, dynamic> json) =
      _$_MusicAlbum.fromJson;

  @override
  String? get name;
  @override
  List<Lang>? get langs;
  @override
  @JsonKey(ignore: true)
  _$$_MusicAlbumCopyWith<_$_MusicAlbum> get copyWith =>
      throw _privateConstructorUsedError;
}

Lang _$LangFromJson(Map<String, dynamic> json) {
  return _Lang.fromJson(json);
}

/// @nodoc
mixin _$Lang {
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LangCopyWith<Lang> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LangCopyWith<$Res> {
  factory $LangCopyWith(Lang value, $Res Function(Lang) then) =
      _$LangCopyWithImpl<$Res, Lang>;
  @useResult
  $Res call({String? code, String? name});
}

/// @nodoc
class _$LangCopyWithImpl<$Res, $Val extends Lang>
    implements $LangCopyWith<$Res> {
  _$LangCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LangCopyWith<$Res> implements $LangCopyWith<$Res> {
  factory _$$_LangCopyWith(_$_Lang value, $Res Function(_$_Lang) then) =
      __$$_LangCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? name});
}

/// @nodoc
class __$$_LangCopyWithImpl<$Res> extends _$LangCopyWithImpl<$Res, _$_Lang>
    implements _$$_LangCopyWith<$Res> {
  __$$_LangCopyWithImpl(_$_Lang _value, $Res Function(_$_Lang) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_Lang(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Lang implements _Lang {
  const _$_Lang({this.code, this.name});

  factory _$_Lang.fromJson(Map<String, dynamic> json) => _$$_LangFromJson(json);

  @override
  final String? code;
  @override
  final String? name;

  @override
  String toString() {
    return 'Lang(code: $code, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Lang &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LangCopyWith<_$_Lang> get copyWith =>
      __$$_LangCopyWithImpl<_$_Lang>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LangToJson(
      this,
    );
  }
}

abstract class _Lang implements Lang {
  const factory _Lang({final String? code, final String? name}) = _$_Lang;

  factory _Lang.fromJson(Map<String, dynamic> json) = _$_Lang.fromJson;

  @override
  String? get code;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_LangCopyWith<_$_Lang> get copyWith => throw _privateConstructorUsedError;
}

Contributors _$ContributorsFromJson(Map<String, dynamic> json) {
  return _Contributors.fromJson(json);
}

/// @nodoc
mixin _$Contributors {
  List<String>? get composers => throw _privateConstructorUsedError;
  List<String>? get lyricists => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContributorsCopyWith<Contributors> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContributorsCopyWith<$Res> {
  factory $ContributorsCopyWith(
          Contributors value, $Res Function(Contributors) then) =
      _$ContributorsCopyWithImpl<$Res, Contributors>;
  @useResult
  $Res call({List<String>? composers, List<String>? lyricists});
}

/// @nodoc
class _$ContributorsCopyWithImpl<$Res, $Val extends Contributors>
    implements $ContributorsCopyWith<$Res> {
  _$ContributorsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? composers = freezed,
    Object? lyricists = freezed,
  }) {
    return _then(_value.copyWith(
      composers: freezed == composers
          ? _value.composers
          : composers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      lyricists: freezed == lyricists
          ? _value.lyricists
          : lyricists // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ContributorsCopyWith<$Res>
    implements $ContributorsCopyWith<$Res> {
  factory _$$_ContributorsCopyWith(
          _$_Contributors value, $Res Function(_$_Contributors) then) =
      __$$_ContributorsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? composers, List<String>? lyricists});
}

/// @nodoc
class __$$_ContributorsCopyWithImpl<$Res>
    extends _$ContributorsCopyWithImpl<$Res, _$_Contributors>
    implements _$$_ContributorsCopyWith<$Res> {
  __$$_ContributorsCopyWithImpl(
      _$_Contributors _value, $Res Function(_$_Contributors) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? composers = freezed,
    Object? lyricists = freezed,
  }) {
    return _then(_$_Contributors(
      composers: freezed == composers
          ? _value._composers
          : composers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      lyricists: freezed == lyricists
          ? _value._lyricists
          : lyricists // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Contributors implements _Contributors {
  const _$_Contributors(
      {final List<String>? composers, final List<String>? lyricists})
      : _composers = composers,
        _lyricists = lyricists;

  factory _$_Contributors.fromJson(Map<String, dynamic> json) =>
      _$$_ContributorsFromJson(json);

  final List<String>? _composers;
  @override
  List<String>? get composers {
    final value = _composers;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _lyricists;
  @override
  List<String>? get lyricists {
    final value = _lyricists;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Contributors(composers: $composers, lyricists: $lyricists)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Contributors &&
            const DeepCollectionEquality()
                .equals(other._composers, _composers) &&
            const DeepCollectionEquality()
                .equals(other._lyricists, _lyricists));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_composers),
      const DeepCollectionEquality().hash(_lyricists));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ContributorsCopyWith<_$_Contributors> get copyWith =>
      __$$_ContributorsCopyWithImpl<_$_Contributors>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ContributorsToJson(
      this,
    );
  }
}

abstract class _Contributors implements Contributors {
  const factory _Contributors(
      {final List<String>? composers,
      final List<String>? lyricists}) = _$_Contributors;

  factory _Contributors.fromJson(Map<String, dynamic> json) =
      _$_Contributors.fromJson;

  @override
  List<String>? get composers;
  @override
  List<String>? get lyricists;
  @override
  @JsonKey(ignore: true)
  _$$_ContributorsCopyWith<_$_Contributors> get copyWith =>
      throw _privateConstructorUsedError;
}

ExternalIds _$ExternalIdsFromJson(Map<String, dynamic> json) {
  return _ExternalIds.fromJson(json);
}

/// @nodoc
mixin _$ExternalIds {
  String? get iswc => throw _privateConstructorUsedError;
  String? get isrc => throw _privateConstructorUsedError;
  String? get upc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExternalIdsCopyWith<ExternalIds> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalIdsCopyWith<$Res> {
  factory $ExternalIdsCopyWith(
          ExternalIds value, $Res Function(ExternalIds) then) =
      _$ExternalIdsCopyWithImpl<$Res, ExternalIds>;
  @useResult
  $Res call({String? iswc, String? isrc, String? upc});
}

/// @nodoc
class _$ExternalIdsCopyWithImpl<$Res, $Val extends ExternalIds>
    implements $ExternalIdsCopyWith<$Res> {
  _$ExternalIdsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iswc = freezed,
    Object? isrc = freezed,
    Object? upc = freezed,
  }) {
    return _then(_value.copyWith(
      iswc: freezed == iswc
          ? _value.iswc
          : iswc // ignore: cast_nullable_to_non_nullable
              as String?,
      isrc: freezed == isrc
          ? _value.isrc
          : isrc // ignore: cast_nullable_to_non_nullable
              as String?,
      upc: freezed == upc
          ? _value.upc
          : upc // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ExternalIdsCopyWith<$Res>
    implements $ExternalIdsCopyWith<$Res> {
  factory _$$_ExternalIdsCopyWith(
          _$_ExternalIds value, $Res Function(_$_ExternalIds) then) =
      __$$_ExternalIdsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? iswc, String? isrc, String? upc});
}

/// @nodoc
class __$$_ExternalIdsCopyWithImpl<$Res>
    extends _$ExternalIdsCopyWithImpl<$Res, _$_ExternalIds>
    implements _$$_ExternalIdsCopyWith<$Res> {
  __$$_ExternalIdsCopyWithImpl(
      _$_ExternalIds _value, $Res Function(_$_ExternalIds) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iswc = freezed,
    Object? isrc = freezed,
    Object? upc = freezed,
  }) {
    return _then(_$_ExternalIds(
      iswc: freezed == iswc
          ? _value.iswc
          : iswc // ignore: cast_nullable_to_non_nullable
              as String?,
      isrc: freezed == isrc
          ? _value.isrc
          : isrc // ignore: cast_nullable_to_non_nullable
              as String?,
      upc: freezed == upc
          ? _value.upc
          : upc // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExternalIds implements _ExternalIds {
  const _$_ExternalIds({this.iswc, this.isrc, this.upc});

  factory _$_ExternalIds.fromJson(Map<String, dynamic> json) =>
      _$$_ExternalIdsFromJson(json);

  @override
  final String? iswc;
  @override
  final String? isrc;
  @override
  final String? upc;

  @override
  String toString() {
    return 'ExternalIds(iswc: $iswc, isrc: $isrc, upc: $upc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExternalIds &&
            (identical(other.iswc, iswc) || other.iswc == iswc) &&
            (identical(other.isrc, isrc) || other.isrc == isrc) &&
            (identical(other.upc, upc) || other.upc == upc));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, iswc, isrc, upc);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExternalIdsCopyWith<_$_ExternalIds> get copyWith =>
      __$$_ExternalIdsCopyWithImpl<_$_ExternalIds>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExternalIdsToJson(
      this,
    );
  }
}

abstract class _ExternalIds implements ExternalIds {
  const factory _ExternalIds(
      {final String? iswc,
      final String? isrc,
      final String? upc}) = _$_ExternalIds;

  factory _ExternalIds.fromJson(Map<String, dynamic> json) =
      _$_ExternalIds.fromJson;

  @override
  String? get iswc;
  @override
  String? get isrc;
  @override
  String? get upc;
  @override
  @JsonKey(ignore: true)
  _$$_ExternalIdsCopyWith<_$_ExternalIds> get copyWith =>
      throw _privateConstructorUsedError;
}

ExternalMetadata _$ExternalMetadataFromJson(Map<String, dynamic> json) {
  return _ExternalMetadata.fromJson(json);
}

/// @nodoc
mixin _$ExternalMetadata {
  List<Musicbrainz>? get musicbrainz => throw _privateConstructorUsedError;
  Deezer? get deezer => throw _privateConstructorUsedError;
  Deezer? get spotify => throw _privateConstructorUsedError;
  Musicstory? get musicstory => throw _privateConstructorUsedError;
  Youtube? get youtube => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExternalMetadataCopyWith<ExternalMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExternalMetadataCopyWith<$Res> {
  factory $ExternalMetadataCopyWith(
          ExternalMetadata value, $Res Function(ExternalMetadata) then) =
      _$ExternalMetadataCopyWithImpl<$Res, ExternalMetadata>;
  @useResult
  $Res call(
      {List<Musicbrainz>? musicbrainz,
      Deezer? deezer,
      Deezer? spotify,
      Musicstory? musicstory,
      Youtube? youtube});

  $DeezerCopyWith<$Res>? get deezer;
  $DeezerCopyWith<$Res>? get spotify;
  $MusicstoryCopyWith<$Res>? get musicstory;
  $YoutubeCopyWith<$Res>? get youtube;
}

/// @nodoc
class _$ExternalMetadataCopyWithImpl<$Res, $Val extends ExternalMetadata>
    implements $ExternalMetadataCopyWith<$Res> {
  _$ExternalMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? musicbrainz = freezed,
    Object? deezer = freezed,
    Object? spotify = freezed,
    Object? musicstory = freezed,
    Object? youtube = freezed,
  }) {
    return _then(_value.copyWith(
      musicbrainz: freezed == musicbrainz
          ? _value.musicbrainz
          : musicbrainz // ignore: cast_nullable_to_non_nullable
              as List<Musicbrainz>?,
      deezer: freezed == deezer
          ? _value.deezer
          : deezer // ignore: cast_nullable_to_non_nullable
              as Deezer?,
      spotify: freezed == spotify
          ? _value.spotify
          : spotify // ignore: cast_nullable_to_non_nullable
              as Deezer?,
      musicstory: freezed == musicstory
          ? _value.musicstory
          : musicstory // ignore: cast_nullable_to_non_nullable
              as Musicstory?,
      youtube: freezed == youtube
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as Youtube?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DeezerCopyWith<$Res>? get deezer {
    if (_value.deezer == null) {
      return null;
    }

    return $DeezerCopyWith<$Res>(_value.deezer!, (value) {
      return _then(_value.copyWith(deezer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $DeezerCopyWith<$Res>? get spotify {
    if (_value.spotify == null) {
      return null;
    }

    return $DeezerCopyWith<$Res>(_value.spotify!, (value) {
      return _then(_value.copyWith(spotify: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MusicstoryCopyWith<$Res>? get musicstory {
    if (_value.musicstory == null) {
      return null;
    }

    return $MusicstoryCopyWith<$Res>(_value.musicstory!, (value) {
      return _then(_value.copyWith(musicstory: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $YoutubeCopyWith<$Res>? get youtube {
    if (_value.youtube == null) {
      return null;
    }

    return $YoutubeCopyWith<$Res>(_value.youtube!, (value) {
      return _then(_value.copyWith(youtube: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ExternalMetadataCopyWith<$Res>
    implements $ExternalMetadataCopyWith<$Res> {
  factory _$$_ExternalMetadataCopyWith(
          _$_ExternalMetadata value, $Res Function(_$_ExternalMetadata) then) =
      __$$_ExternalMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Musicbrainz>? musicbrainz,
      Deezer? deezer,
      Deezer? spotify,
      Musicstory? musicstory,
      Youtube? youtube});

  @override
  $DeezerCopyWith<$Res>? get deezer;
  @override
  $DeezerCopyWith<$Res>? get spotify;
  @override
  $MusicstoryCopyWith<$Res>? get musicstory;
  @override
  $YoutubeCopyWith<$Res>? get youtube;
}

/// @nodoc
class __$$_ExternalMetadataCopyWithImpl<$Res>
    extends _$ExternalMetadataCopyWithImpl<$Res, _$_ExternalMetadata>
    implements _$$_ExternalMetadataCopyWith<$Res> {
  __$$_ExternalMetadataCopyWithImpl(
      _$_ExternalMetadata _value, $Res Function(_$_ExternalMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? musicbrainz = freezed,
    Object? deezer = freezed,
    Object? spotify = freezed,
    Object? musicstory = freezed,
    Object? youtube = freezed,
  }) {
    return _then(_$_ExternalMetadata(
      musicbrainz: freezed == musicbrainz
          ? _value._musicbrainz
          : musicbrainz // ignore: cast_nullable_to_non_nullable
              as List<Musicbrainz>?,
      deezer: freezed == deezer
          ? _value.deezer
          : deezer // ignore: cast_nullable_to_non_nullable
              as Deezer?,
      spotify: freezed == spotify
          ? _value.spotify
          : spotify // ignore: cast_nullable_to_non_nullable
              as Deezer?,
      musicstory: freezed == musicstory
          ? _value.musicstory
          : musicstory // ignore: cast_nullable_to_non_nullable
              as Musicstory?,
      youtube: freezed == youtube
          ? _value.youtube
          : youtube // ignore: cast_nullable_to_non_nullable
              as Youtube?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ExternalMetadata implements _ExternalMetadata {
  const _$_ExternalMetadata(
      {final List<Musicbrainz>? musicbrainz,
      this.deezer,
      this.spotify,
      this.musicstory,
      this.youtube})
      : _musicbrainz = musicbrainz;

  factory _$_ExternalMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_ExternalMetadataFromJson(json);

  final List<Musicbrainz>? _musicbrainz;
  @override
  List<Musicbrainz>? get musicbrainz {
    final value = _musicbrainz;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Deezer? deezer;
  @override
  final Deezer? spotify;
  @override
  final Musicstory? musicstory;
  @override
  final Youtube? youtube;

  @override
  String toString() {
    return 'ExternalMetadata(musicbrainz: $musicbrainz, deezer: $deezer, spotify: $spotify, musicstory: $musicstory, youtube: $youtube)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ExternalMetadata &&
            const DeepCollectionEquality()
                .equals(other._musicbrainz, _musicbrainz) &&
            (identical(other.deezer, deezer) || other.deezer == deezer) &&
            (identical(other.spotify, spotify) || other.spotify == spotify) &&
            (identical(other.musicstory, musicstory) ||
                other.musicstory == musicstory) &&
            (identical(other.youtube, youtube) || other.youtube == youtube));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_musicbrainz),
      deezer,
      spotify,
      musicstory,
      youtube);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ExternalMetadataCopyWith<_$_ExternalMetadata> get copyWith =>
      __$$_ExternalMetadataCopyWithImpl<_$_ExternalMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ExternalMetadataToJson(
      this,
    );
  }
}

abstract class _ExternalMetadata implements ExternalMetadata {
  const factory _ExternalMetadata(
      {final List<Musicbrainz>? musicbrainz,
      final Deezer? deezer,
      final Deezer? spotify,
      final Musicstory? musicstory,
      final Youtube? youtube}) = _$_ExternalMetadata;

  factory _ExternalMetadata.fromJson(Map<String, dynamic> json) =
      _$_ExternalMetadata.fromJson;

  @override
  List<Musicbrainz>? get musicbrainz;
  @override
  Deezer? get deezer;
  @override
  Deezer? get spotify;
  @override
  Musicstory? get musicstory;
  @override
  Youtube? get youtube;
  @override
  @JsonKey(ignore: true)
  _$$_ExternalMetadataCopyWith<_$_ExternalMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

Deezer _$DeezerFromJson(Map<String, dynamic> json) {
  return _Deezer.fromJson(json);
}

/// @nodoc
mixin _$Deezer {
  TrackClass? get track => throw _privateConstructorUsedError;
  List<TrackClass>? get artists => throw _privateConstructorUsedError;
  TrackClass? get album => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DeezerCopyWith<Deezer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeezerCopyWith<$Res> {
  factory $DeezerCopyWith(Deezer value, $Res Function(Deezer) then) =
      _$DeezerCopyWithImpl<$Res, Deezer>;
  @useResult
  $Res call({TrackClass? track, List<TrackClass>? artists, TrackClass? album});

  $TrackClassCopyWith<$Res>? get track;
  $TrackClassCopyWith<$Res>? get album;
}

/// @nodoc
class _$DeezerCopyWithImpl<$Res, $Val extends Deezer>
    implements $DeezerCopyWith<$Res> {
  _$DeezerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? track = freezed,
    Object? artists = freezed,
    Object? album = freezed,
  }) {
    return _then(_value.copyWith(
      track: freezed == track
          ? _value.track
          : track // ignore: cast_nullable_to_non_nullable
              as TrackClass?,
      artists: freezed == artists
          ? _value.artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<TrackClass>?,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as TrackClass?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TrackClassCopyWith<$Res>? get track {
    if (_value.track == null) {
      return null;
    }

    return $TrackClassCopyWith<$Res>(_value.track!, (value) {
      return _then(_value.copyWith(track: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TrackClassCopyWith<$Res>? get album {
    if (_value.album == null) {
      return null;
    }

    return $TrackClassCopyWith<$Res>(_value.album!, (value) {
      return _then(_value.copyWith(album: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DeezerCopyWith<$Res> implements $DeezerCopyWith<$Res> {
  factory _$$_DeezerCopyWith(_$_Deezer value, $Res Function(_$_Deezer) then) =
      __$$_DeezerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TrackClass? track, List<TrackClass>? artists, TrackClass? album});

  @override
  $TrackClassCopyWith<$Res>? get track;
  @override
  $TrackClassCopyWith<$Res>? get album;
}

/// @nodoc
class __$$_DeezerCopyWithImpl<$Res>
    extends _$DeezerCopyWithImpl<$Res, _$_Deezer>
    implements _$$_DeezerCopyWith<$Res> {
  __$$_DeezerCopyWithImpl(_$_Deezer _value, $Res Function(_$_Deezer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? track = freezed,
    Object? artists = freezed,
    Object? album = freezed,
  }) {
    return _then(_$_Deezer(
      track: freezed == track
          ? _value.track
          : track // ignore: cast_nullable_to_non_nullable
              as TrackClass?,
      artists: freezed == artists
          ? _value._artists
          : artists // ignore: cast_nullable_to_non_nullable
              as List<TrackClass>?,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as TrackClass?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Deezer implements _Deezer {
  const _$_Deezer({this.track, final List<TrackClass>? artists, this.album})
      : _artists = artists;

  factory _$_Deezer.fromJson(Map<String, dynamic> json) =>
      _$$_DeezerFromJson(json);

  @override
  final TrackClass? track;
  final List<TrackClass>? _artists;
  @override
  List<TrackClass>? get artists {
    final value = _artists;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final TrackClass? album;

  @override
  String toString() {
    return 'Deezer(track: $track, artists: $artists, album: $album)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Deezer &&
            (identical(other.track, track) || other.track == track) &&
            const DeepCollectionEquality().equals(other._artists, _artists) &&
            (identical(other.album, album) || other.album == album));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, track, const DeepCollectionEquality().hash(_artists), album);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DeezerCopyWith<_$_Deezer> get copyWith =>
      __$$_DeezerCopyWithImpl<_$_Deezer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DeezerToJson(
      this,
    );
  }
}

abstract class _Deezer implements Deezer {
  const factory _Deezer(
      {final TrackClass? track,
      final List<TrackClass>? artists,
      final TrackClass? album}) = _$_Deezer;

  factory _Deezer.fromJson(Map<String, dynamic> json) = _$_Deezer.fromJson;

  @override
  TrackClass? get track;
  @override
  List<TrackClass>? get artists;
  @override
  TrackClass? get album;
  @override
  @JsonKey(ignore: true)
  _$$_DeezerCopyWith<_$_Deezer> get copyWith =>
      throw _privateConstructorUsedError;
}

TrackClass _$TrackClassFromJson(Map<String, dynamic> json) {
  return _TrackClass.fromJson(json);
}

/// @nodoc
mixin _$TrackClass {
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrackClassCopyWith<TrackClass> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackClassCopyWith<$Res> {
  factory $TrackClassCopyWith(
          TrackClass value, $Res Function(TrackClass) then) =
      _$TrackClassCopyWithImpl<$Res, TrackClass>;
  @useResult
  $Res call({String? id});
}

/// @nodoc
class _$TrackClassCopyWithImpl<$Res, $Val extends TrackClass>
    implements $TrackClassCopyWith<$Res> {
  _$TrackClassCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TrackClassCopyWith<$Res>
    implements $TrackClassCopyWith<$Res> {
  factory _$$_TrackClassCopyWith(
          _$_TrackClass value, $Res Function(_$_TrackClass) then) =
      __$$_TrackClassCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id});
}

/// @nodoc
class __$$_TrackClassCopyWithImpl<$Res>
    extends _$TrackClassCopyWithImpl<$Res, _$_TrackClass>
    implements _$$_TrackClassCopyWith<$Res> {
  __$$_TrackClassCopyWithImpl(
      _$_TrackClass _value, $Res Function(_$_TrackClass) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_$_TrackClass(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TrackClass implements _TrackClass {
  const _$_TrackClass({this.id});

  factory _$_TrackClass.fromJson(Map<String, dynamic> json) =>
      _$$_TrackClassFromJson(json);

  @override
  final String? id;

  @override
  String toString() {
    return 'TrackClass(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrackClass &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrackClassCopyWith<_$_TrackClass> get copyWith =>
      __$$_TrackClassCopyWithImpl<_$_TrackClass>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TrackClassToJson(
      this,
    );
  }
}

abstract class _TrackClass implements TrackClass {
  const factory _TrackClass({final String? id}) = _$_TrackClass;

  factory _TrackClass.fromJson(Map<String, dynamic> json) =
      _$_TrackClass.fromJson;

  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_TrackClassCopyWith<_$_TrackClass> get copyWith =>
      throw _privateConstructorUsedError;
}

Musicbrainz _$MusicbrainzFromJson(Map<String, dynamic> json) {
  return _Musicbrainz.fromJson(json);
}

/// @nodoc
mixin _$Musicbrainz {
  TrackClass? get track => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MusicbrainzCopyWith<Musicbrainz> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicbrainzCopyWith<$Res> {
  factory $MusicbrainzCopyWith(
          Musicbrainz value, $Res Function(Musicbrainz) then) =
      _$MusicbrainzCopyWithImpl<$Res, Musicbrainz>;
  @useResult
  $Res call({TrackClass? track});

  $TrackClassCopyWith<$Res>? get track;
}

/// @nodoc
class _$MusicbrainzCopyWithImpl<$Res, $Val extends Musicbrainz>
    implements $MusicbrainzCopyWith<$Res> {
  _$MusicbrainzCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? track = freezed,
  }) {
    return _then(_value.copyWith(
      track: freezed == track
          ? _value.track
          : track // ignore: cast_nullable_to_non_nullable
              as TrackClass?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TrackClassCopyWith<$Res>? get track {
    if (_value.track == null) {
      return null;
    }

    return $TrackClassCopyWith<$Res>(_value.track!, (value) {
      return _then(_value.copyWith(track: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MusicbrainzCopyWith<$Res>
    implements $MusicbrainzCopyWith<$Res> {
  factory _$$_MusicbrainzCopyWith(
          _$_Musicbrainz value, $Res Function(_$_Musicbrainz) then) =
      __$$_MusicbrainzCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TrackClass? track});

  @override
  $TrackClassCopyWith<$Res>? get track;
}

/// @nodoc
class __$$_MusicbrainzCopyWithImpl<$Res>
    extends _$MusicbrainzCopyWithImpl<$Res, _$_Musicbrainz>
    implements _$$_MusicbrainzCopyWith<$Res> {
  __$$_MusicbrainzCopyWithImpl(
      _$_Musicbrainz _value, $Res Function(_$_Musicbrainz) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? track = freezed,
  }) {
    return _then(_$_Musicbrainz(
      track: freezed == track
          ? _value.track
          : track // ignore: cast_nullable_to_non_nullable
              as TrackClass?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Musicbrainz implements _Musicbrainz {
  const _$_Musicbrainz({this.track});

  factory _$_Musicbrainz.fromJson(Map<String, dynamic> json) =>
      _$$_MusicbrainzFromJson(json);

  @override
  final TrackClass? track;

  @override
  String toString() {
    return 'Musicbrainz(track: $track)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Musicbrainz &&
            (identical(other.track, track) || other.track == track));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, track);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MusicbrainzCopyWith<_$_Musicbrainz> get copyWith =>
      __$$_MusicbrainzCopyWithImpl<_$_Musicbrainz>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MusicbrainzToJson(
      this,
    );
  }
}

abstract class _Musicbrainz implements Musicbrainz {
  const factory _Musicbrainz({final TrackClass? track}) = _$_Musicbrainz;

  factory _Musicbrainz.fromJson(Map<String, dynamic> json) =
      _$_Musicbrainz.fromJson;

  @override
  TrackClass? get track;
  @override
  @JsonKey(ignore: true)
  _$$_MusicbrainzCopyWith<_$_Musicbrainz> get copyWith =>
      throw _privateConstructorUsedError;
}

Musicstory _$MusicstoryFromJson(Map<String, dynamic> json) {
  return _Musicstory.fromJson(json);
}

/// @nodoc
mixin _$Musicstory {
  TrackClass? get track => throw _privateConstructorUsedError;
  TrackClass? get album => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MusicstoryCopyWith<Musicstory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicstoryCopyWith<$Res> {
  factory $MusicstoryCopyWith(
          Musicstory value, $Res Function(Musicstory) then) =
      _$MusicstoryCopyWithImpl<$Res, Musicstory>;
  @useResult
  $Res call({TrackClass? track, TrackClass? album});

  $TrackClassCopyWith<$Res>? get track;
  $TrackClassCopyWith<$Res>? get album;
}

/// @nodoc
class _$MusicstoryCopyWithImpl<$Res, $Val extends Musicstory>
    implements $MusicstoryCopyWith<$Res> {
  _$MusicstoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? track = freezed,
    Object? album = freezed,
  }) {
    return _then(_value.copyWith(
      track: freezed == track
          ? _value.track
          : track // ignore: cast_nullable_to_non_nullable
              as TrackClass?,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as TrackClass?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TrackClassCopyWith<$Res>? get track {
    if (_value.track == null) {
      return null;
    }

    return $TrackClassCopyWith<$Res>(_value.track!, (value) {
      return _then(_value.copyWith(track: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TrackClassCopyWith<$Res>? get album {
    if (_value.album == null) {
      return null;
    }

    return $TrackClassCopyWith<$Res>(_value.album!, (value) {
      return _then(_value.copyWith(album: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_MusicstoryCopyWith<$Res>
    implements $MusicstoryCopyWith<$Res> {
  factory _$$_MusicstoryCopyWith(
          _$_Musicstory value, $Res Function(_$_Musicstory) then) =
      __$$_MusicstoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({TrackClass? track, TrackClass? album});

  @override
  $TrackClassCopyWith<$Res>? get track;
  @override
  $TrackClassCopyWith<$Res>? get album;
}

/// @nodoc
class __$$_MusicstoryCopyWithImpl<$Res>
    extends _$MusicstoryCopyWithImpl<$Res, _$_Musicstory>
    implements _$$_MusicstoryCopyWith<$Res> {
  __$$_MusicstoryCopyWithImpl(
      _$_Musicstory _value, $Res Function(_$_Musicstory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? track = freezed,
    Object? album = freezed,
  }) {
    return _then(_$_Musicstory(
      track: freezed == track
          ? _value.track
          : track // ignore: cast_nullable_to_non_nullable
              as TrackClass?,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as TrackClass?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Musicstory implements _Musicstory {
  const _$_Musicstory({this.track, this.album});

  factory _$_Musicstory.fromJson(Map<String, dynamic> json) =>
      _$$_MusicstoryFromJson(json);

  @override
  final TrackClass? track;
  @override
  final TrackClass? album;

  @override
  String toString() {
    return 'Musicstory(track: $track, album: $album)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Musicstory &&
            (identical(other.track, track) || other.track == track) &&
            (identical(other.album, album) || other.album == album));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, track, album);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MusicstoryCopyWith<_$_Musicstory> get copyWith =>
      __$$_MusicstoryCopyWithImpl<_$_Musicstory>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MusicstoryToJson(
      this,
    );
  }
}

abstract class _Musicstory implements Musicstory {
  const factory _Musicstory(
      {final TrackClass? track, final TrackClass? album}) = _$_Musicstory;

  factory _Musicstory.fromJson(Map<String, dynamic> json) =
      _$_Musicstory.fromJson;

  @override
  TrackClass? get track;
  @override
  TrackClass? get album;
  @override
  @JsonKey(ignore: true)
  _$$_MusicstoryCopyWith<_$_Musicstory> get copyWith =>
      throw _privateConstructorUsedError;
}

Youtube _$YoutubeFromJson(Map<String, dynamic> json) {
  return _Youtube.fromJson(json);
}

/// @nodoc
mixin _$Youtube {
  String? get vid => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $YoutubeCopyWith<Youtube> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YoutubeCopyWith<$Res> {
  factory $YoutubeCopyWith(Youtube value, $Res Function(Youtube) then) =
      _$YoutubeCopyWithImpl<$Res, Youtube>;
  @useResult
  $Res call({String? vid});
}

/// @nodoc
class _$YoutubeCopyWithImpl<$Res, $Val extends Youtube>
    implements $YoutubeCopyWith<$Res> {
  _$YoutubeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vid = freezed,
  }) {
    return _then(_value.copyWith(
      vid: freezed == vid
          ? _value.vid
          : vid // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_YoutubeCopyWith<$Res> implements $YoutubeCopyWith<$Res> {
  factory _$$_YoutubeCopyWith(
          _$_Youtube value, $Res Function(_$_Youtube) then) =
      __$$_YoutubeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? vid});
}

/// @nodoc
class __$$_YoutubeCopyWithImpl<$Res>
    extends _$YoutubeCopyWithImpl<$Res, _$_Youtube>
    implements _$$_YoutubeCopyWith<$Res> {
  __$$_YoutubeCopyWithImpl(_$_Youtube _value, $Res Function(_$_Youtube) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? vid = freezed,
  }) {
    return _then(_$_Youtube(
      vid: freezed == vid
          ? _value.vid
          : vid // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Youtube implements _Youtube {
  const _$_Youtube({this.vid});

  factory _$_Youtube.fromJson(Map<String, dynamic> json) =>
      _$$_YoutubeFromJson(json);

  @override
  final String? vid;

  @override
  String toString() {
    return 'Youtube(vid: $vid)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Youtube &&
            (identical(other.vid, vid) || other.vid == vid));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, vid);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_YoutubeCopyWith<_$_Youtube> get copyWith =>
      __$$_YoutubeCopyWithImpl<_$_Youtube>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_YoutubeToJson(
      this,
    );
  }
}

abstract class _Youtube implements Youtube {
  const factory _Youtube({final String? vid}) = _$_Youtube;

  factory _Youtube.fromJson(Map<String, dynamic> json) = _$_Youtube.fromJson;

  @override
  String? get vid;
  @override
  @JsonKey(ignore: true)
  _$$_YoutubeCopyWith<_$_Youtube> get copyWith =>
      throw _privateConstructorUsedError;
}

Genre _$GenreFromJson(Map<String, dynamic> json) {
  return _Genre.fromJson(json);
}

/// @nodoc
mixin _$Genre {
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GenreCopyWith<Genre> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GenreCopyWith<$Res> {
  factory $GenreCopyWith(Genre value, $Res Function(Genre) then) =
      _$GenreCopyWithImpl<$Res, Genre>;
  @useResult
  $Res call({String? name});
}

/// @nodoc
class _$GenreCopyWithImpl<$Res, $Val extends Genre>
    implements $GenreCopyWith<$Res> {
  _$GenreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GenreCopyWith<$Res> implements $GenreCopyWith<$Res> {
  factory _$$_GenreCopyWith(_$_Genre value, $Res Function(_$_Genre) then) =
      __$$_GenreCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name});
}

/// @nodoc
class __$$_GenreCopyWithImpl<$Res> extends _$GenreCopyWithImpl<$Res, _$_Genre>
    implements _$$_GenreCopyWith<$Res> {
  __$$_GenreCopyWithImpl(_$_Genre _value, $Res Function(_$_Genre) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
  }) {
    return _then(_$_Genre(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Genre implements _Genre {
  const _$_Genre({this.name});

  factory _$_Genre.fromJson(Map<String, dynamic> json) =>
      _$$_GenreFromJson(json);

  @override
  final String? name;

  @override
  String toString() {
    return 'Genre(name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Genre &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GenreCopyWith<_$_Genre> get copyWith =>
      __$$_GenreCopyWithImpl<_$_Genre>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GenreToJson(
      this,
    );
  }
}

abstract class _Genre implements Genre {
  const factory _Genre({final String? name}) = _$_Genre;

  factory _Genre.fromJson(Map<String, dynamic> json) = _$_Genre.fromJson;

  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_GenreCopyWith<_$_Genre> get copyWith =>
      throw _privateConstructorUsedError;
}

Lyrics _$LyricsFromJson(Map<String, dynamic> json) {
  return _Lyrics.fromJson(json);
}

/// @nodoc
mixin _$Lyrics {
  List<String>? get copyrights => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LyricsCopyWith<Lyrics> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LyricsCopyWith<$Res> {
  factory $LyricsCopyWith(Lyrics value, $Res Function(Lyrics) then) =
      _$LyricsCopyWithImpl<$Res, Lyrics>;
  @useResult
  $Res call({List<String>? copyrights});
}

/// @nodoc
class _$LyricsCopyWithImpl<$Res, $Val extends Lyrics>
    implements $LyricsCopyWith<$Res> {
  _$LyricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? copyrights = freezed,
  }) {
    return _then(_value.copyWith(
      copyrights: freezed == copyrights
          ? _value.copyrights
          : copyrights // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LyricsCopyWith<$Res> implements $LyricsCopyWith<$Res> {
  factory _$$_LyricsCopyWith(_$_Lyrics value, $Res Function(_$_Lyrics) then) =
      __$$_LyricsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? copyrights});
}

/// @nodoc
class __$$_LyricsCopyWithImpl<$Res>
    extends _$LyricsCopyWithImpl<$Res, _$_Lyrics>
    implements _$$_LyricsCopyWith<$Res> {
  __$$_LyricsCopyWithImpl(_$_Lyrics _value, $Res Function(_$_Lyrics) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? copyrights = freezed,
  }) {
    return _then(_$_Lyrics(
      copyrights: freezed == copyrights
          ? _value._copyrights
          : copyrights // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Lyrics implements _Lyrics {
  const _$_Lyrics({final List<String>? copyrights}) : _copyrights = copyrights;

  factory _$_Lyrics.fromJson(Map<String, dynamic> json) =>
      _$$_LyricsFromJson(json);

  final List<String>? _copyrights;
  @override
  List<String>? get copyrights {
    final value = _copyrights;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Lyrics(copyrights: $copyrights)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Lyrics &&
            const DeepCollectionEquality()
                .equals(other._copyrights, _copyrights));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_copyrights));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LyricsCopyWith<_$_Lyrics> get copyWith =>
      __$$_LyricsCopyWithImpl<_$_Lyrics>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LyricsToJson(
      this,
    );
  }
}

abstract class _Lyrics implements Lyrics {
  const factory _Lyrics({final List<String>? copyrights}) = _$_Lyrics;

  factory _Lyrics.fromJson(Map<String, dynamic> json) = _$_Lyrics.fromJson;

  @override
  List<String>? get copyrights;
  @override
  @JsonKey(ignore: true)
  _$$_LyricsCopyWith<_$_Lyrics> get copyWith =>
      throw _privateConstructorUsedError;
}

ReleaseByTerritory _$ReleaseByTerritoryFromJson(Map<String, dynamic> json) {
  return _ReleaseByTerritory.fromJson(json);
}

/// @nodoc
mixin _$ReleaseByTerritory {
  List<String>? get territories => throw _privateConstructorUsedError;
  DateTime? get releaseDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReleaseByTerritoryCopyWith<ReleaseByTerritory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReleaseByTerritoryCopyWith<$Res> {
  factory $ReleaseByTerritoryCopyWith(
          ReleaseByTerritory value, $Res Function(ReleaseByTerritory) then) =
      _$ReleaseByTerritoryCopyWithImpl<$Res, ReleaseByTerritory>;
  @useResult
  $Res call({List<String>? territories, DateTime? releaseDate});
}

/// @nodoc
class _$ReleaseByTerritoryCopyWithImpl<$Res, $Val extends ReleaseByTerritory>
    implements $ReleaseByTerritoryCopyWith<$Res> {
  _$ReleaseByTerritoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? territories = freezed,
    Object? releaseDate = freezed,
  }) {
    return _then(_value.copyWith(
      territories: freezed == territories
          ? _value.territories
          : territories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ReleaseByTerritoryCopyWith<$Res>
    implements $ReleaseByTerritoryCopyWith<$Res> {
  factory _$$_ReleaseByTerritoryCopyWith(_$_ReleaseByTerritory value,
          $Res Function(_$_ReleaseByTerritory) then) =
      __$$_ReleaseByTerritoryCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? territories, DateTime? releaseDate});
}

/// @nodoc
class __$$_ReleaseByTerritoryCopyWithImpl<$Res>
    extends _$ReleaseByTerritoryCopyWithImpl<$Res, _$_ReleaseByTerritory>
    implements _$$_ReleaseByTerritoryCopyWith<$Res> {
  __$$_ReleaseByTerritoryCopyWithImpl(
      _$_ReleaseByTerritory _value, $Res Function(_$_ReleaseByTerritory) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? territories = freezed,
    Object? releaseDate = freezed,
  }) {
    return _then(_$_ReleaseByTerritory(
      territories: freezed == territories
          ? _value._territories
          : territories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      releaseDate: freezed == releaseDate
          ? _value.releaseDate
          : releaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ReleaseByTerritory implements _ReleaseByTerritory {
  const _$_ReleaseByTerritory(
      {final List<String>? territories, this.releaseDate})
      : _territories = territories;

  factory _$_ReleaseByTerritory.fromJson(Map<String, dynamic> json) =>
      _$$_ReleaseByTerritoryFromJson(json);

  final List<String>? _territories;
  @override
  List<String>? get territories {
    final value = _territories;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? releaseDate;

  @override
  String toString() {
    return 'ReleaseByTerritory(territories: $territories, releaseDate: $releaseDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ReleaseByTerritory &&
            const DeepCollectionEquality()
                .equals(other._territories, _territories) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_territories), releaseDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ReleaseByTerritoryCopyWith<_$_ReleaseByTerritory> get copyWith =>
      __$$_ReleaseByTerritoryCopyWithImpl<_$_ReleaseByTerritory>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReleaseByTerritoryToJson(
      this,
    );
  }
}

abstract class _ReleaseByTerritory implements ReleaseByTerritory {
  const factory _ReleaseByTerritory(
      {final List<String>? territories,
      final DateTime? releaseDate}) = _$_ReleaseByTerritory;

  factory _ReleaseByTerritory.fromJson(Map<String, dynamic> json) =
      _$_ReleaseByTerritory.fromJson;

  @override
  List<String>? get territories;
  @override
  DateTime? get releaseDate;
  @override
  @JsonKey(ignore: true)
  _$$_ReleaseByTerritoryCopyWith<_$_ReleaseByTerritory> get copyWith =>
      throw _privateConstructorUsedError;
}

RightsClaim _$RightsClaimFromJson(Map<String, dynamic> json) {
  return _RightsClaim.fromJson(json);
}

/// @nodoc
mixin _$RightsClaim {
  Distributor? get distributor => throw _privateConstructorUsedError;
  List<RightsOwner>? get rightsOwners => throw _privateConstructorUsedError;
  String? get rightsClaimPolicy => throw _privateConstructorUsedError;
  List<String>? get territories => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RightsClaimCopyWith<RightsClaim> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RightsClaimCopyWith<$Res> {
  factory $RightsClaimCopyWith(
          RightsClaim value, $Res Function(RightsClaim) then) =
      _$RightsClaimCopyWithImpl<$Res, RightsClaim>;
  @useResult
  $Res call(
      {Distributor? distributor,
      List<RightsOwner>? rightsOwners,
      String? rightsClaimPolicy,
      List<String>? territories});

  $DistributorCopyWith<$Res>? get distributor;
}

/// @nodoc
class _$RightsClaimCopyWithImpl<$Res, $Val extends RightsClaim>
    implements $RightsClaimCopyWith<$Res> {
  _$RightsClaimCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distributor = freezed,
    Object? rightsOwners = freezed,
    Object? rightsClaimPolicy = freezed,
    Object? territories = freezed,
  }) {
    return _then(_value.copyWith(
      distributor: freezed == distributor
          ? _value.distributor
          : distributor // ignore: cast_nullable_to_non_nullable
              as Distributor?,
      rightsOwners: freezed == rightsOwners
          ? _value.rightsOwners
          : rightsOwners // ignore: cast_nullable_to_non_nullable
              as List<RightsOwner>?,
      rightsClaimPolicy: freezed == rightsClaimPolicy
          ? _value.rightsClaimPolicy
          : rightsClaimPolicy // ignore: cast_nullable_to_non_nullable
              as String?,
      territories: freezed == territories
          ? _value.territories
          : territories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DistributorCopyWith<$Res>? get distributor {
    if (_value.distributor == null) {
      return null;
    }

    return $DistributorCopyWith<$Res>(_value.distributor!, (value) {
      return _then(_value.copyWith(distributor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RightsClaimCopyWith<$Res>
    implements $RightsClaimCopyWith<$Res> {
  factory _$$_RightsClaimCopyWith(
          _$_RightsClaim value, $Res Function(_$_RightsClaim) then) =
      __$$_RightsClaimCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Distributor? distributor,
      List<RightsOwner>? rightsOwners,
      String? rightsClaimPolicy,
      List<String>? territories});

  @override
  $DistributorCopyWith<$Res>? get distributor;
}

/// @nodoc
class __$$_RightsClaimCopyWithImpl<$Res>
    extends _$RightsClaimCopyWithImpl<$Res, _$_RightsClaim>
    implements _$$_RightsClaimCopyWith<$Res> {
  __$$_RightsClaimCopyWithImpl(
      _$_RightsClaim _value, $Res Function(_$_RightsClaim) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? distributor = freezed,
    Object? rightsOwners = freezed,
    Object? rightsClaimPolicy = freezed,
    Object? territories = freezed,
  }) {
    return _then(_$_RightsClaim(
      distributor: freezed == distributor
          ? _value.distributor
          : distributor // ignore: cast_nullable_to_non_nullable
              as Distributor?,
      rightsOwners: freezed == rightsOwners
          ? _value._rightsOwners
          : rightsOwners // ignore: cast_nullable_to_non_nullable
              as List<RightsOwner>?,
      rightsClaimPolicy: freezed == rightsClaimPolicy
          ? _value.rightsClaimPolicy
          : rightsClaimPolicy // ignore: cast_nullable_to_non_nullable
              as String?,
      territories: freezed == territories
          ? _value._territories
          : territories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RightsClaim implements _RightsClaim {
  const _$_RightsClaim(
      {this.distributor,
      final List<RightsOwner>? rightsOwners,
      this.rightsClaimPolicy,
      final List<String>? territories})
      : _rightsOwners = rightsOwners,
        _territories = territories;

  factory _$_RightsClaim.fromJson(Map<String, dynamic> json) =>
      _$$_RightsClaimFromJson(json);

  @override
  final Distributor? distributor;
  final List<RightsOwner>? _rightsOwners;
  @override
  List<RightsOwner>? get rightsOwners {
    final value = _rightsOwners;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? rightsClaimPolicy;
  final List<String>? _territories;
  @override
  List<String>? get territories {
    final value = _territories;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RightsClaim(distributor: $distributor, rightsOwners: $rightsOwners, rightsClaimPolicy: $rightsClaimPolicy, territories: $territories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RightsClaim &&
            (identical(other.distributor, distributor) ||
                other.distributor == distributor) &&
            const DeepCollectionEquality()
                .equals(other._rightsOwners, _rightsOwners) &&
            (identical(other.rightsClaimPolicy, rightsClaimPolicy) ||
                other.rightsClaimPolicy == rightsClaimPolicy) &&
            const DeepCollectionEquality()
                .equals(other._territories, _territories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      distributor,
      const DeepCollectionEquality().hash(_rightsOwners),
      rightsClaimPolicy,
      const DeepCollectionEquality().hash(_territories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RightsClaimCopyWith<_$_RightsClaim> get copyWith =>
      __$$_RightsClaimCopyWithImpl<_$_RightsClaim>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RightsClaimToJson(
      this,
    );
  }
}

abstract class _RightsClaim implements RightsClaim {
  const factory _RightsClaim(
      {final Distributor? distributor,
      final List<RightsOwner>? rightsOwners,
      final String? rightsClaimPolicy,
      final List<String>? territories}) = _$_RightsClaim;

  factory _RightsClaim.fromJson(Map<String, dynamic> json) =
      _$_RightsClaim.fromJson;

  @override
  Distributor? get distributor;
  @override
  List<RightsOwner>? get rightsOwners;
  @override
  String? get rightsClaimPolicy;
  @override
  List<String>? get territories;
  @override
  @JsonKey(ignore: true)
  _$$_RightsClaimCopyWith<_$_RightsClaim> get copyWith =>
      throw _privateConstructorUsedError;
}

Distributor _$DistributorFromJson(Map<String, dynamic> json) {
  return _Distributor.fromJson(json);
}

/// @nodoc
mixin _$Distributor {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DistributorCopyWith<Distributor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DistributorCopyWith<$Res> {
  factory $DistributorCopyWith(
          Distributor value, $Res Function(Distributor) then) =
      _$DistributorCopyWithImpl<$Res, Distributor>;
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class _$DistributorCopyWithImpl<$Res, $Val extends Distributor>
    implements $DistributorCopyWith<$Res> {
  _$DistributorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DistributorCopyWith<$Res>
    implements $DistributorCopyWith<$Res> {
  factory _$$_DistributorCopyWith(
          _$_Distributor value, $Res Function(_$_Distributor) then) =
      __$$_DistributorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name});
}

/// @nodoc
class __$$_DistributorCopyWithImpl<$Res>
    extends _$DistributorCopyWithImpl<$Res, _$_Distributor>
    implements _$$_DistributorCopyWith<$Res> {
  __$$_DistributorCopyWithImpl(
      _$_Distributor _value, $Res Function(_$_Distributor) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_Distributor(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Distributor implements _Distributor {
  const _$_Distributor({this.id, this.name});

  factory _$_Distributor.fromJson(Map<String, dynamic> json) =>
      _$$_DistributorFromJson(json);

  @override
  final String? id;
  @override
  final String? name;

  @override
  String toString() {
    return 'Distributor(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Distributor &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DistributorCopyWith<_$_Distributor> get copyWith =>
      __$$_DistributorCopyWithImpl<_$_Distributor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DistributorToJson(
      this,
    );
  }
}

abstract class _Distributor implements Distributor {
  const factory _Distributor({final String? id, final String? name}) =
      _$_Distributor;

  factory _Distributor.fromJson(Map<String, dynamic> json) =
      _$_Distributor.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_DistributorCopyWith<_$_Distributor> get copyWith =>
      throw _privateConstructorUsedError;
}

RightsOwner _$RightsOwnerFromJson(Map<String, dynamic> json) {
  return _RightsOwner.fromJson(json);
}

/// @nodoc
mixin _$RightsOwner {
  String? get name => throw _privateConstructorUsedError;
  int? get sharePercentage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RightsOwnerCopyWith<RightsOwner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RightsOwnerCopyWith<$Res> {
  factory $RightsOwnerCopyWith(
          RightsOwner value, $Res Function(RightsOwner) then) =
      _$RightsOwnerCopyWithImpl<$Res, RightsOwner>;
  @useResult
  $Res call({String? name, int? sharePercentage});
}

/// @nodoc
class _$RightsOwnerCopyWithImpl<$Res, $Val extends RightsOwner>
    implements $RightsOwnerCopyWith<$Res> {
  _$RightsOwnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? sharePercentage = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      sharePercentage: freezed == sharePercentage
          ? _value.sharePercentage
          : sharePercentage // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RightsOwnerCopyWith<$Res>
    implements $RightsOwnerCopyWith<$Res> {
  factory _$$_RightsOwnerCopyWith(
          _$_RightsOwner value, $Res Function(_$_RightsOwner) then) =
      __$$_RightsOwnerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, int? sharePercentage});
}

/// @nodoc
class __$$_RightsOwnerCopyWithImpl<$Res>
    extends _$RightsOwnerCopyWithImpl<$Res, _$_RightsOwner>
    implements _$$_RightsOwnerCopyWith<$Res> {
  __$$_RightsOwnerCopyWithImpl(
      _$_RightsOwner _value, $Res Function(_$_RightsOwner) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? sharePercentage = freezed,
  }) {
    return _then(_$_RightsOwner(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      sharePercentage: freezed == sharePercentage
          ? _value.sharePercentage
          : sharePercentage // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RightsOwner implements _RightsOwner {
  const _$_RightsOwner({this.name, this.sharePercentage});

  factory _$_RightsOwner.fromJson(Map<String, dynamic> json) =>
      _$$_RightsOwnerFromJson(json);

  @override
  final String? name;
  @override
  final int? sharePercentage;

  @override
  String toString() {
    return 'RightsOwner(name: $name, sharePercentage: $sharePercentage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RightsOwner &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sharePercentage, sharePercentage) ||
                other.sharePercentage == sharePercentage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, sharePercentage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RightsOwnerCopyWith<_$_RightsOwner> get copyWith =>
      __$$_RightsOwnerCopyWithImpl<_$_RightsOwner>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RightsOwnerToJson(
      this,
    );
  }
}

abstract class _RightsOwner implements RightsOwner {
  const factory _RightsOwner({final String? name, final int? sharePercentage}) =
      _$_RightsOwner;

  factory _RightsOwner.fromJson(Map<String, dynamic> json) =
      _$_RightsOwner.fromJson;

  @override
  String? get name;
  @override
  int? get sharePercentage;
  @override
  @JsonKey(ignore: true)
  _$$_RightsOwnerCopyWith<_$_RightsOwner> get copyWith =>
      throw _privateConstructorUsedError;
}

Status _$StatusFromJson(Map<String, dynamic> json) {
  return _Status.fromJson(json);
}

/// @nodoc
mixin _$Status {
  String? get msg => throw _privateConstructorUsedError;
  String? get version => throw _privateConstructorUsedError;
  int? get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatusCopyWith<Status> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusCopyWith<$Res> {
  factory $StatusCopyWith(Status value, $Res Function(Status) then) =
      _$StatusCopyWithImpl<$Res, Status>;
  @useResult
  $Res call({String? msg, String? version, int? code});
}

/// @nodoc
class _$StatusCopyWithImpl<$Res, $Val extends Status>
    implements $StatusCopyWith<$Res> {
  _$StatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = freezed,
    Object? version = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      msg: freezed == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StatusCopyWith<$Res> implements $StatusCopyWith<$Res> {
  factory _$$_StatusCopyWith(_$_Status value, $Res Function(_$_Status) then) =
      __$$_StatusCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? msg, String? version, int? code});
}

/// @nodoc
class __$$_StatusCopyWithImpl<$Res>
    extends _$StatusCopyWithImpl<$Res, _$_Status>
    implements _$$_StatusCopyWith<$Res> {
  __$$_StatusCopyWithImpl(_$_Status _value, $Res Function(_$_Status) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? msg = freezed,
    Object? version = freezed,
    Object? code = freezed,
  }) {
    return _then(_$_Status(
      msg: freezed == msg
          ? _value.msg
          : msg // ignore: cast_nullable_to_non_nullable
              as String?,
      version: freezed == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Status implements _Status {
  const _$_Status({this.msg, this.version, this.code});

  factory _$_Status.fromJson(Map<String, dynamic> json) =>
      _$$_StatusFromJson(json);

  @override
  final String? msg;
  @override
  final String? version;
  @override
  final int? code;

  @override
  String toString() {
    return 'Status(msg: $msg, version: $version, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Status &&
            (identical(other.msg, msg) || other.msg == msg) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, msg, version, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StatusCopyWith<_$_Status> get copyWith =>
      __$$_StatusCopyWithImpl<_$_Status>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StatusToJson(
      this,
    );
  }
}

abstract class _Status implements Status {
  const factory _Status(
      {final String? msg, final String? version, final int? code}) = _$_Status;

  factory _Status.fromJson(Map<String, dynamic> json) = _$_Status.fromJson;

  @override
  String? get msg;
  @override
  String? get version;
  @override
  int? get code;
  @override
  @JsonKey(ignore: true)
  _$$_StatusCopyWith<_$_Status> get copyWith =>
      throw _privateConstructorUsedError;
}
