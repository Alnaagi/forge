// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weight_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WeightValue {
  double get originalValue => throw _privateConstructorUsedError;
  WeightUnit get originalUnit => throw _privateConstructorUsedError;
  double get canonicalKilograms => throw _privateConstructorUsedError;

  /// Create a copy of WeightValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeightValueCopyWith<WeightValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeightValueCopyWith<$Res> {
  factory $WeightValueCopyWith(
    WeightValue value,
    $Res Function(WeightValue) then,
  ) = _$WeightValueCopyWithImpl<$Res, WeightValue>;
  @useResult
  $Res call({
    double originalValue,
    WeightUnit originalUnit,
    double canonicalKilograms,
  });
}

/// @nodoc
class _$WeightValueCopyWithImpl<$Res, $Val extends WeightValue>
    implements $WeightValueCopyWith<$Res> {
  _$WeightValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeightValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalValue = null,
    Object? originalUnit = null,
    Object? canonicalKilograms = null,
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
                      as WeightUnit,
            canonicalKilograms: null == canonicalKilograms
                ? _value.canonicalKilograms
                : canonicalKilograms // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WeightValueImplCopyWith<$Res>
    implements $WeightValueCopyWith<$Res> {
  factory _$$WeightValueImplCopyWith(
    _$WeightValueImpl value,
    $Res Function(_$WeightValueImpl) then,
  ) = __$$WeightValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double originalValue,
    WeightUnit originalUnit,
    double canonicalKilograms,
  });
}

/// @nodoc
class __$$WeightValueImplCopyWithImpl<$Res>
    extends _$WeightValueCopyWithImpl<$Res, _$WeightValueImpl>
    implements _$$WeightValueImplCopyWith<$Res> {
  __$$WeightValueImplCopyWithImpl(
    _$WeightValueImpl _value,
    $Res Function(_$WeightValueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WeightValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalValue = null,
    Object? originalUnit = null,
    Object? canonicalKilograms = null,
  }) {
    return _then(
      _$WeightValueImpl(
        originalValue: null == originalValue
            ? _value.originalValue
            : originalValue // ignore: cast_nullable_to_non_nullable
                  as double,
        originalUnit: null == originalUnit
            ? _value.originalUnit
            : originalUnit // ignore: cast_nullable_to_non_nullable
                  as WeightUnit,
        canonicalKilograms: null == canonicalKilograms
            ? _value.canonicalKilograms
            : canonicalKilograms // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$WeightValueImpl implements _WeightValue {
  const _$WeightValueImpl({
    required this.originalValue,
    required this.originalUnit,
    required this.canonicalKilograms,
  }) : assert(originalValue >= 0, 'Weight cannot be negative.'),
       assert(canonicalKilograms >= 0, 'Canonical weight cannot be negative.');

  @override
  final double originalValue;
  @override
  final WeightUnit originalUnit;
  @override
  final double canonicalKilograms;

  @override
  String toString() {
    return 'WeightValue(originalValue: $originalValue, originalUnit: $originalUnit, canonicalKilograms: $canonicalKilograms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeightValueImpl &&
            (identical(other.originalValue, originalValue) ||
                other.originalValue == originalValue) &&
            (identical(other.originalUnit, originalUnit) ||
                other.originalUnit == originalUnit) &&
            (identical(other.canonicalKilograms, canonicalKilograms) ||
                other.canonicalKilograms == canonicalKilograms));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, originalValue, originalUnit, canonicalKilograms);

  /// Create a copy of WeightValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeightValueImplCopyWith<_$WeightValueImpl> get copyWith =>
      __$$WeightValueImplCopyWithImpl<_$WeightValueImpl>(this, _$identity);
}

abstract class _WeightValue implements WeightValue {
  const factory _WeightValue({
    required final double originalValue,
    required final WeightUnit originalUnit,
    required final double canonicalKilograms,
  }) = _$WeightValueImpl;

  @override
  double get originalValue;
  @override
  WeightUnit get originalUnit;
  @override
  double get canonicalKilograms;

  /// Create a copy of WeightValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeightValueImplCopyWith<_$WeightValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
