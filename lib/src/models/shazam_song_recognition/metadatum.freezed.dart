// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'metadatum.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShazamMetadatum _$ShazamMetadatumFromJson(Map<String, dynamic> json) {
  return _ShazamMetadatum.fromJson(json);
}

/// @nodoc
mixin _$ShazamMetadatum {
  String? get text => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShazamMetadatumCopyWith<ShazamMetadatum> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShazamMetadatumCopyWith<$Res> {
  factory $ShazamMetadatumCopyWith(
          ShazamMetadatum value, $Res Function(ShazamMetadatum) then) =
      _$ShazamMetadatumCopyWithImpl<$Res, ShazamMetadatum>;
  @useResult
  $Res call({String? text, String? title});
}

/// @nodoc
class _$ShazamMetadatumCopyWithImpl<$Res, $Val extends ShazamMetadatum>
    implements $ShazamMetadatumCopyWith<$Res> {
  _$ShazamMetadatumCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
    Object? title = freezed,
  }) {
    return _then(_value.copyWith(
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShazamMetadatumCopyWith<$Res>
    implements $ShazamMetadatumCopyWith<$Res> {
  factory _$$_ShazamMetadatumCopyWith(
          _$_ShazamMetadatum value, $Res Function(_$_ShazamMetadatum) then) =
      __$$_ShazamMetadatumCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? text, String? title});
}

/// @nodoc
class __$$_ShazamMetadatumCopyWithImpl<$Res>
    extends _$ShazamMetadatumCopyWithImpl<$Res, _$_ShazamMetadatum>
    implements _$$_ShazamMetadatumCopyWith<$Res> {
  __$$_ShazamMetadatumCopyWithImpl(
      _$_ShazamMetadatum _value, $Res Function(_$_ShazamMetadatum) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = freezed,
    Object? title = freezed,
  }) {
    return _then(_$_ShazamMetadatum(
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShazamMetadatum implements _ShazamMetadatum {
  _$_ShazamMetadatum({this.text, this.title});

  factory _$_ShazamMetadatum.fromJson(Map<String, dynamic> json) =>
      _$$_ShazamMetadatumFromJson(json);

  @override
  final String? text;
  @override
  final String? title;

  @override
  String toString() {
    return 'ShazamMetadatum(text: $text, title: $title)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShazamMetadatum &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, text, title);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShazamMetadatumCopyWith<_$_ShazamMetadatum> get copyWith =>
      __$$_ShazamMetadatumCopyWithImpl<_$_ShazamMetadatum>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShazamMetadatumToJson(
      this,
    );
  }
}

abstract class _ShazamMetadatum implements ShazamMetadatum {
  factory _ShazamMetadatum({final String? text, final String? title}) =
      _$_ShazamMetadatum;

  factory _ShazamMetadatum.fromJson(Map<String, dynamic> json) =
      _$_ShazamMetadatum.fromJson;

  @override
  String? get text;
  @override
  String? get title;
  @override
  @JsonKey(ignore: true)
  _$$_ShazamMetadatumCopyWith<_$_ShazamMetadatum> get copyWith =>
      throw _privateConstructorUsedError;
}
