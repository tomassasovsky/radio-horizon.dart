// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'urlparams.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Urlparams _$UrlparamsFromJson(Map<String, dynamic> json) {
  return _Urlparams.fromJson(json);
}

/// @nodoc
mixin _$Urlparams {
  @JsonKey(name: '{trackartist}')
  String? get trackartist => throw _privateConstructorUsedError;
  @JsonKey(name: '{tracktitle}')
  String? get tracktitle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UrlparamsCopyWith<Urlparams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlparamsCopyWith<$Res> {
  factory $UrlparamsCopyWith(Urlparams value, $Res Function(Urlparams) then) =
      _$UrlparamsCopyWithImpl<$Res, Urlparams>;
  @useResult
  $Res call(
      {@JsonKey(name: '{trackartist}') String? trackartist,
      @JsonKey(name: '{tracktitle}') String? tracktitle});
}

/// @nodoc
class _$UrlparamsCopyWithImpl<$Res, $Val extends Urlparams>
    implements $UrlparamsCopyWith<$Res> {
  _$UrlparamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackartist = freezed,
    Object? tracktitle = freezed,
  }) {
    return _then(_value.copyWith(
      trackartist: freezed == trackartist
          ? _value.trackartist
          : trackartist // ignore: cast_nullable_to_non_nullable
              as String?,
      tracktitle: freezed == tracktitle
          ? _value.tracktitle
          : tracktitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UrlparamsCopyWith<$Res> implements $UrlparamsCopyWith<$Res> {
  factory _$$_UrlparamsCopyWith(
          _$_Urlparams value, $Res Function(_$_Urlparams) then) =
      __$$_UrlparamsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '{trackartist}') String? trackartist,
      @JsonKey(name: '{tracktitle}') String? tracktitle});
}

/// @nodoc
class __$$_UrlparamsCopyWithImpl<$Res>
    extends _$UrlparamsCopyWithImpl<$Res, _$_Urlparams>
    implements _$$_UrlparamsCopyWith<$Res> {
  __$$_UrlparamsCopyWithImpl(
      _$_Urlparams _value, $Res Function(_$_Urlparams) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? trackartist = freezed,
    Object? tracktitle = freezed,
  }) {
    return _then(_$_Urlparams(
      trackartist: freezed == trackartist
          ? _value.trackartist
          : trackartist // ignore: cast_nullable_to_non_nullable
              as String?,
      tracktitle: freezed == tracktitle
          ? _value.tracktitle
          : tracktitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Urlparams implements _Urlparams {
  _$_Urlparams(
      {@JsonKey(name: '{trackartist}') this.trackartist,
      @JsonKey(name: '{tracktitle}') this.tracktitle});

  factory _$_Urlparams.fromJson(Map<String, dynamic> json) =>
      _$$_UrlparamsFromJson(json);

  @override
  @JsonKey(name: '{trackartist}')
  final String? trackartist;
  @override
  @JsonKey(name: '{tracktitle}')
  final String? tracktitle;

  @override
  String toString() {
    return 'Urlparams(trackartist: $trackartist, tracktitle: $tracktitle)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Urlparams &&
            (identical(other.trackartist, trackartist) ||
                other.trackartist == trackartist) &&
            (identical(other.tracktitle, tracktitle) ||
                other.tracktitle == tracktitle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, trackartist, tracktitle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UrlparamsCopyWith<_$_Urlparams> get copyWith =>
      __$$_UrlparamsCopyWithImpl<_$_Urlparams>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UrlparamsToJson(
      this,
    );
  }
}

abstract class _Urlparams implements Urlparams {
  factory _Urlparams(
      {@JsonKey(name: '{trackartist}') final String? trackartist,
      @JsonKey(name: '{tracktitle}') final String? tracktitle}) = _$_Urlparams;

  factory _Urlparams.fromJson(Map<String, dynamic> json) =
      _$_Urlparams.fromJson;

  @override
  @JsonKey(name: '{trackartist}')
  String? get trackartist;
  @override
  @JsonKey(name: '{tracktitle}')
  String? get tracktitle;
  @override
  @JsonKey(ignore: true)
  _$$_UrlparamsCopyWith<_$_Urlparams> get copyWith =>
      throw _privateConstructorUsedError;
}
