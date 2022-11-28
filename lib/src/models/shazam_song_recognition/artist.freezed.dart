// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'artist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShazamArtist _$ShazamArtistFromJson(Map<String, dynamic> json) {
  return _ShazamArtist.fromJson(json);
}

/// @nodoc
mixin _$ShazamArtist {
  String? get adamid => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShazamArtistCopyWith<ShazamArtist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShazamArtistCopyWith<$Res> {
  factory $ShazamArtistCopyWith(
          ShazamArtist value, $Res Function(ShazamArtist) then) =
      _$ShazamArtistCopyWithImpl<$Res, ShazamArtist>;
  @useResult
  $Res call({String? adamid, String? id});
}

/// @nodoc
class _$ShazamArtistCopyWithImpl<$Res, $Val extends ShazamArtist>
    implements $ShazamArtistCopyWith<$Res> {
  _$ShazamArtistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adamid = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      adamid: freezed == adamid
          ? _value.adamid
          : adamid // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShazamArtistCopyWith<$Res>
    implements $ShazamArtistCopyWith<$Res> {
  factory _$$_ShazamArtistCopyWith(
          _$_ShazamArtist value, $Res Function(_$_ShazamArtist) then) =
      __$$_ShazamArtistCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? adamid, String? id});
}

/// @nodoc
class __$$_ShazamArtistCopyWithImpl<$Res>
    extends _$ShazamArtistCopyWithImpl<$Res, _$_ShazamArtist>
    implements _$$_ShazamArtistCopyWith<$Res> {
  __$$_ShazamArtistCopyWithImpl(
      _$_ShazamArtist _value, $Res Function(_$_ShazamArtist) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adamid = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_ShazamArtist(
      adamid: freezed == adamid
          ? _value.adamid
          : adamid // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShazamArtist implements _ShazamArtist {
  _$_ShazamArtist({this.adamid, this.id});

  factory _$_ShazamArtist.fromJson(Map<String, dynamic> json) =>
      _$$_ShazamArtistFromJson(json);

  @override
  final String? adamid;
  @override
  final String? id;

  @override
  String toString() {
    return 'ShazamArtist(adamid: $adamid, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShazamArtist &&
            (identical(other.adamid, adamid) || other.adamid == adamid) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, adamid, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShazamArtistCopyWith<_$_ShazamArtist> get copyWith =>
      __$$_ShazamArtistCopyWithImpl<_$_ShazamArtist>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShazamArtistToJson(
      this,
    );
  }
}

abstract class _ShazamArtist implements ShazamArtist {
  factory _ShazamArtist({final String? adamid, final String? id}) =
      _$_ShazamArtist;

  factory _ShazamArtist.fromJson(Map<String, dynamic> json) =
      _$_ShazamArtist.fromJson;

  @override
  String? get adamid;
  @override
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_ShazamArtistCopyWith<_$_ShazamArtist> get copyWith =>
      throw _privateConstructorUsedError;
}
