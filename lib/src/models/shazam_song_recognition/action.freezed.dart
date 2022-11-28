// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'action.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShazamAction _$ShazamActionFromJson(Map<String, dynamic> json) {
  return _ShazamAction.fromJson(json);
}

/// @nodoc
mixin _$ShazamAction {
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get uri => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShazamActionCopyWith<ShazamAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShazamActionCopyWith<$Res> {
  factory $ShazamActionCopyWith(
          ShazamAction value, $Res Function(ShazamAction) then) =
      _$ShazamActionCopyWithImpl<$Res, ShazamAction>;
  @useResult
  $Res call({String? id, String? name, String? type, String? uri});
}

/// @nodoc
class _$ShazamActionCopyWithImpl<$Res, $Val extends ShazamAction>
    implements $ShazamActionCopyWith<$Res> {
  _$ShazamActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? uri = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      uri: freezed == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShazamActionCopyWith<$Res>
    implements $ShazamActionCopyWith<$Res> {
  factory _$$_ShazamActionCopyWith(
          _$_ShazamAction value, $Res Function(_$_ShazamAction) then) =
      __$$_ShazamActionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? name, String? type, String? uri});
}

/// @nodoc
class __$$_ShazamActionCopyWithImpl<$Res>
    extends _$ShazamActionCopyWithImpl<$Res, _$_ShazamAction>
    implements _$$_ShazamActionCopyWith<$Res> {
  __$$_ShazamActionCopyWithImpl(
      _$_ShazamAction _value, $Res Function(_$_ShazamAction) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? type = freezed,
    Object? uri = freezed,
  }) {
    return _then(_$_ShazamAction(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      uri: freezed == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShazamAction implements _ShazamAction {
  _$_ShazamAction({this.id, this.name, this.type, this.uri});

  factory _$_ShazamAction.fromJson(Map<String, dynamic> json) =>
      _$$_ShazamActionFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? type;
  @override
  final String? uri;

  @override
  String toString() {
    return 'ShazamAction(id: $id, name: $name, type: $type, uri: $uri)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShazamAction &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.uri, uri) || other.uri == uri));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, type, uri);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShazamActionCopyWith<_$_ShazamAction> get copyWith =>
      __$$_ShazamActionCopyWithImpl<_$_ShazamAction>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShazamActionToJson(
      this,
    );
  }
}

abstract class _ShazamAction implements ShazamAction {
  factory _ShazamAction(
      {final String? id,
      final String? name,
      final String? type,
      final String? uri}) = _$_ShazamAction;

  factory _ShazamAction.fromJson(Map<String, dynamic> json) =
      _$_ShazamAction.fromJson;

  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get type;
  @override
  String? get uri;
  @override
  @JsonKey(ignore: true)
  _$$_ShazamActionCopyWith<_$_ShazamAction> get copyWith =>
      throw _privateConstructorUsedError;
}
