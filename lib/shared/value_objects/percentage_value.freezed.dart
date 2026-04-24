// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'percentage_value.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PercentageValue {
  double get value => throw _privateConstructorUsedError;

  /// Create a copy of PercentageValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PercentageValueCopyWith<PercentageValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PercentageValueCopyWith<$Res> {
  factory $PercentageValueCopyWith(
    PercentageValue value,
    $Res Function(PercentageValue) then,
  ) = _$PercentageValueCopyWithImpl<$Res, PercentageValue>;
  @useResult
  $Res call({double value});
}

/// @nodoc
class _$PercentageValueCopyWithImpl<$Res, $Val extends PercentageValue>
    implements $PercentageValueCopyWith<$Res> {
  _$PercentageValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PercentageValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PercentageValueImplCopyWith<$Res>
    implements $PercentageValueCopyWith<$Res> {
  factory _$$PercentageValueImplCopyWith(
    _$PercentageValueImpl value,
    $Res Function(_$PercentageValueImpl) then,
  ) = __$$PercentageValueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double value});
}

/// @nodoc
class __$$PercentageValueImplCopyWithImpl<$Res>
    extends _$PercentageValueCopyWithImpl<$Res, _$PercentageValueImpl>
    implements _$$PercentageValueImplCopyWith<$Res> {
  __$$PercentageValueImplCopyWithImpl(
    _$PercentageValueImpl _value,
    $Res Function(_$PercentageValueImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PercentageValue
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$PercentageValueImpl(
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$PercentageValueImpl implements _PercentageValue {
  const _$PercentageValueImpl({required this.value})
    : assert(
        value >= 0 && value <= 100,
        'Percentage must be between 0 and 100.',
      );

  @override
  final double value;

  @override
  String toString() {
    return 'PercentageValue(value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PercentageValueImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of PercentageValue
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PercentageValueImplCopyWith<_$PercentageValueImpl> get copyWith =>
      __$$PercentageValueImplCopyWithImpl<_$PercentageValueImpl>(
        this,
        _$identity,
      );
}

abstract class _PercentageValue implements PercentageValue {
  const factory _PercentageValue({required final double value}) =
      _$PercentageValueImpl;

  @override
  double get value;

  /// Create a copy of PercentageValue
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PercentageValueImplCopyWith<_$PercentageValueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
