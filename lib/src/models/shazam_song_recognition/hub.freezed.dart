// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'hub.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShazamHub _$ShazamHubFromJson(Map<String, dynamic> json) {
  return _ShazamHub.fromJson(json);
}

/// @nodoc
mixin _$ShazamHub {
  List<ShazamAction>? get actions => throw _privateConstructorUsedError;
  String? get displayname => throw _privateConstructorUsedError;
  bool? get explicit => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  List<ShazamOption>? get options => throw _privateConstructorUsedError;
  List<ShazamProvider>? get providers => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShazamHubCopyWith<ShazamHub> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShazamHubCopyWith<$Res> {
  factory $ShazamHubCopyWith(ShazamHub value, $Res Function(ShazamHub) then) =
      _$ShazamHubCopyWithImpl<$Res, ShazamHub>;
  @useResult
  $Res call(
      {List<ShazamAction>? actions,
      String? displayname,
      bool? explicit,
      String? image,
      List<ShazamOption>? options,
      List<ShazamProvider>? providers,
      String? type});
}

/// @nodoc
class _$ShazamHubCopyWithImpl<$Res, $Val extends ShazamHub>
    implements $ShazamHubCopyWith<$Res> {
  _$ShazamHubCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actions = freezed,
    Object? displayname = freezed,
    Object? explicit = freezed,
    Object? image = freezed,
    Object? options = freezed,
    Object? providers = freezed,
    Object? type = freezed,
  }) {
    return _then(_value.copyWith(
      actions: freezed == actions
          ? _value.actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<ShazamAction>?,
      displayname: freezed == displayname
          ? _value.displayname
          : displayname // ignore: cast_nullable_to_non_nullable
              as String?,
      explicit: freezed == explicit
          ? _value.explicit
          : explicit // ignore: cast_nullable_to_non_nullable
              as bool?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<ShazamOption>?,
      providers: freezed == providers
          ? _value.providers
          : providers // ignore: cast_nullable_to_non_nullable
              as List<ShazamProvider>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShazamHubCopyWith<$Res> implements $ShazamHubCopyWith<$Res> {
  factory _$$_ShazamHubCopyWith(
          _$_ShazamHub value, $Res Function(_$_ShazamHub) then) =
      __$$_ShazamHubCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<ShazamAction>? actions,
      String? displayname,
      bool? explicit,
      String? image,
      List<ShazamOption>? options,
      List<ShazamProvider>? providers,
      String? type});
}

/// @nodoc
class __$$_ShazamHubCopyWithImpl<$Res>
    extends _$ShazamHubCopyWithImpl<$Res, _$_ShazamHub>
    implements _$$_ShazamHubCopyWith<$Res> {
  __$$_ShazamHubCopyWithImpl(
      _$_ShazamHub _value, $Res Function(_$_ShazamHub) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? actions = freezed,
    Object? displayname = freezed,
    Object? explicit = freezed,
    Object? image = freezed,
    Object? options = freezed,
    Object? providers = freezed,
    Object? type = freezed,
  }) {
    return _then(_$_ShazamHub(
      actions: freezed == actions
          ? _value._actions
          : actions // ignore: cast_nullable_to_non_nullable
              as List<ShazamAction>?,
      displayname: freezed == displayname
          ? _value.displayname
          : displayname // ignore: cast_nullable_to_non_nullable
              as String?,
      explicit: freezed == explicit
          ? _value.explicit
          : explicit // ignore: cast_nullable_to_non_nullable
              as bool?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      options: freezed == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<ShazamOption>?,
      providers: freezed == providers
          ? _value._providers
          : providers // ignore: cast_nullable_to_non_nullable
              as List<ShazamProvider>?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShazamHub implements _ShazamHub {
  _$_ShazamHub(
      {final List<ShazamAction>? actions,
      this.displayname,
      this.explicit,
      this.image,
      final List<ShazamOption>? options,
      final List<ShazamProvider>? providers,
      this.type})
      : _actions = actions,
        _options = options,
        _providers = providers;

  factory _$_ShazamHub.fromJson(Map<String, dynamic> json) =>
      _$$_ShazamHubFromJson(json);

  final List<ShazamAction>? _actions;
  @override
  List<ShazamAction>? get actions {
    final value = _actions;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? displayname;
  @override
  final bool? explicit;
  @override
  final String? image;
  final List<ShazamOption>? _options;
  @override
  List<ShazamOption>? get options {
    final value = _options;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<ShazamProvider>? _providers;
  @override
  List<ShazamProvider>? get providers {
    final value = _providers;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? type;

  @override
  String toString() {
    return 'ShazamHub(actions: $actions, displayname: $displayname, explicit: $explicit, image: $image, options: $options, providers: $providers, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShazamHub &&
            const DeepCollectionEquality().equals(other._actions, _actions) &&
            (identical(other.displayname, displayname) ||
                other.displayname == displayname) &&
            (identical(other.explicit, explicit) ||
                other.explicit == explicit) &&
            (identical(other.image, image) || other.image == image) &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            const DeepCollectionEquality()
                .equals(other._providers, _providers) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_actions),
      displayname,
      explicit,
      image,
      const DeepCollectionEquality().hash(_options),
      const DeepCollectionEquality().hash(_providers),
      type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShazamHubCopyWith<_$_ShazamHub> get copyWith =>
      __$$_ShazamHubCopyWithImpl<_$_ShazamHub>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShazamHubToJson(
      this,
    );
  }
}

abstract class _ShazamHub implements ShazamHub {
  factory _ShazamHub(
      {final List<ShazamAction>? actions,
      final String? displayname,
      final bool? explicit,
      final String? image,
      final List<ShazamOption>? options,
      final List<ShazamProvider>? providers,
      final String? type}) = _$_ShazamHub;

  factory _ShazamHub.fromJson(Map<String, dynamic> json) =
      _$_ShazamHub.fromJson;

  @override
  List<ShazamAction>? get actions;
  @override
  String? get displayname;
  @override
  bool? get explicit;
  @override
  String? get image;
  @override
  List<ShazamOption>? get options;
  @override
  List<ShazamProvider>? get providers;
  @override
  String? get type;
  @override
  @JsonKey(ignore: true)
  _$$_ShazamHubCopyWith<_$_ShazamHub> get copyWith =>
      throw _privateConstructorUsedError;
}
