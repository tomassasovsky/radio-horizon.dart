// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'beacondata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShazamBeacondata _$ShazamBeacondataFromJson(Map<String, dynamic> json) {
  return _ShazamBeacondata.fromJson(json);
}

/// @nodoc
mixin _$ShazamBeacondata {
  String? get providername => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShazamBeacondataCopyWith<ShazamBeacondata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShazamBeacondataCopyWith<$Res> {
  factory $ShazamBeacondataCopyWith(
          ShazamBeacondata value, $Res Function(ShazamBeacondata) then) =
      _$ShazamBeacondataCopyWithImpl<$Res, ShazamBeacondata>;
  @useResult
  $Res call({String? providername, String? type});
}

/// @nodoc
class _$ShazamBeacondataCopyWithImpl<$Res, $Val extends ShazamBeacondata>
    implements $ShazamBeacondataCopyWith<$Res> {
  _$ShazamBeacondataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providername = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      providername: freezed == providername
          ? _value.providername
          : providername // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShazamBeacondataCopyWith<$Res>
    implements $ShazamBeacondataCopyWith<$Res> {
  factory _$$_ShazamBeacondataCopyWith(
          _$_ShazamBeacondata value, $Res Function(_$_ShazamBeacondata) then) =
      __$$_ShazamBeacondataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? providername, String? type});
}

/// @nodoc
class __$$_ShazamBeacondataCopyWithImpl<$Res>
    extends _$ShazamBeacondataCopyWithImpl<$Res, _$_ShazamBeacondata>
    implements _$$_ShazamBeacondataCopyWith<$Res> {
  __$$_ShazamBeacondataCopyWithImpl(
      _$_ShazamBeacondata _value, $Res Function(_$_ShazamBeacondata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? providername = freezed,
    Object? type = freezed,
  }) {
    return _then(_$_ShazamBeacondata(
      providername: freezed == providername
          ? _value.providername
          : providername // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShazamBeacondata implements _ShazamBeacondata {
  _$_ShazamBeacondata({this.providername, this.type});

  factory _$_ShazamBeacondata.fromJson(Map<String, dynamic> json) =>
      _$$_ShazamBeacondataFromJson(json);

  @override
  final String? providername;
  @override
  final String? type;

  @override
  String toString() {
    return 'ShazamBeacondata(providername: $providername, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShazamBeacondata &&
            (identical(other.providername, providername) ||
                other.providername == providername) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, providername, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShazamBeacondataCopyWith<_$_ShazamBeacondata> get copyWith =>
      __$$_ShazamBeacondataCopyWithImpl<_$_ShazamBeacondata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShazamBeacondataToJson(
      this,
    );
  }
}

abstract class _ShazamBeacondata implements ShazamBeacondata {
  factory _ShazamBeacondata({final String? providername, final String? type}) =
      _$_ShazamBeacondata;

  factory _ShazamBeacondata.fromJson(Map<String, dynamic> json) =
      _$_ShazamBeacondata.fromJson;

  @override
  String? get providername;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$$_ShazamBeacondataCopyWith<_$_ShazamBeacondata> get copyWith =>
      throw _privateConstructorUsedError;
}
