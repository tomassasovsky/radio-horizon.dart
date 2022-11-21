// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'social.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MusicLinksSocial _$MusicLinksSocialFromJson(Map<String, dynamic> json) {
  return _MusicLinksSocial.fromJson(json);
}

/// @nodoc
mixin _$MusicLinksSocial {
  String? get name => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MusicLinksSocialCopyWith<MusicLinksSocial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicLinksSocialCopyWith<$Res> {
  factory $MusicLinksSocialCopyWith(
          MusicLinksSocial value, $Res Function(MusicLinksSocial) then) =
      _$MusicLinksSocialCopyWithImpl<$Res, MusicLinksSocial>;
  @useResult
  $Res call({String? name, String? url});
}

/// @nodoc
class _$MusicLinksSocialCopyWithImpl<$Res, $Val extends MusicLinksSocial>
    implements $MusicLinksSocialCopyWith<$Res> {
  _$MusicLinksSocialCopyWithImpl(this._value, this._then);

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
abstract class _$$_MusicLinksSocialCopyWith<$Res>
    implements $MusicLinksSocialCopyWith<$Res> {
  factory _$$_MusicLinksSocialCopyWith(
          _$_MusicLinksSocial value, $Res Function(_$_MusicLinksSocial) then) =
      __$$_MusicLinksSocialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? url});
}

/// @nodoc
class __$$_MusicLinksSocialCopyWithImpl<$Res>
    extends _$MusicLinksSocialCopyWithImpl<$Res, _$_MusicLinksSocial>
    implements _$$_MusicLinksSocialCopyWith<$Res> {
  __$$_MusicLinksSocialCopyWithImpl(
      _$_MusicLinksSocial _value, $Res Function(_$_MusicLinksSocial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? url = freezed,
  }) {
    return _then(_$_MusicLinksSocial(
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
class _$_MusicLinksSocial implements _MusicLinksSocial {
  const _$_MusicLinksSocial({this.name, this.url});

  factory _$_MusicLinksSocial.fromJson(Map<String, dynamic> json) =>
      _$$_MusicLinksSocialFromJson(json);

  @override
  final String? name;
  @override
  final String? url;

  @override
  String toString() {
    return 'MusicLinksSocial(name: $name, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MusicLinksSocial &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MusicLinksSocialCopyWith<_$_MusicLinksSocial> get copyWith =>
      __$$_MusicLinksSocialCopyWithImpl<_$_MusicLinksSocial>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MusicLinksSocialToJson(
      this,
    );
  }
}

abstract class _MusicLinksSocial implements MusicLinksSocial {
  const factory _MusicLinksSocial({final String? name, final String? url}) =
      _$_MusicLinksSocial;

  factory _MusicLinksSocial.fromJson(Map<String, dynamic> json) =
      _$_MusicLinksSocial.fromJson;

  @override
  String? get name;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$_MusicLinksSocialCopyWith<_$_MusicLinksSocial> get copyWith =>
      throw _privateConstructorUsedError;
}
