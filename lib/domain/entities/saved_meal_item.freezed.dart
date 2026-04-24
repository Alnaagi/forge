// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_meal_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SavedMealItem {
  String get id => throw _privateConstructorUsedError;
  String get savedMealId => throw _privateConstructorUsedError;
  String get foodId => throw _privateConstructorUsedError;
  QuantityValue get quantity => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of SavedMealItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedMealItemCopyWith<SavedMealItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedMealItemCopyWith<$Res> {
  factory $SavedMealItemCopyWith(
    SavedMealItem value,
    $Res Function(SavedMealItem) then,
  ) = _$SavedMealItemCopyWithImpl<$Res, SavedMealItem>;
  @useResult
  $Res call({
    String id,
    String savedMealId,
    String foodId,
    QuantityValue quantity,
    int orderIndex,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });

  $QuantityValueCopyWith<$Res> get quantity;
}

/// @nodoc
class _$SavedMealItemCopyWithImpl<$Res, $Val extends SavedMealItem>
    implements $SavedMealItemCopyWith<$Res> {
  _$SavedMealItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedMealItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? savedMealId = null,
    Object? foodId = null,
    Object? quantity = null,
    Object? orderIndex = null,
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
            savedMealId: null == savedMealId
                ? _value.savedMealId
                : savedMealId // ignore: cast_nullable_to_non_nullable
                      as String,
            foodId: null == foodId
                ? _value.foodId
                : foodId // ignore: cast_nullable_to_non_nullable
                      as String,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as QuantityValue,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
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

  /// Create a copy of SavedMealItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QuantityValueCopyWith<$Res> get quantity {
    return $QuantityValueCopyWith<$Res>(_value.quantity, (value) {
      return _then(_value.copyWith(quantity: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SavedMealItemImplCopyWith<$Res>
    implements $SavedMealItemCopyWith<$Res> {
  factory _$$SavedMealItemImplCopyWith(
    _$SavedMealItemImpl value,
    $Res Function(_$SavedMealItemImpl) then,
  ) = __$$SavedMealItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String savedMealId,
    String foodId,
    QuantityValue quantity,
    int orderIndex,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });

  @override
  $QuantityValueCopyWith<$Res> get quantity;
}

/// @nodoc
class __$$SavedMealItemImplCopyWithImpl<$Res>
    extends _$SavedMealItemCopyWithImpl<$Res, _$SavedMealItemImpl>
    implements _$$SavedMealItemImplCopyWith<$Res> {
  __$$SavedMealItemImplCopyWithImpl(
    _$SavedMealItemImpl _value,
    $Res Function(_$SavedMealItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedMealItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? savedMealId = null,
    Object? foodId = null,
    Object? quantity = null,
    Object? orderIndex = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$SavedMealItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        savedMealId: null == savedMealId
            ? _value.savedMealId
            : savedMealId // ignore: cast_nullable_to_non_nullable
                  as String,
        foodId: null == foodId
            ? _value.foodId
            : foodId // ignore: cast_nullable_to_non_nullable
                  as String,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as QuantityValue,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
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

class _$SavedMealItemImpl implements _SavedMealItem {
  const _$SavedMealItemImpl({
    required this.id,
    required this.savedMealId,
    required this.foodId,
    required this.quantity,
    required this.orderIndex,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final String savedMealId;
  @override
  final String foodId;
  @override
  final QuantityValue quantity;
  @override
  final int orderIndex;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SavedMealItem(id: $id, savedMealId: $savedMealId, foodId: $foodId, quantity: $quantity, orderIndex: $orderIndex, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedMealItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.savedMealId, savedMealId) ||
                other.savedMealId == savedMealId) &&
            (identical(other.foodId, foodId) || other.foodId == foodId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
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
    savedMealId,
    foodId,
    quantity,
    orderIndex,
    notes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of SavedMealItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedMealItemImplCopyWith<_$SavedMealItemImpl> get copyWith =>
      __$$SavedMealItemImplCopyWithImpl<_$SavedMealItemImpl>(this, _$identity);
}

abstract class _SavedMealItem implements SavedMealItem {
  const factory _SavedMealItem({
    required final String id,
    required final String savedMealId,
    required final String foodId,
    required final QuantityValue quantity,
    required final int orderIndex,
    final String? notes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$SavedMealItemImpl;

  @override
  String get id;
  @override
  String get savedMealId;
  @override
  String get foodId;
  @override
  QuantityValue get quantity;
  @override
  int get orderIndex;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of SavedMealItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedMealItemImplCopyWith<_$SavedMealItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
