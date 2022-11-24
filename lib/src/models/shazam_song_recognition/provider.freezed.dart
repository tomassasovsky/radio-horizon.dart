// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShazamProvider _$ShazamProviderFromJson(Map<String, dynamic> json) {
  return _ShazamProvider.fromJson(json);
}

/// @nodoc
mixin _$ShazamProvider {
  List<ShazamAction>? get actions => throw _privateConstructorUsedError;
  String? get caption => throw _privateConstructorUsedError;
  ShazamImages? get images => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShazamProviderCopyWith<ShazamProvider> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShazamProviderCopyWith<$Res> {
  factory $ShazamProviderCopyWith(
          ShazamProvider value, $Res Function(ShazamProvider) then) =
      _$ShazamProviderCopyWithImpl<$Res, ShazamProvider>;
  @useResult
  $Res call(
      {List<ShazamAction>? actions,
      String? caption,
      ShazamImages? images,
      String? type});

  $ShazamImagesCopyWith<$Res>? get images;
}

/// @nodoc
class _$ShazamProviderCopyWithImpl<$Res, $Val extends ShazamProvider>
    implements $ShazamProviderCopyWith<$Res> {
  _$ShazamProviderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actions = freezed,
    Object? caption = freezed,
    Object? images = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<ShazamAction>?,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as ShazamImages?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ShazamImagesCopyWith<$Res>? get images {
    if (_value.images == null) {
      return null;
    }

    return $ShazamImagesCopyWith<$Res>(_value.images!, (value) {
      return _then(_value.copyWith(images: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ShazamProviderCopyWith<$Res>
    implements $ShazamProviderCopyWith<$Res> {
  factory _$$_ShazamProviderCopyWith(
          _$_ShazamProvider value, $Res Function(_$_ShazamProvider) then) =
      __$$_ShazamProviderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ShazamAction>? actions,
      String? caption,
      ShazamImages? images,
      String? type});

  @override
  $ShazamImagesCopyWith<$Res>? get images;
}

/// @nodoc
class __$$_ShazamProviderCopyWithImpl<$Res>
    extends _$ShazamProviderCopyWithImpl<$Res, _$_ShazamProvider>
    implements _$$_ShazamProviderCopyWith<$Res> {
  __$$_ShazamProviderCopyWithImpl(
      _$_ShazamProvider _value, $Res Function(_$_ShazamProvider) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actions = freezed,
    Object? caption = freezed,
    Object? images = freezed,
    Object? type = freezed,
  }) {
    return _then(_$_ShazamProvider(
      actions: freezed == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<ShazamAction>?,
      caption: freezed == caption
          ? _value.caption
          : caption // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as ShazamImages?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShazamProvider implements _ShazamProvider {
  _$_ShazamProvider(
      {final List<ShazamAction>? actions, this.caption, this.images, this.type})
      : _actions = actions;

  factory _$_ShazamProvider.fromJson(Map<String, dynamic> json) =>
      _$$_ShazamProviderFromJson(json);

  final List<ShazamAction>? _actions;
  @override
  List<ShazamAction>? get actions {
    final value = _actions;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? caption;
  @override
  final ShazamImages? images;
  @override
  final String? type;

  @override
  String toString() {
    return 'ShazamProvider(actions: $actions, caption: $caption, images: $images, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShazamProvider &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.caption, caption) || other.caption == caption) &&
            (identical(other.images, images) || other.images == images) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_actions), caption, images, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShazamProviderCopyWith<_$_ShazamProvider> get copyWith =>
      __$$_ShazamProviderCopyWithImpl<_$_ShazamProvider>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShazamProviderToJson(
      this,
    );
  }
}

abstract class _ShazamProvider implements ShazamProvider {
  factory _ShazamProvider(
      {final List<ShazamAction>? actions,
      final String? caption,
      final ShazamImages? images,
      final String? type}) = _$_ShazamProvider;

  factory _ShazamProvider.fromJson(Map<String, dynamic> json) =
      _$_ShazamProvider.fromJson;

  @override
  List<ShazamAction>? get actions;
  @override
  String? get caption;
  @override
  ShazamImages? get images;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$$_ShazamProviderCopyWith<_$_ShazamProvider> get copyWith =>
      throw _privateConstructorUsedError;
}
