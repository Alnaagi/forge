// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'volume_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$VolumeValue {
  double get originalValue => throw _privateConstructorUsedError;
  VolumeUnit get originalUnit => throw _privateConstructorUsedError;
  double get canonicalMilliliters => throw _privateConstructorUsedError;

  /// Create a copy of VolumeValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VolumeValueCopyWith<VolumeValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VolumeValueCopyWith<$Res> {
  factory $VolumeValueCopyWith(
    VolumeValue value,
    $Res Function(VolumeValue) then,
  ) = _$VolumeValueCopyWithImpl<$Res, VolumeValue>;
  @useResult
  $Res call({
    double originalValue,
    VolumeUnit originalUnit,
    double canonicalMilliliters,
  });
}

/// @nodoc
class _$VolumeValueCopyWithImpl<$Res, $Val extends VolumeValue>
    implements $VolumeValueCopyWith<$Res> {
  _$VolumeValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VolumeValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalValue = null,
    Object? originalUnit = null,
    Object? canonicalMilliliters = null,
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
                      as VolumeUnit,
            canonicalMilliliters: null == canonicalMilliliters
                ? _value.canonicalMilliliters
                : canonicalMilliliters // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VolumeValueImplCopyWith<$Res>
    implements $VolumeValueCopyWith<$Res> {
  factory _$$VolumeValueImplCopyWith(
    _$VolumeValueImpl value,
    $Res Function(_$VolumeValueImpl) then,
  ) = __$$VolumeValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double originalValue,
    VolumeUnit originalUnit,
    double canonicalMilliliters,
  });
}

/// @nodoc
class __$$VolumeValueImplCopyWithImpl<$Res>
    extends _$VolumeValueCopyWithImpl<$Res, _$VolumeValueImpl>
    implements _$$VolumeValueImplCopyWith<$Res> {
  __$$VolumeValueImplCopyWithImpl(
    _$VolumeValueImpl _value,
    $Res Function(_$VolumeValueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VolumeValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? originalValue = null,
    Object? originalUnit = null,
    Object? canonicalMilliliters = null,
  }) {
    return _then(
      _$VolumeValueImpl(
        originalValue: null == originalValue
            ? _value.originalValue
            : originalValue // ignore: cast_nullable_to_non_nullable
                  as double,
        originalUnit: null == originalUnit
            ? _value.originalUnit
            : originalUnit // ignore: cast_nullable_to_non_nullable
                  as VolumeUnit,
        canonicalMilliliters: null == canonicalMilliliters
            ? _value.canonicalMilliliters
            : canonicalMilliliters // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$VolumeValueImpl implements _VolumeValue {
  const _$VolumeValueImpl({
    required this.originalValue,
    required this.originalUnit,
    required this.canonicalMilliliters,
  }) : assert(originalValue >= 0, 'Volume cannot be negative.'),
       assert(
         canonicalMilliliters >= 0,
         'Canonical volume cannot be negative.',
       );

  @override
  final double originalValue;
  @override
  final VolumeUnit originalUnit;
  @override
  final double canonicalMilliliters;

  @override
  String toString() {
    return 'VolumeValue(originalValue: $originalValue, originalUnit: $originalUnit, canonicalMilliliters: $canonicalMilliliters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VolumeValueImpl &&
            (identical(other.originalValue, originalValue) ||
                other.originalValue == originalValue) &&
            (identical(other.originalUnit, originalUnit) ||
                other.originalUnit == originalUnit) &&
            (identical(other.canonicalMilliliters, canonicalMilliliters) ||
                other.canonicalMilliliters == canonicalMilliliters));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    originalValue,
    originalUnit,
    canonicalMilliliters,
  );

  /// Create a copy of VolumeValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VolumeValueImplCopyWith<_$VolumeValueImpl> get copyWith =>
      __$$VolumeValueImplCopyWithImpl<_$VolumeValueImpl>(this, _$identity);
}

abstract class _VolumeValue implements VolumeValue {
  const factory _VolumeValue({
    required final double originalValue,
    required final VolumeUnit originalUnit,
    required final double canonicalMilliliters,
  }) = _$VolumeValueImpl;

  @override
  double get originalValue;
  @override
  VolumeUnit get originalUnit;
  @override
  double get canonicalMilliliters;

  /// Create a copy of VolumeValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VolumeValueImplCopyWith<_$VolumeValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
