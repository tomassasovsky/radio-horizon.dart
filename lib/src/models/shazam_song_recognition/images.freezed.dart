// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'images.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShazamImages _$ShazamImagesFromJson(Map<String, dynamic> json) {
  return _ShazamImages.fromJson(json);
}

/// @nodoc
mixin _$ShazamImages {
  @JsonKey(name: 'default')
  String? get imagesDefault => throw _privateConstructorUsedError;
  String? get overflow => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShazamImagesCopyWith<ShazamImages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShazamImagesCopyWith<$Res> {
  factory $ShazamImagesCopyWith(
          ShazamImages value, $Res Function(ShazamImages) then) =
      _$ShazamImagesCopyWithImpl<$Res, ShazamImages>;
  @useResult
  $Res call(
      {@JsonKey(name: 'default') String? imagesDefault, String? overflow});
}

/// @nodoc
class _$ShazamImagesCopyWithImpl<$Res, $Val extends ShazamImages>
    implements $ShazamImagesCopyWith<$Res> {
  _$ShazamImagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagesDefault = freezed,
    Object? overflow = freezed,
  }) {
    return _then(_value.copyWith(
      imagesDefault: freezed == imagesDefault
          ? _value.imagesDefault
          : imagesDefault // ignore: cast_nullable_to_non_nullable
              as String?,
      overflow: freezed == overflow
          ? _value.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShazamImagesCopyWith<$Res>
    implements $ShazamImagesCopyWith<$Res> {
  factory _$$_ShazamImagesCopyWith(
          _$_ShazamImages value, $Res Function(_$_ShazamImages) then) =
      __$$_ShazamImagesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'default') String? imagesDefault, String? overflow});
}

/// @nodoc
class __$$_ShazamImagesCopyWithImpl<$Res>
    extends _$ShazamImagesCopyWithImpl<$Res, _$_ShazamImages>
    implements _$$_ShazamImagesCopyWith<$Res> {
  __$$_ShazamImagesCopyWithImpl(
      _$_ShazamImages _value, $Res Function(_$_ShazamImages) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imagesDefault = freezed,
    Object? overflow = freezed,
  }) {
    return _then(_$_ShazamImages(
      imagesDefault: freezed == imagesDefault
          ? _value.imagesDefault
          : imagesDefault // ignore: cast_nullable_to_non_nullable
              as String?,
      overflow: freezed == overflow
          ? _value.overflow
          : overflow // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShazamImages implements _ShazamImages {
  _$_ShazamImages(
      {@JsonKey(name: 'default') this.imagesDefault, this.overflow});

  factory _$_ShazamImages.fromJson(Map<String, dynamic> json) =>
      _$$_ShazamImagesFromJson(json);

  @override
  @JsonKey(name: 'default')
  final String? imagesDefault;
  @override
  final String? overflow;

  @override
  String toString() {
    return 'ShazamImages(imagesDefault: $imagesDefault, overflow: $overflow)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShazamImages &&
            (identical(other.imagesDefault, imagesDefault) ||
                other.imagesDefault == imagesDefault) &&
            (identical(other.overflow, overflow) ||
                other.overflow == overflow));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, imagesDefault, overflow);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShazamImagesCopyWith<_$_ShazamImages> get copyWith =>
      __$$_ShazamImagesCopyWithImpl<_$_ShazamImages>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShazamImagesToJson(
      this,
    );
  }
}

abstract class _ShazamImages implements ShazamImages {
  factory _ShazamImages(
      {@JsonKey(name: 'default') final String? imagesDefault,
      final String? overflow}) = _$_ShazamImages;

  factory _ShazamImages.fromJson(Map<String, dynamic> json) =
      _$_ShazamImages.fromJson;

  @override
  @JsonKey(name: 'default')
  String? get imagesDefault;
  @override
  String? get overflow;
  @override
  @JsonKey(ignore: true)
  _$$_ShazamImagesCopyWith<_$_ShazamImages> get copyWith =>
      throw _privateConstructorUsedError;
}
