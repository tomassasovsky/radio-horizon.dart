// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'platform.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MusicLinksPlatform _$MusicLinksPlatformFromJson(Map<String, dynamic> json) {
  return _MusicLinksPlatform.fromJson(json);
}

/// @nodoc
mixin _$MusicLinksPlatform {
  String? get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MusicLinksPlatformCopyWith<MusicLinksPlatform> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicLinksPlatformCopyWith<$Res> {
  factory $MusicLinksPlatformCopyWith(
          MusicLinksPlatform value, $Res Function(MusicLinksPlatform) then) =
      _$MusicLinksPlatformCopyWithImpl<$Res, MusicLinksPlatform>;
  @useResult
  $Res call({String? name, String? url});
}

/// @nodoc
class _$MusicLinksPlatformCopyWithImpl<$Res, $Val extends MusicLinksPlatform>
    implements $MusicLinksPlatformCopyWith<$Res> {
  _$MusicLinksPlatformCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MusicLinksPlatformCopyWith<$Res>
    implements $MusicLinksPlatformCopyWith<$Res> {
  factory _$$_MusicLinksPlatformCopyWith(_$_MusicLinksPlatform value,
          $Res Function(_$_MusicLinksPlatform) then) =
      __$$_MusicLinksPlatformCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? url});
}

/// @nodoc
class __$$_MusicLinksPlatformCopyWithImpl<$Res>
    extends _$MusicLinksPlatformCopyWithImpl<$Res, _$_MusicLinksPlatform>
    implements _$$_MusicLinksPlatformCopyWith<$Res> {
  __$$_MusicLinksPlatformCopyWithImpl(
      _$_MusicLinksPlatform _value, $Res Function(_$_MusicLinksPlatform) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
  }) {
    return _then(_$_MusicLinksPlatform(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MusicLinksPlatform implements _MusicLinksPlatform {
  const _$_MusicLinksPlatform({this.name, this.url});

  factory _$_MusicLinksPlatform.fromJson(Map<String, dynamic> json) =>
      _$$_MusicLinksPlatformFromJson(json);

  @override
  final String? name;
  @override
  final String? url;

  @override
  String toString() {
    return 'MusicLinksPlatform(name: $name, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MusicLinksPlatform &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MusicLinksPlatformCopyWith<_$_MusicLinksPlatform> get copyWith =>
      __$$_MusicLinksPlatformCopyWithImpl<_$_MusicLinksPlatform>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MusicLinksPlatformToJson(
      this,
    );
  }
}

abstract class _MusicLinksPlatform implements MusicLinksPlatform {
  const factory _MusicLinksPlatform({final String? name, final String? url}) =
      _$_MusicLinksPlatform;

  factory _MusicLinksPlatform.fromJson(Map<String, dynamic> json) =
      _$_MusicLinksPlatform.fromJson;

  @override
  String? get name;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$_MusicLinksPlatformCopyWith<_$_MusicLinksPlatform> get copyWith =>
      throw _privateConstructorUsedError;
}
