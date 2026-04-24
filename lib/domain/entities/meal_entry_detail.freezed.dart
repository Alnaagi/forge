// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_entry_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MealEntryDetail {
  MealEntry get entry => throw _privateConstructorUsedError;
  Food get food => throw _privateConstructorUsedError;
  NutritionMacros get macros => throw _privateConstructorUsedError;

  /// Create a copy of MealEntryDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealEntryDetailCopyWith<MealEntryDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealEntryDetailCopyWith<$Res> {
  factory $MealEntryDetailCopyWith(
    MealEntryDetail value,
    $Res Function(MealEntryDetail) then,
  ) = _$MealEntryDetailCopyWithImpl<$Res, MealEntryDetail>;
  @useResult
  $Res call({MealEntry entry, Food food, NutritionMacros macros});

  $MealEntryCopyWith<$Res> get entry;
  $FoodCopyWith<$Res> get food;
  $NutritionMacrosCopyWith<$Res> get macros;
}

/// @nodoc
class _$MealEntryDetailCopyWithImpl<$Res, $Val extends MealEntryDetail>
    implements $MealEntryDetailCopyWith<$Res> {
  _$MealEntryDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealEntryDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? food = null,
    Object? macros = null,
  }) {
    return _then(
      _value.copyWith(
            entry: null == entry
                ? _value.entry
                : entry // ignore: cast_nullable_to_non_nullable
                      as MealEntry,
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

  /// Create a copy of MealEntryDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealEntryCopyWith<$Res> get entry {
    return $MealEntryCopyWith<$Res>(_value.entry, (value) {
      return _then(_value.copyWith(entry: value) as $Val);
    });
  }

  /// Create a copy of MealEntryDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodCopyWith<$Res> get food {
    return $FoodCopyWith<$Res>(_value.food, (value) {
      return _then(_value.copyWith(food: value) as $Val);
    });
  }

  /// Create a copy of MealEntryDetail
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
abstract class _$$MealEntryDetailImplCopyWith<$Res>
    implements $MealEntryDetailCopyWith<$Res> {
  factory _$$MealEntryDetailImplCopyWith(
    _$MealEntryDetailImpl value,
    $Res Function(_$MealEntryDetailImpl) then,
  ) = __$$MealEntryDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({MealEntry entry, Food food, NutritionMacros macros});

  @override
  $MealEntryCopyWith<$Res> get entry;
  @override
  $FoodCopyWith<$Res> get food;
  @override
  $NutritionMacrosCopyWith<$Res> get macros;
}

/// @nodoc
class __$$MealEntryDetailImplCopyWithImpl<$Res>
    extends _$MealEntryDetailCopyWithImpl<$Res, _$MealEntryDetailImpl>
    implements _$$MealEntryDetailImplCopyWith<$Res> {
  __$$MealEntryDetailImplCopyWithImpl(
    _$MealEntryDetailImpl _value,
    $Res Function(_$MealEntryDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MealEntryDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? food = null,
    Object? macros = null,
  }) {
    return _then(
      _$MealEntryDetailImpl(
        entry: null == entry
            ? _value.entry
            : entry // ignore: cast_nullable_to_non_nullable
                  as MealEntry,
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

class _$MealEntryDetailImpl implements _MealEntryDetail {
  const _$MealEntryDetailImpl({
    required this.entry,
    required this.food,
    required this.macros,
  });

  @override
  final MealEntry entry;
  @override
  final Food food;
  @override
  final NutritionMacros macros;

  @override
  String toString() {
    return 'MealEntryDetail(entry: $entry, food: $food, macros: $macros)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealEntryDetailImpl &&
            (identical(other.entry, entry) || other.entry == entry) &&
            (identical(other.food, food) || other.food == food) &&
            (identical(other.macros, macros) || other.macros == macros));
  }

  @override
  int get hashCode => Object.hash(runtimeType, entry, food, macros);

  /// Create a copy of MealEntryDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealEntryDetailImplCopyWith<_$MealEntryDetailImpl> get copyWith =>
      __$$MealEntryDetailImplCopyWithImpl<_$MealEntryDetailImpl>(
        this,
        _$identity,
      );
}

abstract class _MealEntryDetail implements MealEntryDetail {
  const factory _MealEntryDetail({
    required final MealEntry entry,
    required final Food food,
    required final NutritionMacros macros,
  }) = _$MealEntryDetailImpl;

  @override
  MealEntry get entry;
  @override
  Food get food;
  @override
  NutritionMacros get macros;

  /// Create a copy of MealEntryDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealEntryDetailImplCopyWith<_$MealEntryDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
