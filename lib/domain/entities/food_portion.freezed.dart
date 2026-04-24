// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_portion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FoodPortion {
  String get id => throw _privateConstructorUsedError;
  String get foodId => throw _privateConstructorUsedError;
  FoodQuantityUnit get unit => throw _privateConstructorUsedError;
  String get label => throw _privateConstructorUsedError;
  double get referenceAmount => throw _privateConstructorUsedError;
  double? get canonicalGrams => throw _privateConstructorUsedError;
  double? get canonicalMilliliters => throw _privateConstructorUsedError;
  int get sortOrder => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of FoodPortion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodPortionCopyWith<FoodPortion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodPortionCopyWith<$Res> {
  factory $FoodPortionCopyWith(
    FoodPortion value,
    $Res Function(FoodPortion) then,
  ) = _$FoodPortionCopyWithImpl<$Res, FoodPortion>;
  @useResult
  $Res call({
    String id,
    String foodId,
    FoodQuantityUnit unit,
    String label,
    double referenceAmount,
    double? canonicalGrams,
    double? canonicalMilliliters,
    int sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$FoodPortionCopyWithImpl<$Res, $Val extends FoodPortion>
    implements $FoodPortionCopyWith<$Res> {
  _$FoodPortionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodPortion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodId = null,
    Object? unit = null,
    Object? label = null,
    Object? referenceAmount = null,
    Object? canonicalGrams = freezed,
    Object? canonicalMilliliters = freezed,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            foodId: null == foodId
                ? _value.foodId
                : foodId // ignore: cast_nullable_to_non_nullable
                      as String,
            unit: null == unit
                ? _value.unit
                : unit // ignore: cast_nullable_to_non_nullable
                      as FoodQuantityUnit,
            label: null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                      as String,
            referenceAmount: null == referenceAmount
                ? _value.referenceAmount
                : referenceAmount // ignore: cast_nullable_to_non_nullable
                      as double,
            canonicalGrams: freezed == canonicalGrams
                ? _value.canonicalGrams
                : canonicalGrams // ignore: cast_nullable_to_non_nullable
                      as double?,
            canonicalMilliliters: freezed == canonicalMilliliters
                ? _value.canonicalMilliliters
                : canonicalMilliliters // ignore: cast_nullable_to_non_nullable
                      as double?,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
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
}

/// @nodoc
abstract class _$$FoodPortionImplCopyWith<$Res>
    implements $FoodPortionCopyWith<$Res> {
  factory _$$FoodPortionImplCopyWith(
    _$FoodPortionImpl value,
    $Res Function(_$FoodPortionImpl) then,
  ) = __$$FoodPortionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String foodId,
    FoodQuantityUnit unit,
    String label,
    double referenceAmount,
    double? canonicalGrams,
    double? canonicalMilliliters,
    int sortOrder,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$FoodPortionImplCopyWithImpl<$Res>
    extends _$FoodPortionCopyWithImpl<$Res, _$FoodPortionImpl>
    implements _$$FoodPortionImplCopyWith<$Res> {
  __$$FoodPortionImplCopyWithImpl(
    _$FoodPortionImpl _value,
    $Res Function(_$FoodPortionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodPortion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodId = null,
    Object? unit = null,
    Object? label = null,
    Object? referenceAmount = null,
    Object? canonicalGrams = freezed,
    Object? canonicalMilliliters = freezed,
    Object? sortOrder = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$FoodPortionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        foodId: null == foodId
            ? _value.foodId
            : foodId // ignore: cast_nullable_to_non_nullable
                  as String,
        unit: null == unit
            ? _value.unit
            : unit // ignore: cast_nullable_to_non_nullable
                  as FoodQuantityUnit,
        label: null == label
            ? _value.label
            : label // ignore: cast_nullable_to_non_nullable
                  as String,
        referenceAmount: null == referenceAmount
            ? _value.referenceAmount
            : referenceAmount // ignore: cast_nullable_to_non_nullable
                  as double,
        canonicalGrams: freezed == canonicalGrams
            ? _value.canonicalGrams
            : canonicalGrams // ignore: cast_nullable_to_non_nullable
                  as double?,
        canonicalMilliliters: freezed == canonicalMilliliters
            ? _value.canonicalMilliliters
            : canonicalMilliliters // ignore: cast_nullable_to_non_nullable
                  as double?,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
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

class _$FoodPortionImpl implements _FoodPortion {
  const _$FoodPortionImpl({
    required this.id,
    required this.foodId,
    required this.unit,
    required this.label,
    required this.referenceAmount,
    this.canonicalGrams,
    this.canonicalMilliliters,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final String foodId;
  @override
  final FoodQuantityUnit unit;
  @override
  final String label;
  @override
  final double referenceAmount;
  @override
  final double? canonicalGrams;
  @override
  final double? canonicalMilliliters;
  @override
  final int sortOrder;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'FoodPortion(id: $id, foodId: $foodId, unit: $unit, label: $label, referenceAmount: $referenceAmount, canonicalGrams: $canonicalGrams, canonicalMilliliters: $canonicalMilliliters, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodPortionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.foodId, foodId) || other.foodId == foodId) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.referenceAmount, referenceAmount) ||
                other.referenceAmount == referenceAmount) &&
            (identical(other.canonicalGrams, canonicalGrams) ||
                other.canonicalGrams == canonicalGrams) &&
            (identical(other.canonicalMilliliters, canonicalMilliliters) ||
                other.canonicalMilliliters == canonicalMilliliters) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    foodId,
    unit,
    label,
    referenceAmount,
    canonicalGrams,
    canonicalMilliliters,
    sortOrder,
    createdAt,
    updatedAt,
  );

  /// Create a copy of FoodPortion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodPortionImplCopyWith<_$FoodPortionImpl> get copyWith =>
      __$$FoodPortionImplCopyWithImpl<_$FoodPortionImpl>(this, _$identity);
}

abstract class _FoodPortion implements FoodPortion {
  const factory _FoodPortion({
    required final String id,
    required final String foodId,
    required final FoodQuantityUnit unit,
    required final String label,
    required final double referenceAmount,
    final double? canonicalGrams,
    final double? canonicalMilliliters,
    required final int sortOrder,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$FoodPortionImpl;

  @override
  String get id;
  @override
  String get foodId;
  @override
  FoodQuantityUnit get unit;
  @override
  String get label;
  @override
  double get referenceAmount;
  @override
  double? get canonicalGrams;
  @override
  double? get canonicalMilliliters;
  @override
  int get sortOrder;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of FoodPortion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodPortionImplCopyWith<_$FoodPortionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
