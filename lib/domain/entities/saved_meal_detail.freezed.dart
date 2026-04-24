// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_meal_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SavedMealFoodItem {
  SavedMealItem get item => throw _privateConstructorUsedError;
  Food get food => throw _privateConstructorUsedError;
  NutritionMacros get macros => throw _privateConstructorUsedError;

  /// Create a copy of SavedMealFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedMealFoodItemCopyWith<SavedMealFoodItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedMealFoodItemCopyWith<$Res> {
  factory $SavedMealFoodItemCopyWith(
    SavedMealFoodItem value,
    $Res Function(SavedMealFoodItem) then,
  ) = _$SavedMealFoodItemCopyWithImpl<$Res, SavedMealFoodItem>;
  @useResult
  $Res call({SavedMealItem item, Food food, NutritionMacros macros});

  $SavedMealItemCopyWith<$Res> get item;
  $FoodCopyWith<$Res> get food;
  $NutritionMacrosCopyWith<$Res> get macros;
}

/// @nodoc
class _$SavedMealFoodItemCopyWithImpl<$Res, $Val extends SavedMealFoodItem>
    implements $SavedMealFoodItemCopyWith<$Res> {
  _$SavedMealFoodItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedMealFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? item = null, Object? food = null, Object? macros = null}) {
    return _then(
      _value.copyWith(
            item: null == item
                ? _value.item
                : item // ignore: cast_nullable_to_non_nullable
                      as SavedMealItem,
            food: null == food
                ? _value.food
                : food // ignore: cast_nullable_to_non_nullable
                      as Food,
            macros: null == macros
                ? _value.macros
                : macros // ignore: cast_nullable_to_non_nullable
                      as NutritionMacros,
          )
          as $Val,
    );
  }

  /// Create a copy of SavedMealFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SavedMealItemCopyWith<$Res> get item {
    return $SavedMealItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value) as $Val);
    });
  }

  /// Create a copy of SavedMealFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodCopyWith<$Res> get food {
    return $FoodCopyWith<$Res>(_value.food, (value) {
      return _then(_value.copyWith(food: value) as $Val);
    });
  }

  /// Create a copy of SavedMealFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionMacrosCopyWith<$Res> get macros {
    return $NutritionMacrosCopyWith<$Res>(_value.macros, (value) {
      return _then(_value.copyWith(macros: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SavedMealFoodItemImplCopyWith<$Res>
    implements $SavedMealFoodItemCopyWith<$Res> {
  factory _$$SavedMealFoodItemImplCopyWith(
    _$SavedMealFoodItemImpl value,
    $Res Function(_$SavedMealFoodItemImpl) then,
  ) = __$$SavedMealFoodItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SavedMealItem item, Food food, NutritionMacros macros});

  @override
  $SavedMealItemCopyWith<$Res> get item;
  @override
  $FoodCopyWith<$Res> get food;
  @override
  $NutritionMacrosCopyWith<$Res> get macros;
}

/// @nodoc
class __$$SavedMealFoodItemImplCopyWithImpl<$Res>
    extends _$SavedMealFoodItemCopyWithImpl<$Res, _$SavedMealFoodItemImpl>
    implements _$$SavedMealFoodItemImplCopyWith<$Res> {
  __$$SavedMealFoodItemImplCopyWithImpl(
    _$SavedMealFoodItemImpl _value,
    $Res Function(_$SavedMealFoodItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedMealFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? item = null, Object? food = null, Object? macros = null}) {
    return _then(
      _$SavedMealFoodItemImpl(
        item: null == item
            ? _value.item
            : item // ignore: cast_nullable_to_non_nullable
                  as SavedMealItem,
        food: null == food
            ? _value.food
            : food // ignore: cast_nullable_to_non_nullable
                  as Food,
        macros: null == macros
            ? _value.macros
            : macros // ignore: cast_nullable_to_non_nullable
                  as NutritionMacros,
      ),
    );
  }
}

/// @nodoc

class _$SavedMealFoodItemImpl implements _SavedMealFoodItem {
  const _$SavedMealFoodItemImpl({
    required this.item,
    required this.food,
    required this.macros,
  });

  @override
  final SavedMealItem item;
  @override
  final Food food;
  @override
  final NutritionMacros macros;

  @override
  String toString() {
    return 'SavedMealFoodItem(item: $item, food: $food, macros: $macros)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedMealFoodItemImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.food, food) || other.food == food) &&
            (identical(other.macros, macros) || other.macros == macros));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item, food, macros);

  /// Create a copy of SavedMealFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedMealFoodItemImplCopyWith<_$SavedMealFoodItemImpl> get copyWith =>
      __$$SavedMealFoodItemImplCopyWithImpl<_$SavedMealFoodItemImpl>(
        this,
        _$identity,
      );
}

abstract class _SavedMealFoodItem implements SavedMealFoodItem {
  const factory _SavedMealFoodItem({
    required final SavedMealItem item,
    required final Food food,
    required final NutritionMacros macros,
  }) = _$SavedMealFoodItemImpl;

  @override
  SavedMealItem get item;
  @override
  Food get food;
  @override
  NutritionMacros get macros;

  /// Create a copy of SavedMealFoodItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedMealFoodItemImplCopyWith<_$SavedMealFoodItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SavedMealDetail {
  SavedMeal get savedMeal => throw _privateConstructorUsedError;
  List<SavedMealFoodItem> get items => throw _privateConstructorUsedError;
  NutritionMacros get macros => throw _privateConstructorUsedError;

  /// Create a copy of SavedMealDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedMealDetailCopyWith<SavedMealDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedMealDetailCopyWith<$Res> {
  factory $SavedMealDetailCopyWith(
    SavedMealDetail value,
    $Res Function(SavedMealDetail) then,
  ) = _$SavedMealDetailCopyWithImpl<$Res, SavedMealDetail>;
  @useResult
  $Res call({
    SavedMeal savedMeal,
    List<SavedMealFoodItem> items,
    NutritionMacros macros,
  });

  $SavedMealCopyWith<$Res> get savedMeal;
  $NutritionMacrosCopyWith<$Res> get macros;
}

/// @nodoc
class _$SavedMealDetailCopyWithImpl<$Res, $Val extends SavedMealDetail>
    implements $SavedMealDetailCopyWith<$Res> {
  _$SavedMealDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedMealDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedMeal = null,
    Object? items = null,
    Object? macros = null,
  }) {
    return _then(
      _value.copyWith(
            savedMeal: null == savedMeal
                ? _value.savedMeal
                : savedMeal // ignore: cast_nullable_to_non_nullable
                      as SavedMeal,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<SavedMealFoodItem>,
            macros: null == macros
                ? _value.macros
                : macros // ignore: cast_nullable_to_non_nullable
                      as NutritionMacros,
          )
          as $Val,
    );
  }

  /// Create a copy of SavedMealDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SavedMealCopyWith<$Res> get savedMeal {
    return $SavedMealCopyWith<$Res>(_value.savedMeal, (value) {
      return _then(_value.copyWith(savedMeal: value) as $Val);
    });
  }

  /// Create a copy of SavedMealDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NutritionMacrosCopyWith<$Res> get macros {
    return $NutritionMacrosCopyWith<$Res>(_value.macros, (value) {
      return _then(_value.copyWith(macros: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SavedMealDetailImplCopyWith<$Res>
    implements $SavedMealDetailCopyWith<$Res> {
  factory _$$SavedMealDetailImplCopyWith(
    _$SavedMealDetailImpl value,
    $Res Function(_$SavedMealDetailImpl) then,
  ) = __$$SavedMealDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    SavedMeal savedMeal,
    List<SavedMealFoodItem> items,
    NutritionMacros macros,
  });

  @override
  $SavedMealCopyWith<$Res> get savedMeal;
  @override
  $NutritionMacrosCopyWith<$Res> get macros;
}

/// @nodoc
class __$$SavedMealDetailImplCopyWithImpl<$Res>
    extends _$SavedMealDetailCopyWithImpl<$Res, _$SavedMealDetailImpl>
    implements _$$SavedMealDetailImplCopyWith<$Res> {
  __$$SavedMealDetailImplCopyWithImpl(
    _$SavedMealDetailImpl _value,
    $Res Function(_$SavedMealDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SavedMealDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedMeal = null,
    Object? items = null,
    Object? macros = null,
  }) {
    return _then(
      _$SavedMealDetailImpl(
        savedMeal: null == savedMeal
            ? _value.savedMeal
            : savedMeal // ignore: cast_nullable_to_non_nullable
                  as SavedMeal,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<SavedMealFoodItem>,
        macros: null == macros
            ? _value.macros
            : macros // ignore: cast_nullable_to_non_nullable
                  as NutritionMacros,
      ),
    );
  }
}

/// @nodoc

class _$SavedMealDetailImpl implements _SavedMealDetail {
  const _$SavedMealDetailImpl({
    required this.savedMeal,
    required final List<SavedMealFoodItem> items,
    required this.macros,
  }) : _items = items;

  @override
  final SavedMeal savedMeal;
  final List<SavedMealFoodItem> _items;
  @override
  List<SavedMealFoodItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final NutritionMacros macros;

  @override
  String toString() {
    return 'SavedMealDetail(savedMeal: $savedMeal, items: $items, macros: $macros)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedMealDetailImpl &&
            (identical(other.savedMeal, savedMeal) ||
                other.savedMeal == savedMeal) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.macros, macros) || other.macros == macros));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    savedMeal,
    const DeepCollectionEquality().hash(_items),
    macros,
  );

  /// Create a copy of SavedMealDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedMealDetailImplCopyWith<_$SavedMealDetailImpl> get copyWith =>
      __$$SavedMealDetailImplCopyWithImpl<_$SavedMealDetailImpl>(
        this,
        _$identity,
      );
}

abstract class _SavedMealDetail implements SavedMealDetail {
  const factory _SavedMealDetail({
    required final SavedMeal savedMeal,
    required final List<SavedMealFoodItem> items,
    required final NutritionMacros macros,
  }) = _$SavedMealDetailImpl;

  @override
  SavedMeal get savedMeal;
  @override
  List<SavedMealFoodItem> get items;
  @override
  NutritionMacros get macros;

  /// Create a copy of SavedMealDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedMealDetailImplCopyWith<_$SavedMealDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
