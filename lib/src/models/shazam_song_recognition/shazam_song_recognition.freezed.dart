// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'shazam_song_recognition.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShazamSongRecognition _$ShazamSongRecognitionFromJson(
    Map<String, dynamic> json) {
  return _ShazamSongRecognition.fromJson(json);
}

/// @nodoc
mixin _$ShazamSongRecognition {
  bool? get ok => throw _privateConstructorUsedError;
  ShazamResult? get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShazamSongRecognitionCopyWith<ShazamSongRecognition> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShazamSongRecognitionCopyWith<$Res> {
  factory $ShazamSongRecognitionCopyWith(ShazamSongRecognition value,
          $Res Function(ShazamSongRecognition) then) =
      _$ShazamSongRecognitionCopyWithImpl<$Res, ShazamSongRecognition>;
  @useResult
  $Res call({bool? ok, ShazamResult? result});

  $ShazamResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$ShazamSongRecognitionCopyWithImpl<$Res,
        $Val extends ShazamSongRecognition>
    implements $ShazamSongRecognitionCopyWith<$Res> {
  _$ShazamSongRecognitionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ok = freezed,
    Object? result = freezed,
  }) {
    return _then(_value.copyWith(
      ok: freezed == ok
          ? _value.ok
          : ok // ignore: cast_nullable_to_non_nullable
              as bool?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as ShazamResult?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ShazamResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $ShazamResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ShazamSongRecognitionCopyWith<$Res>
    implements $ShazamSongRecognitionCopyWith<$Res> {
  factory _$$_ShazamSongRecognitionCopyWith(_$_ShazamSongRecognition value,
          $Res Function(_$_ShazamSongRecognition) then) =
      __$$_ShazamSongRecognitionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? ok, ShazamResult? result});

  @override
  $ShazamResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$_ShazamSongRecognitionCopyWithImpl<$Res>
    extends _$ShazamSongRecognitionCopyWithImpl<$Res, _$_ShazamSongRecognition>
    implements _$$_ShazamSongRecognitionCopyWith<$Res> {
  __$$_ShazamSongRecognitionCopyWithImpl(_$_ShazamSongRecognition _value,
      $Res Function(_$_ShazamSongRecognition) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ok = freezed,
    Object? result = freezed,
  }) {
    return _then(_$_ShazamSongRecognition(
      ok: freezed == ok
          ? _value.ok
          : ok // ignore: cast_nullable_to_non_nullable
              as bool?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as ShazamResult?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShazamSongRecognition implements _ShazamSongRecognition {
  _$_ShazamSongRecognition({this.ok, this.result});

  factory _$_ShazamSongRecognition.fromJson(Map<String, dynamic> json) =>
      _$$_ShazamSongRecognitionFromJson(json);

  @override
  final bool? ok;
  @override
  final ShazamResult? result;

  @override
  String toString() {
    return 'ShazamSongRecognition(ok: $ok, result: $result)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShazamSongRecognition &&
            (identical(other.ok, ok) || other.ok == ok) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ok, result);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShazamSongRecognitionCopyWith<_$_ShazamSongRecognition> get copyWith =>
      __$$_ShazamSongRecognitionCopyWithImpl<_$_ShazamSongRecognition>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShazamSongRecognitionToJson(
      this,
    );
  }
}

abstract class _ShazamSongRecognition implements ShazamSongRecognition {
  factory _ShazamSongRecognition({final bool? ok, final ShazamResult? result}) =
      _$_ShazamSongRecognition;

  factory _ShazamSongRecognition.fromJson(Map<String, dynamic> json) =
      _$_ShazamSongRecognition.fromJson;

  @override
  bool? get ok;
  @override
  ShazamResult? get result;
  @override
  @JsonKey(ignore: true)
  _$$_ShazamSongRecognitionCopyWith<_$_ShazamSongRecognition> get copyWith =>
      throw _privateConstructorUsedError;
}
