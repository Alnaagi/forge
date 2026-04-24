// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MealEntry {
  String get id => throw _privateConstructorUsedError;
  String get foodId => throw _privateConstructorUsedError;
  MealType get mealType => throw _privateConstructorUsedError;
  QuantityValue get quantity => throw _privateConstructorUsedError;
  DateTime get loggedAt => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of MealEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealEntryCopyWith<MealEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealEntryCopyWith<$Res> {
  factory $MealEntryCopyWith(MealEntry value, $Res Function(MealEntry) then) =
      _$MealEntryCopyWithImpl<$Res, MealEntry>;
  @useResult
  $Res call({
    String id,
    String foodId,
    MealType mealType,
    QuantityValue quantity,
    DateTime loggedAt,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });

  $QuantityValueCopyWith<$Res> get quantity;
}

/// @nodoc
class _$MealEntryCopyWithImpl<$Res, $Val extends MealEntry>
    implements $MealEntryCopyWith<$Res> {
  _$MealEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodId = null,
    Object? mealType = null,
    Object? quantity = null,
    Object? loggedAt = null,
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
            foodId: null == foodId
                ? _value.foodId
                : foodId // ignore: cast_nullable_to_non_nullable
                      as String,
            mealType: null == mealType
                ? _value.mealType
                : mealType // ignore: cast_nullable_to_non_nullable
                      as MealType,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as QuantityValue,
            loggedAt: null == loggedAt
                ? _value.loggedAt
                : loggedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
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

  /// Create a copy of MealEntry
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
abstract class _$$MealEntryImplCopyWith<$Res>
    implements $MealEntryCopyWith<$Res> {
  factory _$$MealEntryImplCopyWith(
    _$MealEntryImpl value,
    $Res Function(_$MealEntryImpl) then,
  ) = __$$MealEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String foodId,
    MealType mealType,
    QuantityValue quantity,
    DateTime loggedAt,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });

  @override
  $QuantityValueCopyWith<$Res> get quantity;
}

/// @nodoc
class __$$MealEntryImplCopyWithImpl<$Res>
    extends _$MealEntryCopyWithImpl<$Res, _$MealEntryImpl>
    implements _$$MealEntryImplCopyWith<$Res> {
  __$$MealEntryImplCopyWithImpl(
    _$MealEntryImpl _value,
    $Res Function(_$MealEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MealEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodId = null,
    Object? mealType = null,
    Object? quantity = null,
    Object? loggedAt = null,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$MealEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        foodId: null == foodId
            ? _value.foodId
            : foodId // ignore: cast_nullable_to_non_nullable
                  as String,
        mealType: null == mealType
            ? _value.mealType
            : mealType // ignore: cast_nullable_to_non_nullable
                  as MealType,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as QuantityValue,
        loggedAt: null == loggedAt
            ? _value.loggedAt
            : loggedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
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

class _$MealEntryImpl implements _MealEntry {
  const _$MealEntryImpl({
    required this.id,
    required this.foodId,
    required this.mealType,
    required this.quantity,
    required this.loggedAt,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final String foodId;
  @override
  final MealType mealType;
  @override
  final QuantityValue quantity;
  @override
  final DateTime loggedAt;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'MealEntry(id: $id, foodId: $foodId, mealType: $mealType, quantity: $quantity, loggedAt: $loggedAt, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.foodId, foodId) || other.foodId == foodId) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.loggedAt, loggedAt) ||
                other.loggedAt == loggedAt) &&
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
    foodId,
    mealType,
    quantity,
    loggedAt,
    notes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of MealEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealEntryImplCopyWith<_$MealEntryImpl> get copyWith =>
      __$$MealEntryImplCopyWithImpl<_$MealEntryImpl>(this, _$identity);
}

abstract class _MealEntry implements MealEntry {
  const factory _MealEntry({
    required final String id,
    required final String foodId,
    required final MealType mealType,
    required final QuantityValue quantity,
    required final DateTime loggedAt,
    final String? notes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$MealEntryImpl;

  @override
  String get id;
  @override
  String get foodId;
  @override
  MealType get mealType;
  @override
  QuantityValue get quantity;
  @override
  DateTime get loggedAt;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of MealEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealEntryImplCopyWith<_$MealEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
