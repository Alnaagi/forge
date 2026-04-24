// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quantity_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$QuantityValue {
  double get originalValue => throw _privateConstructorUsedError;
  FoodQuantityUnit get originalUnit => throw _privateConstructorUsedError;
  double? get canonicalGrams => throw _privateConstructorUsedError;
  double? get canonicalMilliliters => throw _privateConstructorUsedError;

  /// Create a copy of QuantityValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QuantityValueCopyWith<QuantityValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuantityValueCopyWith<$Res> {
  factory $QuantityValueCopyWith(
    QuantityValue value,
    $Res Function(QuantityValue) then,
  ) = _$QuantityValueCopyWithImpl<$Res, QuantityValue>;
  @useResult
  $Res call({
    double originalValue,
    FoodQuantityUnit originalUnit,
    double? canonicalGrams,
    double? canonicalMilliliters,
  });
}

/// @nodoc
class _$QuantityValueCopyWithImpl<$Res, $Val extends QuantityValue>
    implements $QuantityValueCopyWith<$Res> {
  _$QuantityValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QuantityValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalValue = null,
    Object? originalUnit = null,
    Object? canonicalGrams = freezed,
    Object? canonicalMilliliters = freezed,
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
                      as FoodQuantityUnit,
            canonicalGrams: freezed == canonicalGrams
                ? _value.canonicalGrams
                : canonicalGrams // ignore: cast_nullable_to_non_nullable
                      as double?,
            canonicalMilliliters: freezed == canonicalMilliliters
                ? _value.canonicalMilliliters
                : canonicalMilliliters // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QuantityValueImplCopyWith<$Res>
    implements $QuantityValueCopyWith<$Res> {
  factory _$$QuantityValueImplCopyWith(
    _$QuantityValueImpl value,
    $Res Function(_$QuantityValueImpl) then,
  ) = __$$QuantityValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double originalValue,
    FoodQuantityUnit originalUnit,
    double? canonicalGrams,
    double? canonicalMilliliters,
  });
}

/// @nodoc
class __$$QuantityValueImplCopyWithImpl<$Res>
    extends _$QuantityValueCopyWithImpl<$Res, _$QuantityValueImpl>
    implements _$$QuantityValueImplCopyWith<$Res> {
  __$$QuantityValueImplCopyWithImpl(
    _$QuantityValueImpl _value,
    $Res Function(_$QuantityValueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QuantityValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalValue = null,
    Object? originalUnit = null,
    Object? canonicalGrams = freezed,
    Object? canonicalMilliliters = freezed,
  }) {
    return _then(
      _$QuantityValueImpl(
        originalValue: null == originalValue
            ? _value.originalValue
            : originalValue // ignore: cast_nullable_to_non_nullable
                  as double,
        originalUnit: null == originalUnit
            ? _value.originalUnit
            : originalUnit // ignore: cast_nullable_to_non_nullable
                  as FoodQuantityUnit,
        canonicalGrams: freezed == canonicalGrams
            ? _value.canonicalGrams
            : canonicalGrams // ignore: cast_nullable_to_non_nullable
                  as double?,
        canonicalMilliliters: freezed == canonicalMilliliters
            ? _value.canonicalMilliliters
            : canonicalMilliliters // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc

class _$QuantityValueImpl implements _QuantityValue {
  const _$QuantityValueImpl({
    required this.originalValue,
    required this.originalUnit,
    this.canonicalGrams,
    this.canonicalMilliliters,
  }) : assert(originalValue >= 0, 'Quantity cannot be negative.'),
       assert(
         canonicalGrams == null || canonicalGrams >= 0,
         'Canonical grams cannot be negative.',
       ),
       assert(
         canonicalMilliliters == null || canonicalMilliliters >= 0,
         'Canonical milliliters cannot be negative.',
       );

  @override
  final double originalValue;
  @override
  final FoodQuantityUnit originalUnit;
  @override
  final double? canonicalGrams;
  @override
  final double? canonicalMilliliters;

  @override
  String toString() {
    return 'QuantityValue(originalValue: $originalValue, originalUnit: $originalUnit, canonicalGrams: $canonicalGrams, canonicalMilliliters: $canonicalMilliliters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QuantityValueImpl &&
            (identical(other.originalValue, originalValue) ||
                other.originalValue == originalValue) &&
            (identical(other.originalUnit, originalUnit) ||
                other.originalUnit == originalUnit) &&
            (identical(other.canonicalGrams, canonicalGrams) ||
                other.canonicalGrams == canonicalGrams) &&
            (identical(other.canonicalMilliliters, canonicalMilliliters) ||
                other.canonicalMilliliters == canonicalMilliliters));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    originalValue,
    originalUnit,
    canonicalGrams,
    canonicalMilliliters,
  );

  /// Create a copy of QuantityValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QuantityValueImplCopyWith<_$QuantityValueImpl> get copyWith =>
      __$$QuantityValueImplCopyWithImpl<_$QuantityValueImpl>(this, _$identity);
}

abstract class _QuantityValue implements QuantityValue {
  const factory _QuantityValue({
    required final double originalValue,
    required final FoodQuantityUnit originalUnit,
    final double? canonicalGrams,
    final double? canonicalMilliliters,
  }) = _$QuantityValueImpl;

  @override
  double get originalValue;
  @override
  FoodQuantityUnit get originalUnit;
  @override
  double? get canonicalGrams;
  @override
  double? get canonicalMilliliters;

  /// Create a copy of QuantityValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QuantityValueImplCopyWith<_$QuantityValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
