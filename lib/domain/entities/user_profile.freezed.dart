// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$UserProfile {
  String get id => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  WeightUnit get preferredWeightUnit => throw _privateConstructorUsedError;
  BodyMetricUnit get preferredBodyMetricUnit =>
      throw _privateConstructorUsedError;
  MeasurementValue? get height => throw _privateConstructorUsedError;
  ActivityLevel? get activityLevel => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    String id,
    String displayName,
    WeightUnit preferredWeightUnit,
    BodyMetricUnit preferredBodyMetricUnit,
    MeasurementValue? height,
    ActivityLevel? activityLevel,
    DateTime createdAt,
    DateTime updatedAt,
  });

  $MeasurementValueCopyWith<$Res>? get height;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? preferredWeightUnit = null,
    Object? preferredBodyMetricUnit = null,
    Object? height = freezed,
    Object? activityLevel = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            preferredWeightUnit: null == preferredWeightUnit
                ? _value.preferredWeightUnit
                : preferredWeightUnit // ignore: cast_nullable_to_non_nullable
                      as WeightUnit,
            preferredBodyMetricUnit: null == preferredBodyMetricUnit
                ? _value.preferredBodyMetricUnit
                : preferredBodyMetricUnit // ignore: cast_nullable_to_non_nullable
                      as BodyMetricUnit,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as MeasurementValue?,
            activityLevel: freezed == activityLevel
                ? _value.activityLevel
                : activityLevel // ignore: cast_nullable_to_non_nullable
                      as ActivityLevel?,
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

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MeasurementValueCopyWith<$Res>? get height {
    if (_value.height == null) {
      return null;
    }

    return $MeasurementValueCopyWith<$Res>(_value.height!, (value) {
      return _then(_value.copyWith(height: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String displayName,
    WeightUnit preferredWeightUnit,
    BodyMetricUnit preferredBodyMetricUnit,
    MeasurementValue? height,
    ActivityLevel? activityLevel,
    DateTime createdAt,
    DateTime updatedAt,
  });

  @override
  $MeasurementValueCopyWith<$Res>? get height;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = null,
    Object? preferredWeightUnit = null,
    Object? preferredBodyMetricUnit = null,
    Object? height = freezed,
    Object? activityLevel = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$UserProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        preferredWeightUnit: null == preferredWeightUnit
            ? _value.preferredWeightUnit
            : preferredWeightUnit // ignore: cast_nullable_to_non_nullable
                  as WeightUnit,
        preferredBodyMetricUnit: null == preferredBodyMetricUnit
            ? _value.preferredBodyMetricUnit
            : preferredBodyMetricUnit // ignore: cast_nullable_to_non_nullable
                  as BodyMetricUnit,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as MeasurementValue?,
        activityLevel: freezed == activityLevel
            ? _value.activityLevel
            : activityLevel // ignore: cast_nullable_to_non_nullable
                  as ActivityLevel?,
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

class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    required this.id,
    required this.displayName,
    required this.preferredWeightUnit,
    required this.preferredBodyMetricUnit,
    this.height,
    this.activityLevel,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final String displayName;
  @override
  final WeightUnit preferredWeightUnit;
  @override
  final BodyMetricUnit preferredBodyMetricUnit;
  @override
  final MeasurementValue? height;
  @override
  final ActivityLevel? activityLevel;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'UserProfile(id: $id, displayName: $displayName, preferredWeightUnit: $preferredWeightUnit, preferredBodyMetricUnit: $preferredBodyMetricUnit, height: $height, activityLevel: $activityLevel, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.preferredWeightUnit, preferredWeightUnit) ||
                other.preferredWeightUnit == preferredWeightUnit) &&
            (identical(
                  other.preferredBodyMetricUnit,
                  preferredBodyMetricUnit,
                ) ||
                other.preferredBodyMetricUnit == preferredBodyMetricUnit) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.activityLevel, activityLevel) ||
                other.activityLevel == activityLevel) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    displayName,
    preferredWeightUnit,
    preferredBodyMetricUnit,
    height,
    activityLevel,
    createdAt,
    updatedAt,
  );

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    required final String id,
    required final String displayName,
    required final WeightUnit preferredWeightUnit,
    required final BodyMetricUnit preferredBodyMetricUnit,
    final MeasurementValue? height,
    final ActivityLevel? activityLevel,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$UserProfileImpl;

  @override
  String get id;
  @override
  String get displayName;
  @override
  WeightUnit get preferredWeightUnit;
  @override
  BodyMetricUnit get preferredBodyMetricUnit;
  @override
  MeasurementValue? get height;
  @override
  ActivityLevel? get activityLevel;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
