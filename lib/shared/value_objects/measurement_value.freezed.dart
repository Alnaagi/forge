// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MeasurementValue {
  double get originalValue => throw _privateConstructorUsedError;
  BodyMetricUnit get originalUnit => throw _privateConstructorUsedError;
  double get canonicalCentimeters => throw _privateConstructorUsedError;

  /// Create a copy of MeasurementValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeasurementValueCopyWith<MeasurementValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeasurementValueCopyWith<$Res> {
  factory $MeasurementValueCopyWith(
    MeasurementValue value,
    $Res Function(MeasurementValue) then,
  ) = _$MeasurementValueCopyWithImpl<$Res, MeasurementValue>;
  @useResult
  $Res call({
    double originalValue,
    BodyMetricUnit originalUnit,
    double canonicalCentimeters,
  });
}

/// @nodoc
class _$MeasurementValueCopyWithImpl<$Res, $Val extends MeasurementValue>
    implements $MeasurementValueCopyWith<$Res> {
  _$MeasurementValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeasurementValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalValue = null,
    Object? originalUnit = null,
    Object? canonicalCentimeters = null,
  }) {
    return _then(
      _value.copyWith(
            originalValue: null == originalValue
                ? _value.originalValue
                : originalValue // ignore: cast_nullable_to_non_nullable
                      as double,
            originalUnit: null == originalUnit
                ? _value.originalUnit
                : originalUnit // ignore: cast_nullable_to_non_nullable
                      as BodyMetricUnit,
            canonicalCentimeters: null == canonicalCentimeters
                ? _value.canonicalCentimeters
                : canonicalCentimeters // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MeasurementValueImplCopyWith<$Res>
    implements $MeasurementValueCopyWith<$Res> {
  factory _$$MeasurementValueImplCopyWith(
    _$MeasurementValueImpl value,
    $Res Function(_$MeasurementValueImpl) then,
  ) = __$$MeasurementValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double originalValue,
    BodyMetricUnit originalUnit,
    double canonicalCentimeters,
  });
}

/// @nodoc
class __$$MeasurementValueImplCopyWithImpl<$Res>
    extends _$MeasurementValueCopyWithImpl<$Res, _$MeasurementValueImpl>
    implements _$$MeasurementValueImplCopyWith<$Res> {
  __$$MeasurementValueImplCopyWithImpl(
    _$MeasurementValueImpl _value,
    $Res Function(_$MeasurementValueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MeasurementValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalValue = null,
    Object? originalUnit = null,
    Object? canonicalCentimeters = null,
  }) {
    return _then(
      _$MeasurementValueImpl(
        originalValue: null == originalValue
            ? _value.originalValue
            : originalValue // ignore: cast_nullable_to_non_nullable
                  as double,
        originalUnit: null == originalUnit
            ? _value.originalUnit
            : originalUnit // ignore: cast_nullable_to_non_nullable
                  as BodyMetricUnit,
        canonicalCentimeters: null == canonicalCentimeters
            ? _value.canonicalCentimeters
            : canonicalCentimeters // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$MeasurementValueImpl implements _MeasurementValue {
  const _$MeasurementValueImpl({
    required this.originalValue,
    required this.originalUnit,
    required this.canonicalCentimeters,
  }) : assert(originalValue >= 0, 'Measurement cannot be negative.'),
       assert(
         canonicalCentimeters >= 0,
         'Canonical measurement cannot be negative.',
       );

  @override
  final double originalValue;
  @override
  final BodyMetricUnit originalUnit;
  @override
  final double canonicalCentimeters;

  @override
  String toString() {
    return 'MeasurementValue(originalValue: $originalValue, originalUnit: $originalUnit, canonicalCentimeters: $canonicalCentimeters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeasurementValueImpl &&
            (identical(other.originalValue, originalValue) ||
                other.originalValue == originalValue) &&
            (identical(other.originalUnit, originalUnit) ||
                other.originalUnit == originalUnit) &&
            (identical(other.canonicalCentimeters, canonicalCentimeters) ||
                other.canonicalCentimeters == canonicalCentimeters));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    originalValue,
    originalUnit,
    canonicalCentimeters,
  );

  /// Create a copy of MeasurementValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeasurementValueImplCopyWith<_$MeasurementValueImpl> get copyWith =>
      __$$MeasurementValueImplCopyWithImpl<_$MeasurementValueImpl>(
        this,
        _$identity,
      );
}

abstract class _MeasurementValue implements MeasurementValue {
  const factory _MeasurementValue({
    required final double originalValue,
    required final BodyMetricUnit originalUnit,
    required final double canonicalCentimeters,
  }) = _$MeasurementValueImpl;

  @override
  double get originalValue;
  @override
  BodyMetricUnit get originalUnit;
  @override
  double get canonicalCentimeters;

  /// Create a copy of MeasurementValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeasurementValueImplCopyWith<_$MeasurementValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
