// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'music_links_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MusicLinksResponse _$MusicLinksResponseFromJson(Map<String, dynamic> json) {
  return _MusicLinksResponse.fromJson(json);
}

/// @nodoc
mixin _$MusicLinksResponse {
  String? get image => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  List<MusicLinksPlatform>? get platforms => throw _privateConstructorUsedError;
  List<MusicLinksSocial>? get social => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MusicLinksResponseCopyWith<MusicLinksResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicLinksResponseCopyWith<$Res> {
  factory $MusicLinksResponseCopyWith(
          MusicLinksResponse value, $Res Function(MusicLinksResponse) then) =
      _$MusicLinksResponseCopyWithImpl<$Res, MusicLinksResponse>;
  @useResult
  $Res call(
      {String? image,
      String? name,
      List<MusicLinksPlatform>? platforms,
      List<MusicLinksSocial>? social});
}

/// @nodoc
class _$MusicLinksResponseCopyWithImpl<$Res, $Val extends MusicLinksResponse>
    implements $MusicLinksResponseCopyWith<$Res> {
  _$MusicLinksResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? name = freezed,
    Object? platforms = freezed,
    Object? social = freezed,
  }) {
    return _then(_value.copyWith(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      platforms: freezed == platforms
          ? _value.platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<MusicLinksPlatform>?,
      social: freezed == social
          ? _value.social
          : social // ignore: cast_nullable_to_non_nullable
              as List<MusicLinksSocial>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MusicLinksResponseCopyWith<$Res>
    implements $MusicLinksResponseCopyWith<$Res> {
  factory _$$_MusicLinksResponseCopyWith(_$_MusicLinksResponse value,
          $Res Function(_$_MusicLinksResponse) then) =
      __$$_MusicLinksResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? image,
      String? name,
      List<MusicLinksPlatform>? platforms,
      List<MusicLinksSocial>? social});
}

/// @nodoc
class __$$_MusicLinksResponseCopyWithImpl<$Res>
    extends _$MusicLinksResponseCopyWithImpl<$Res, _$_MusicLinksResponse>
    implements _$$_MusicLinksResponseCopyWith<$Res> {
  __$$_MusicLinksResponseCopyWithImpl(
      _$_MusicLinksResponse _value, $Res Function(_$_MusicLinksResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? image = freezed,
    Object? name = freezed,
    Object? platforms = freezed,
    Object? social = freezed,
  }) {
    return _then(_$_MusicLinksResponse(
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      platforms: freezed == platforms
          ? _value._platforms
          : platforms // ignore: cast_nullable_to_non_nullable
              as List<MusicLinksPlatform>?,
      social: freezed == social
          ? _value._social
          : social // ignore: cast_nullable_to_non_nullable
              as List<MusicLinksSocial>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MusicLinksResponse extends _MusicLinksResponse {
  const _$_MusicLinksResponse(
      {this.image,
      this.name,
      final List<MusicLinksPlatform>? platforms,
      final List<MusicLinksSocial>? social})
      : _platforms = platforms,
        _social = social,
        super._();

  factory _$_MusicLinksResponse.fromJson(Map<String, dynamic> json) =>
      _$$_MusicLinksResponseFromJson(json);

  @override
  final String? image;
  @override
  final String? name;
  final List<MusicLinksPlatform>? _platforms;
  @override
  List<MusicLinksPlatform>? get platforms {
    final value = _platforms;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<MusicLinksSocial>? _social;
  @override
  List<MusicLinksSocial>? get social {
    final value = _social;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MusicLinksResponse(image: $image, name: $name, platforms: $platforms, social: $social)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MusicLinksResponse &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._platforms, _platforms) &&
            const DeepCollectionEquality().equals(other._social, _social));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      image,
      name,
      const DeepCollectionEquality().hash(_platforms),
      const DeepCollectionEquality().hash(_social));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MusicLinksResponseCopyWith<_$_MusicLinksResponse> get copyWith =>
      __$$_MusicLinksResponseCopyWithImpl<_$_MusicLinksResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MusicLinksResponseToJson(
      this,
    );
  }
}

abstract class _MusicLinksResponse extends MusicLinksResponse {
  const factory _MusicLinksResponse(
      {final String? image,
      final String? name,
      final List<MusicLinksPlatform>? platforms,
      final List<MusicLinksSocial>? social}) = _$_MusicLinksResponse;
  const _MusicLinksResponse._() : super._();

  factory _MusicLinksResponse.fromJson(Map<String, dynamic> json) =
      _$_MusicLinksResponse.fromJson;

  @override
  String? get image;
  @override
  String? get name;
  @override
  List<MusicLinksPlatform>? get platforms;
  @override
  List<MusicLinksSocial>? get social;
  @override
  @JsonKey(ignore: true)
  _$$_MusicLinksResponseCopyWith<_$_MusicLinksResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
