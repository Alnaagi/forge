// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutrition_macros.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NutritionMacros {
  int get calories => throw _privateConstructorUsedError;
  double get protein => throw _privateConstructorUsedError;
  double get carbs => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;

  /// Create a copy of NutritionMacros
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionMacrosCopyWith<NutritionMacros> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionMacrosCopyWith<$Res> {
  factory $NutritionMacrosCopyWith(
    NutritionMacros value,
    $Res Function(NutritionMacros) then,
  ) = _$NutritionMacrosCopyWithImpl<$Res, NutritionMacros>;
  @useResult
  $Res call({int calories, double protein, double carbs, double fat});
}

/// @nodoc
class _$NutritionMacrosCopyWithImpl<$Res, $Val extends NutritionMacros>
    implements $NutritionMacrosCopyWith<$Res> {
  _$NutritionMacrosCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionMacros
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? protein = null,
    Object? carbs = null,
    Object? fat = null,
  }) {
    return _then(
      _value.copyWith(
            calories: null == calories
                ? _value.calories
                : calories // ignore: cast_nullable_to_non_nullable
                      as int,
            protein: null == protein
                ? _value.protein
                : protein // ignore: cast_nullable_to_non_nullable
                      as double,
            carbs: null == carbs
                ? _value.carbs
                : carbs // ignore: cast_nullable_to_non_nullable
                      as double,
            fat: null == fat
                ? _value.fat
                : fat // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NutritionMacrosImplCopyWith<$Res>
    implements $NutritionMacrosCopyWith<$Res> {
  factory _$$NutritionMacrosImplCopyWith(
    _$NutritionMacrosImpl value,
    $Res Function(_$NutritionMacrosImpl) then,
  ) = __$$NutritionMacrosImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int calories, double protein, double carbs, double fat});
}

/// @nodoc
class __$$NutritionMacrosImplCopyWithImpl<$Res>
    extends _$NutritionMacrosCopyWithImpl<$Res, _$NutritionMacrosImpl>
    implements _$$NutritionMacrosImplCopyWith<$Res> {
  __$$NutritionMacrosImplCopyWithImpl(
    _$NutritionMacrosImpl _value,
    $Res Function(_$NutritionMacrosImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NutritionMacros
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? protein = null,
    Object? carbs = null,
    Object? fat = null,
  }) {
    return _then(
      _$NutritionMacrosImpl(
        calories: null == calories
            ? _value.calories
            : calories // ignore: cast_nullable_to_non_nullable
                  as int,
        protein: null == protein
            ? _value.protein
            : protein // ignore: cast_nullable_to_non_nullable
                  as double,
        carbs: null == carbs
            ? _value.carbs
            : carbs // ignore: cast_nullable_to_non_nullable
                  as double,
        fat: null == fat
            ? _value.fat
            : fat // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$NutritionMacrosImpl extends _NutritionMacros {
  const _$NutritionMacrosImpl({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  }) : super._();

  @override
  final int calories;
  @override
  final double protein;
  @override
  final double carbs;
  @override
  final double fat;

  @override
  String toString() {
    return 'NutritionMacros(calories: $calories, protein: $protein, carbs: $carbs, fat: $fat)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionMacrosImpl &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.carbs, carbs) || other.carbs == carbs) &&
            (identical(other.fat, fat) || other.fat == fat));
  }

  @override
  int get hashCode => Object.hash(runtimeType, calories, protein, carbs, fat);

  /// Create a copy of NutritionMacros
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionMacrosImplCopyWith<_$NutritionMacrosImpl> get copyWith =>
      __$$NutritionMacrosImplCopyWithImpl<_$NutritionMacrosImpl>(
        this,
        _$identity,
      );
}

abstract class _NutritionMacros extends NutritionMacros {
  const factory _NutritionMacros({
    required final int calories,
    required final double protein,
    required final double carbs,
    required final double fat,
  }) = _$NutritionMacrosImpl;
  const _NutritionMacros._() : super._();

  @override
  int get calories;
  @override
  double get protein;
  @override
  double get carbs;
  @override
  double get fat;

  /// Create a copy of NutritionMacros
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionMacrosImplCopyWith<_$NutritionMacrosImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
