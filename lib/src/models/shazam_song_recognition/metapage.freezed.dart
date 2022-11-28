// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'metapage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShazamMetapage _$ShazamMetapageFromJson(Map<String, dynamic> json) {
  return _ShazamMetapage.fromJson(json);
}

/// @nodoc
mixin _$ShazamMetapage {
  String? get caption => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShazamMetapageCopyWith<ShazamMetapage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShazamMetapageCopyWith<$Res> {
  factory $ShazamMetapageCopyWith(
          ShazamMetapage value, $Res Function(ShazamMetapage) then) =
      _$ShazamMetapageCopyWithImpl<$Res, ShazamMetapage>;
  @useResult
  $Res call({String? caption, String? image});
}

/// @nodoc
class _$ShazamMetapageCopyWithImpl<$Res, $Val extends ShazamMetapage>
    implements $ShazamMetapageCopyWith<$Res> {
  _$ShazamMetapageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caption = freezed,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShazamMetapageCopyWith<$Res>
    implements $ShazamMetapageCopyWith<$Res> {
  factory _$$_ShazamMetapageCopyWith(
          _$_ShazamMetapage value, $Res Function(_$_ShazamMetapage) then) =
      __$$_ShazamMetapageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? caption, String? image});
}

/// @nodoc
class __$$_ShazamMetapageCopyWithImpl<$Res>
    extends _$ShazamMetapageCopyWithImpl<$Res, _$_ShazamMetapage>
    implements _$$_ShazamMetapageCopyWith<$Res> {
  __$$_ShazamMetapageCopyWithImpl(
      _$_ShazamMetapage _value, $Res Function(_$_ShazamMetapage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? caption = freezed,
    Object? image = freezed,
  }) {
    return _then(_$_ShazamMetapage(
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShazamMetapage implements _ShazamMetapage {
  _$_ShazamMetapage({this.caption, this.image});

  factory _$_ShazamMetapage.fromJson(Map<String, dynamic> json) =>
      _$$_ShazamMetapageFromJson(json);

  @override
  final String? caption;
  @override
  final String? image;

  @override
  String toString() {
    return 'ShazamMetapage(caption: $caption, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShazamMetapage &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, caption, image);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShazamMetapageCopyWith<_$_ShazamMetapage> get copyWith =>
      __$$_ShazamMetapageCopyWithImpl<_$_ShazamMetapage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShazamMetapageToJson(
      this,
    );
  }
}

abstract class _ShazamMetapage implements ShazamMetapage {
  factory _ShazamMetapage({final String? caption, final String? image}) =
      _$_ShazamMetapage;

  factory _ShazamMetapage.fromJson(Map<String, dynamic> json) =
      _$_ShazamMetapage.fromJson;

  @override
  String? get caption;
  @override
  String? get image;
  @override
  @JsonKey(ignore: true)
  _$$_ShazamMetapageCopyWith<_$_ShazamMetapage> get copyWith =>
      throw _privateConstructorUsedError;
}
