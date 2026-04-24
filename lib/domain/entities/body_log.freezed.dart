// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'body_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BodyLog {
  String get id => throw _privateConstructorUsedError;
  DateTime get loggedAt => throw _privateConstructorUsedError;
  WeightValue? get bodyWeight => throw _privateConstructorUsedError;
  PercentageValue? get bodyFatPercentage => throw _privateConstructorUsedError;
  MeasurementValue? get waist => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of BodyLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BodyLogCopyWith<BodyLog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BodyLogCopyWith<$Res> {
  factory $BodyLogCopyWith(BodyLog value, $Res Function(BodyLog) then) =
      _$BodyLogCopyWithImpl<$Res, BodyLog>;
  @useResult
  $Res call({
    String id,
    DateTime loggedAt,
    WeightValue? bodyWeight,
    PercentageValue? bodyFatPercentage,
    MeasurementValue? waist,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });

  $WeightValueCopyWith<$Res>? get bodyWeight;
  $PercentageValueCopyWith<$Res>? get bodyFatPercentage;
  $MeasurementValueCopyWith<$Res>? get waist;
}

/// @nodoc
class _$BodyLogCopyWithImpl<$Res, $Val extends BodyLog>
    implements $BodyLogCopyWith<$Res> {
  _$BodyLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BodyLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? loggedAt = null,
    Object? bodyWeight = freezed,
    Object? bodyFatPercentage = freezed,
    Object? waist = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            loggedAt: null == loggedAt
                ? _value.loggedAt
                : loggedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            bodyWeight: freezed == bodyWeight
                ? _value.bodyWeight
                : bodyWeight // ignore: cast_nullable_to_non_nullable
                      as WeightValue?,
            bodyFatPercentage: freezed == bodyFatPercentage
                ? _value.bodyFatPercentage
                : bodyFatPercentage // ignore: cast_nullable_to_non_nullable
                      as PercentageValue?,
            waist: freezed == waist
                ? _value.waist
                : waist // ignore: cast_nullable_to_non_nullable
                      as MeasurementValue?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
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

  /// Create a copy of BodyLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeightValueCopyWith<$Res>? get bodyWeight {
    if (_value.bodyWeight == null) {
      return null;
    }

    return $WeightValueCopyWith<$Res>(_value.bodyWeight!, (value) {
      return _then(_value.copyWith(bodyWeight: value) as $Val);
    });
  }

  /// Create a copy of BodyLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PercentageValueCopyWith<$Res>? get bodyFatPercentage {
    if (_value.bodyFatPercentage == null) {
      return null;
    }

    return $PercentageValueCopyWith<$Res>(_value.bodyFatPercentage!, (value) {
      return _then(_value.copyWith(bodyFatPercentage: value) as $Val);
    });
  }

  /// Create a copy of BodyLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MeasurementValueCopyWith<$Res>? get waist {
    if (_value.waist == null) {
      return null;
    }

    return $MeasurementValueCopyWith<$Res>(_value.waist!, (value) {
      return _then(_value.copyWith(waist: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$BodyLogImplCopyWith<$Res> implements $BodyLogCopyWith<$Res> {
  factory _$$BodyLogImplCopyWith(
    _$BodyLogImpl value,
    $Res Function(_$BodyLogImpl) then,
  ) = __$$BodyLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    DateTime loggedAt,
    WeightValue? bodyWeight,
    PercentageValue? bodyFatPercentage,
    MeasurementValue? waist,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });

  @override
  $WeightValueCopyWith<$Res>? get bodyWeight;
  @override
  $PercentageValueCopyWith<$Res>? get bodyFatPercentage;
  @override
  $MeasurementValueCopyWith<$Res>? get waist;
}

/// @nodoc
class __$$BodyLogImplCopyWithImpl<$Res>
    extends _$BodyLogCopyWithImpl<$Res, _$BodyLogImpl>
    implements _$$BodyLogImplCopyWith<$Res> {
  __$$BodyLogImplCopyWithImpl(
    _$BodyLogImpl _value,
    $Res Function(_$BodyLogImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BodyLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? loggedAt = null,
    Object? bodyWeight = freezed,
    Object? bodyFatPercentage = freezed,
    Object? waist = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$BodyLogImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        loggedAt: null == loggedAt
            ? _value.loggedAt
            : loggedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        bodyWeight: freezed == bodyWeight
            ? _value.bodyWeight
            : bodyWeight // ignore: cast_nullable_to_non_nullable
                  as WeightValue?,
        bodyFatPercentage: freezed == bodyFatPercentage
            ? _value.bodyFatPercentage
            : bodyFatPercentage // ignore: cast_nullable_to_non_nullable
                  as PercentageValue?,
        waist: freezed == waist
            ? _value.waist
            : waist // ignore: cast_nullable_to_non_nullable
                  as MeasurementValue?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
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

class _$BodyLogImpl implements _BodyLog {
  const _$BodyLogImpl({
    required this.id,
    required this.loggedAt,
    this.bodyWeight,
    this.bodyFatPercentage,
    this.waist,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final DateTime loggedAt;
  @override
  final WeightValue? bodyWeight;
  @override
  final PercentageValue? bodyFatPercentage;
  @override
  final MeasurementValue? waist;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'BodyLog(id: $id, loggedAt: $loggedAt, bodyWeight: $bodyWeight, bodyFatPercentage: $bodyFatPercentage, waist: $waist, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BodyLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.loggedAt, loggedAt) ||
                other.loggedAt == loggedAt) &&
            (identical(other.bodyWeight, bodyWeight) ||
                other.bodyWeight == bodyWeight) &&
            (identical(other.bodyFatPercentage, bodyFatPercentage) ||
                other.bodyFatPercentage == bodyFatPercentage) &&
            (identical(other.waist, waist) || other.waist == waist) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    loggedAt,
    bodyWeight,
    bodyFatPercentage,
    waist,
    notes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of BodyLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BodyLogImplCopyWith<_$BodyLogImpl> get copyWith =>
      __$$BodyLogImplCopyWithImpl<_$BodyLogImpl>(this, _$identity);
}

abstract class _BodyLog implements BodyLog {
  const factory _BodyLog({
    required final String id,
    required final DateTime loggedAt,
    final WeightValue? bodyWeight,
    final PercentageValue? bodyFatPercentage,
    final MeasurementValue? waist,
    final String? notes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$BodyLogImpl;

  @override
  String get id;
  @override
  DateTime get loggedAt;
  @override
  WeightValue? get bodyWeight;
  @override
  PercentageValue? get bodyFatPercentage;
  @override
  MeasurementValue? get waist;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of BodyLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BodyLogImplCopyWith<_$BodyLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
