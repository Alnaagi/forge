// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'macro_target.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MacroTarget {
  int get calories => throw _privateConstructorUsedError;
  double get proteinGrams => throw _privateConstructorUsedError;
  double get carbsGrams => throw _privateConstructorUsedError;
  double get fatGrams => throw _privateConstructorUsedError;

  /// Create a copy of MacroTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MacroTargetCopyWith<MacroTarget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MacroTargetCopyWith<$Res> {
  factory $MacroTargetCopyWith(
    MacroTarget value,
    $Res Function(MacroTarget) then,
  ) = _$MacroTargetCopyWithImpl<$Res, MacroTarget>;
  @useResult
  $Res call({
    int calories,
    double proteinGrams,
    double carbsGrams,
    double fatGrams,
  });
}

/// @nodoc
class _$MacroTargetCopyWithImpl<$Res, $Val extends MacroTarget>
    implements $MacroTargetCopyWith<$Res> {
  _$MacroTargetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MacroTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? proteinGrams = null,
    Object? carbsGrams = null,
    Object? fatGrams = null,
  }) {
    return _then(
      _value.copyWith(
            calories: null == calories
                ? _value.calories
                : calories // ignore: cast_nullable_to_non_nullable
                      as int,
            proteinGrams: null == proteinGrams
                ? _value.proteinGrams
                : proteinGrams // ignore: cast_nullable_to_non_nullable
                      as double,
            carbsGrams: null == carbsGrams
                ? _value.carbsGrams
                : carbsGrams // ignore: cast_nullable_to_non_nullable
                      as double,
            fatGrams: null == fatGrams
                ? _value.fatGrams
                : fatGrams // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MacroTargetImplCopyWith<$Res>
    implements $MacroTargetCopyWith<$Res> {
  factory _$$MacroTargetImplCopyWith(
    _$MacroTargetImpl value,
    $Res Function(_$MacroTargetImpl) then,
  ) = __$$MacroTargetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int calories,
    double proteinGrams,
    double carbsGrams,
    double fatGrams,
  });
}

/// @nodoc
class __$$MacroTargetImplCopyWithImpl<$Res>
    extends _$MacroTargetCopyWithImpl<$Res, _$MacroTargetImpl>
    implements _$$MacroTargetImplCopyWith<$Res> {
  __$$MacroTargetImplCopyWithImpl(
    _$MacroTargetImpl _value,
    $Res Function(_$MacroTargetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MacroTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calories = null,
    Object? proteinGrams = null,
    Object? carbsGrams = null,
    Object? fatGrams = null,
  }) {
    return _then(
      _$MacroTargetImpl(
        calories: null == calories
            ? _value.calories
            : calories // ignore: cast_nullable_to_non_nullable
                  as int,
        proteinGrams: null == proteinGrams
            ? _value.proteinGrams
            : proteinGrams // ignore: cast_nullable_to_non_nullable
                  as double,
        carbsGrams: null == carbsGrams
            ? _value.carbsGrams
            : carbsGrams // ignore: cast_nullable_to_non_nullable
                  as double,
        fatGrams: null == fatGrams
            ? _value.fatGrams
            : fatGrams // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$MacroTargetImpl implements _MacroTarget {
  const _$MacroTargetImpl({
    required this.calories,
    required this.proteinGrams,
    required this.carbsGrams,
    required this.fatGrams,
  }) : assert(calories >= 0, 'Calories cannot be negative.'),
       assert(proteinGrams >= 0, 'Protein cannot be negative.'),
       assert(carbsGrams >= 0, 'Carbs cannot be negative.'),
       assert(fatGrams >= 0, 'Fat cannot be negative.');

  @override
  final int calories;
  @override
  final double proteinGrams;
  @override
  final double carbsGrams;
  @override
  final double fatGrams;

  @override
  String toString() {
    return 'MacroTarget(calories: $calories, proteinGrams: $proteinGrams, carbsGrams: $carbsGrams, fatGrams: $fatGrams)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MacroTargetImpl &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.proteinGrams, proteinGrams) ||
                other.proteinGrams == proteinGrams) &&
            (identical(other.carbsGrams, carbsGrams) ||
                other.carbsGrams == carbsGrams) &&
            (identical(other.fatGrams, fatGrams) ||
                other.fatGrams == fatGrams));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, calories, proteinGrams, carbsGrams, fatGrams);

  /// Create a copy of MacroTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MacroTargetImplCopyWith<_$MacroTargetImpl> get copyWith =>
      __$$MacroTargetImplCopyWithImpl<_$MacroTargetImpl>(this, _$identity);
}

abstract class _MacroTarget implements MacroTarget {
  const factory _MacroTarget({
    required final int calories,
    required final double proteinGrams,
    required final double carbsGrams,
    required final double fatGrams,
  }) = _$MacroTargetImpl;

  @override
  int get calories;
  @override
  double get proteinGrams;
  @override
  double get carbsGrams;
  @override
  double get fatGrams;

  /// Create a copy of MacroTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MacroTargetImplCopyWith<_$MacroTargetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
