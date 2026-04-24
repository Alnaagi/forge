// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FoodDetail {
  Food get food => throw _privateConstructorUsedError;
  List<FoodPortion> get portions => throw _privateConstructorUsedError;

  /// Create a copy of FoodDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodDetailCopyWith<FoodDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodDetailCopyWith<$Res> {
  factory $FoodDetailCopyWith(
    FoodDetail value,
    $Res Function(FoodDetail) then,
  ) = _$FoodDetailCopyWithImpl<$Res, FoodDetail>;
  @useResult
  $Res call({Food food, List<FoodPortion> portions});

  $FoodCopyWith<$Res> get food;
}

/// @nodoc
class _$FoodDetailCopyWithImpl<$Res, $Val extends FoodDetail>
    implements $FoodDetailCopyWith<$Res> {
  _$FoodDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? food = null, Object? portions = null}) {
    return _then(
      _value.copyWith(
            food: null == food
                ? _value.food
                : food // ignore: cast_nullable_to_non_nullable
                      as Food,
            portions: null == portions
                ? _value.portions
                : portions // ignore: cast_nullable_to_non_nullable
                      as List<FoodPortion>,
          )
          as $Val,
    );
  }

  /// Create a copy of FoodDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodCopyWith<$Res> get food {
    return $FoodCopyWith<$Res>(_value.food, (value) {
      return _then(_value.copyWith(food: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FoodDetailImplCopyWith<$Res>
    implements $FoodDetailCopyWith<$Res> {
  factory _$$FoodDetailImplCopyWith(
    _$FoodDetailImpl value,
    $Res Function(_$FoodDetailImpl) then,
  ) = __$$FoodDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Food food, List<FoodPortion> portions});

  @override
  $FoodCopyWith<$Res> get food;
}

/// @nodoc
class __$$FoodDetailImplCopyWithImpl<$Res>
    extends _$FoodDetailCopyWithImpl<$Res, _$FoodDetailImpl>
    implements _$$FoodDetailImplCopyWith<$Res> {
  __$$FoodDetailImplCopyWithImpl(
    _$FoodDetailImpl _value,
    $Res Function(_$FoodDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FoodDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? food = null, Object? portions = null}) {
    return _then(
      _$FoodDetailImpl(
        food: null == food
            ? _value.food
            : food // ignore: cast_nullable_to_non_nullable
                  as Food,
        portions: null == portions
            ? _value._portions
            : portions // ignore: cast_nullable_to_non_nullable
                  as List<FoodPortion>,
      ),
    );
  }
}

/// @nodoc

class _$FoodDetailImpl implements _FoodDetail {
  const _$FoodDetailImpl({
    required this.food,
    required final List<FoodPortion> portions,
  }) : _portions = portions;

  @override
  final Food food;
  final List<FoodPortion> _portions;
  @override
  List<FoodPortion> get portions {
    if (_portions is EqualUnmodifiableListView) return _portions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_portions);
  }

  @override
  String toString() {
    return 'FoodDetail(food: $food, portions: $portions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodDetailImpl &&
            (identical(other.food, food) || other.food == food) &&
            const DeepCollectionEquality().equals(other._portions, _portions));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    food,
    const DeepCollectionEquality().hash(_portions),
  );

  /// Create a copy of FoodDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodDetailImplCopyWith<_$FoodDetailImpl> get copyWith =>
      __$$FoodDetailImplCopyWithImpl<_$FoodDetailImpl>(this, _$identity);
}

abstract class _FoodDetail implements FoodDetail {
  const factory _FoodDetail({
    required final Food food,
    required final List<FoodPortion> portions,
  }) = _$FoodDetailImpl;

  @override
  Food get food;
  @override
  List<FoodPortion> get portions;

  /// Create a copy of FoodDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodDetailImplCopyWith<_$FoodDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
