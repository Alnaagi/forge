// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Food {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get brandName => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  int get caloriesPer100g => throw _privateConstructorUsedError;
  double get proteinPer100g => throw _privateConstructorUsedError;
  double get carbsPer100g => throw _privateConstructorUsedError;
  double get fatPer100g => throw _privateConstructorUsedError;
  SyncSource get source => throw _privateConstructorUsedError;
  bool get isUserEdited => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodCopyWith<Food> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodCopyWith<$Res> {
  factory $FoodCopyWith(Food value, $Res Function(Food) then) =
      _$FoodCopyWithImpl<$Res, Food>;
  @useResult
  $Res call({
    String id,
    String name,
    String? brandName,
    String? barcode,
    int caloriesPer100g,
    double proteinPer100g,
    double carbsPer100g,
    double fatPer100g,
    SyncSource source,
    bool isUserEdited,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$FoodCopyWithImpl<$Res, $Val extends Food>
    implements $FoodCopyWith<$Res> {
  _$FoodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brandName = freezed,
    Object? barcode = freezed,
    Object? caloriesPer100g = null,
    Object? proteinPer100g = null,
    Object? carbsPer100g = null,
    Object? fatPer100g = null,
    Object? source = null,
    Object? isUserEdited = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            brandName: freezed == brandName
                ? _value.brandName
                : brandName // ignore: cast_nullable_to_non_nullable
                      as String?,
            barcode: freezed == barcode
                ? _value.barcode
                : barcode // ignore: cast_nullable_to_non_nullable
                      as String?,
            caloriesPer100g: null == caloriesPer100g
                ? _value.caloriesPer100g
                : caloriesPer100g // ignore: cast_nullable_to_non_nullable
                      as int,
            proteinPer100g: null == proteinPer100g
                ? _value.proteinPer100g
                : proteinPer100g // ignore: cast_nullable_to_non_nullable
                      as double,
            carbsPer100g: null == carbsPer100g
                ? _value.carbsPer100g
                : carbsPer100g // ignore: cast_nullable_to_non_nullable
                      as double,
            fatPer100g: null == fatPer100g
                ? _value.fatPer100g
                : fatPer100g // ignore: cast_nullable_to_non_nullable
                      as double,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as SyncSource,
            isUserEdited: null == isUserEdited
                ? _value.isUserEdited
                : isUserEdited // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$FoodImplCopyWith<$Res> implements $FoodCopyWith<$Res> {
  factory _$$FoodImplCopyWith(
    _$FoodImpl value,
    $Res Function(_$FoodImpl) then,
  ) = __$$FoodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? brandName,
    String? barcode,
    int caloriesPer100g,
    double proteinPer100g,
    double carbsPer100g,
    double fatPer100g,
    SyncSource source,
    bool isUserEdited,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$FoodImplCopyWithImpl<$Res>
    extends _$FoodCopyWithImpl<$Res, _$FoodImpl>
    implements _$$FoodImplCopyWith<$Res> {
  __$$FoodImplCopyWithImpl(_$FoodImpl _value, $Res Function(_$FoodImpl) _then)
    : super(_value, _then);

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? brandName = freezed,
    Object? barcode = freezed,
    Object? caloriesPer100g = null,
    Object? proteinPer100g = null,
    Object? carbsPer100g = null,
    Object? fatPer100g = null,
    Object? source = null,
    Object? isUserEdited = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$FoodImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        brandName: freezed == brandName
            ? _value.brandName
            : brandName // ignore: cast_nullable_to_non_nullable
                  as String?,
        barcode: freezed == barcode
            ? _value.barcode
            : barcode // ignore: cast_nullable_to_non_nullable
                  as String?,
        caloriesPer100g: null == caloriesPer100g
            ? _value.caloriesPer100g
            : caloriesPer100g // ignore: cast_nullable_to_non_nullable
                  as int,
        proteinPer100g: null == proteinPer100g
            ? _value.proteinPer100g
            : proteinPer100g // ignore: cast_nullable_to_non_nullable
                  as double,
        carbsPer100g: null == carbsPer100g
            ? _value.carbsPer100g
            : carbsPer100g // ignore: cast_nullable_to_non_nullable
                  as double,
        fatPer100g: null == fatPer100g
            ? _value.fatPer100g
            : fatPer100g // ignore: cast_nullable_to_non_nullable
                  as double,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as SyncSource,
        isUserEdited: null == isUserEdited
            ? _value.isUserEdited
            : isUserEdited // ignore: cast_nullable_to_non_nullable
                  as bool,
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

class _$FoodImpl implements _Food {
  const _$FoodImpl({
    required this.id,
    required this.name,
    this.brandName,
    this.barcode,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
    required this.source,
    this.isUserEdited = false,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final String? brandName;
  @override
  final String? barcode;
  @override
  final int caloriesPer100g;
  @override
  final double proteinPer100g;
  @override
  final double carbsPer100g;
  @override
  final double fatPer100g;
  @override
  final SyncSource source;
  @override
  @JsonKey()
  final bool isUserEdited;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Food(id: $id, name: $name, brandName: $brandName, barcode: $barcode, caloriesPer100g: $caloriesPer100g, proteinPer100g: $proteinPer100g, carbsPer100g: $carbsPer100g, fatPer100g: $fatPer100g, source: $source, isUserEdited: $isUserEdited, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.brandName, brandName) ||
                other.brandName == brandName) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.caloriesPer100g, caloriesPer100g) ||
                other.caloriesPer100g == caloriesPer100g) &&
            (identical(other.proteinPer100g, proteinPer100g) ||
                other.proteinPer100g == proteinPer100g) &&
            (identical(other.carbsPer100g, carbsPer100g) ||
                other.carbsPer100g == carbsPer100g) &&
            (identical(other.fatPer100g, fatPer100g) ||
                other.fatPer100g == fatPer100g) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.isUserEdited, isUserEdited) ||
                other.isUserEdited == isUserEdited) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    brandName,
    barcode,
    caloriesPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
    source,
    isUserEdited,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodImplCopyWith<_$FoodImpl> get copyWith =>
      __$$FoodImplCopyWithImpl<_$FoodImpl>(this, _$identity);
}

abstract class _Food implements Food {
  const factory _Food({
    required final String id,
    required final String name,
    final String? brandName,
    final String? barcode,
    required final int caloriesPer100g,
    required final double proteinPer100g,
    required final double carbsPer100g,
    required final double fatPer100g,
    required final SyncSource source,
    final bool isUserEdited,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$FoodImpl;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get brandName;
  @override
  String? get barcode;
  @override
  int get caloriesPer100g;
  @override
  double get proteinPer100g;
  @override
  double get carbsPer100g;
  @override
  double get fatPer100g;
  @override
  SyncSource get source;
  @override
  bool get isUserEdited;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodImplCopyWith<_$FoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
