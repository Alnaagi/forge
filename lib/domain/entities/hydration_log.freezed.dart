// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hydration_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HydrationLog {
  String get id => throw _privateConstructorUsedError;
  VolumeValue get amount => throw _privateConstructorUsedError;
  DateTime get loggedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of HydrationLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HydrationLogCopyWith<HydrationLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HydrationLogCopyWith<$Res> {
  factory $HydrationLogCopyWith(
    HydrationLog value,
    $Res Function(HydrationLog) then,
  ) = _$HydrationLogCopyWithImpl<$Res, HydrationLog>;
  @useResult
  $Res call({
    String id,
    VolumeValue amount,
    DateTime loggedAt,
    DateTime createdAt,
    DateTime updatedAt,
  });

  $VolumeValueCopyWith<$Res> get amount;
}

/// @nodoc
class _$HydrationLogCopyWithImpl<$Res, $Val extends HydrationLog>
    implements $HydrationLogCopyWith<$Res> {
  _$HydrationLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HydrationLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? loggedAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            amount: null == amount
                ? _value.amount
                : amount // ignore: cast_nullable_to_non_nullable
                      as VolumeValue,
            loggedAt: null == loggedAt
                ? _value.loggedAt
                : loggedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of HydrationLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VolumeValueCopyWith<$Res> get amount {
    return $VolumeValueCopyWith<$Res>(_value.amount, (value) {
      return _then(_value.copyWith(amount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HydrationLogImplCopyWith<$Res>
    implements $HydrationLogCopyWith<$Res> {
  factory _$$HydrationLogImplCopyWith(
    _$HydrationLogImpl value,
    $Res Function(_$HydrationLogImpl) then,
  ) = __$$HydrationLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    VolumeValue amount,
    DateTime loggedAt,
    DateTime createdAt,
    DateTime updatedAt,
  });

  @override
  $VolumeValueCopyWith<$Res> get amount;
}

/// @nodoc
class __$$HydrationLogImplCopyWithImpl<$Res>
    extends _$HydrationLogCopyWithImpl<$Res, _$HydrationLogImpl>
    implements _$$HydrationLogImplCopyWith<$Res> {
  __$$HydrationLogImplCopyWithImpl(
    _$HydrationLogImpl _value,
    $Res Function(_$HydrationLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HydrationLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? loggedAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$HydrationLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as VolumeValue,
        loggedAt: null == loggedAt
            ? _value.loggedAt
            : loggedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$HydrationLogImpl implements _HydrationLog {
  const _$HydrationLogImpl({
    required this.id,
    required this.amount,
    required this.loggedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final VolumeValue amount;
  @override
  final DateTime loggedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'HydrationLog(id: $id, amount: $amount, loggedAt: $loggedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HydrationLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.loggedAt, loggedAt) ||
                other.loggedAt == loggedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, amount, loggedAt, createdAt, updatedAt);

  /// Create a copy of HydrationLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HydrationLogImplCopyWith<_$HydrationLogImpl> get copyWith =>
      __$$HydrationLogImplCopyWithImpl<_$HydrationLogImpl>(this, _$identity);
}

abstract class _HydrationLog implements HydrationLog {
  const factory _HydrationLog({
    required final String id,
    required final VolumeValue amount,
    required final DateTime loggedAt,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$HydrationLogImpl;

  @override
  String get id;
  @override
  VolumeValue get amount;
  @override
  DateTime get loggedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of HydrationLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HydrationLogImplCopyWith<_$HydrationLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
