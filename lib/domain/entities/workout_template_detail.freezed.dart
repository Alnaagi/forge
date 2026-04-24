// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_template_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutTemplateExerciseItem {
  WorkoutTemplateItem get item => throw _privateConstructorUsedError;
  Exercise get exercise => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutTemplateExerciseItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutTemplateExerciseItemCopyWith<WorkoutTemplateExerciseItem>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutTemplateExerciseItemCopyWith<$Res> {
  factory $WorkoutTemplateExerciseItemCopyWith(
    WorkoutTemplateExerciseItem value,
    $Res Function(WorkoutTemplateExerciseItem) then,
  ) =
      _$WorkoutTemplateExerciseItemCopyWithImpl<
        $Res,
        WorkoutTemplateExerciseItem
      >;
  @useResult
  $Res call({WorkoutTemplateItem item, Exercise exercise});

  $WorkoutTemplateItemCopyWith<$Res> get item;
  $ExerciseCopyWith<$Res> get exercise;
}

/// @nodoc
class _$WorkoutTemplateExerciseItemCopyWithImpl<
  $Res,
  $Val extends WorkoutTemplateExerciseItem
>
    implements $WorkoutTemplateExerciseItemCopyWith<$Res> {
  _$WorkoutTemplateExerciseItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutTemplateExerciseItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? item = null, Object? exercise = null}) {
    return _then(
      _value.copyWith(
            item: null == item
                ? _value.item
                : item // ignore: cast_nullable_to_non_nullable
                      as WorkoutTemplateItem,
            exercise: null == exercise
                ? _value.exercise
                : exercise // ignore: cast_nullable_to_non_nullable
                      as Exercise,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutTemplateExerciseItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutTemplateItemCopyWith<$Res> get item {
    return $WorkoutTemplateItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value) as $Val);
    });
  }

  /// Create a copy of WorkoutTemplateExerciseItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ExerciseCopyWith<$Res> get exercise {
    return $ExerciseCopyWith<$Res>(_value.exercise, (value) {
      return _then(_value.copyWith(exercise: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutTemplateExerciseItemImplCopyWith<$Res>
    implements $WorkoutTemplateExerciseItemCopyWith<$Res> {
  factory _$$WorkoutTemplateExerciseItemImplCopyWith(
    _$WorkoutTemplateExerciseItemImpl value,
    $Res Function(_$WorkoutTemplateExerciseItemImpl) then,
  ) = __$$WorkoutTemplateExerciseItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({WorkoutTemplateItem item, Exercise exercise});

  @override
  $WorkoutTemplateItemCopyWith<$Res> get item;
  @override
  $ExerciseCopyWith<$Res> get exercise;
}

/// @nodoc
class __$$WorkoutTemplateExerciseItemImplCopyWithImpl<$Res>
    extends
        _$WorkoutTemplateExerciseItemCopyWithImpl<
          $Res,
          _$WorkoutTemplateExerciseItemImpl
        >
    implements _$$WorkoutTemplateExerciseItemImplCopyWith<$Res> {
  __$$WorkoutTemplateExerciseItemImplCopyWithImpl(
    _$WorkoutTemplateExerciseItemImpl _value,
    $Res Function(_$WorkoutTemplateExerciseItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutTemplateExerciseItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? item = null, Object? exercise = null}) {
    return _then(
      _$WorkoutTemplateExerciseItemImpl(
        item: null == item
            ? _value.item
            : item // ignore: cast_nullable_to_non_nullable
                  as WorkoutTemplateItem,
        exercise: null == exercise
            ? _value.exercise
            : exercise // ignore: cast_nullable_to_non_nullable
                  as Exercise,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutTemplateExerciseItemImpl
    implements _WorkoutTemplateExerciseItem {
  const _$WorkoutTemplateExerciseItemImpl({
    required this.item,
    required this.exercise,
  });

  @override
  final WorkoutTemplateItem item;
  @override
  final Exercise exercise;

  @override
  String toString() {
    return 'WorkoutTemplateExerciseItem(item: $item, exercise: $exercise)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutTemplateExerciseItemImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise));
  }

  @override
  int get hashCode => Object.hash(runtimeType, item, exercise);

  /// Create a copy of WorkoutTemplateExerciseItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutTemplateExerciseItemImplCopyWith<_$WorkoutTemplateExerciseItemImpl>
  get copyWith =>
      __$$WorkoutTemplateExerciseItemImplCopyWithImpl<
        _$WorkoutTemplateExerciseItemImpl
      >(this, _$identity);
}

abstract class _WorkoutTemplateExerciseItem
    implements WorkoutTemplateExerciseItem {
  const factory _WorkoutTemplateExerciseItem({
    required final WorkoutTemplateItem item,
    required final Exercise exercise,
  }) = _$WorkoutTemplateExerciseItemImpl;

  @override
  WorkoutTemplateItem get item;
  @override
  Exercise get exercise;

  /// Create a copy of WorkoutTemplateExerciseItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutTemplateExerciseItemImplCopyWith<_$WorkoutTemplateExerciseItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$WorkoutTemplateDetail {
  WorkoutTemplate get template => throw _privateConstructorUsedError;
  List<WorkoutTemplateExerciseItem> get items =>
      throw _privateConstructorUsedError;

  /// Create a copy of WorkoutTemplateDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutTemplateDetailCopyWith<WorkoutTemplateDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutTemplateDetailCopyWith<$Res> {
  factory $WorkoutTemplateDetailCopyWith(
    WorkoutTemplateDetail value,
    $Res Function(WorkoutTemplateDetail) then,
  ) = _$WorkoutTemplateDetailCopyWithImpl<$Res, WorkoutTemplateDetail>;
  @useResult
  $Res call({
    WorkoutTemplate template,
    List<WorkoutTemplateExerciseItem> items,
  });

  $WorkoutTemplateCopyWith<$Res> get template;
}

/// @nodoc
class _$WorkoutTemplateDetailCopyWithImpl<
  $Res,
  $Val extends WorkoutTemplateDetail
>
    implements $WorkoutTemplateDetailCopyWith<$Res> {
  _$WorkoutTemplateDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutTemplateDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? template = null, Object? items = null}) {
    return _then(
      _value.copyWith(
            template: null == template
                ? _value.template
                : template // ignore: cast_nullable_to_non_nullable
                      as WorkoutTemplate,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<WorkoutTemplateExerciseItem>,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutTemplateDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutTemplateCopyWith<$Res> get template {
    return $WorkoutTemplateCopyWith<$Res>(_value.template, (value) {
      return _then(_value.copyWith(template: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutTemplateDetailImplCopyWith<$Res>
    implements $WorkoutTemplateDetailCopyWith<$Res> {
  factory _$$WorkoutTemplateDetailImplCopyWith(
    _$WorkoutTemplateDetailImpl value,
    $Res Function(_$WorkoutTemplateDetailImpl) then,
  ) = __$$WorkoutTemplateDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WorkoutTemplate template,
    List<WorkoutTemplateExerciseItem> items,
  });

  @override
  $WorkoutTemplateCopyWith<$Res> get template;
}

/// @nodoc
class __$$WorkoutTemplateDetailImplCopyWithImpl<$Res>
    extends
        _$WorkoutTemplateDetailCopyWithImpl<$Res, _$WorkoutTemplateDetailImpl>
    implements _$$WorkoutTemplateDetailImplCopyWith<$Res> {
  __$$WorkoutTemplateDetailImplCopyWithImpl(
    _$WorkoutTemplateDetailImpl _value,
    $Res Function(_$WorkoutTemplateDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutTemplateDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? template = null, Object? items = null}) {
    return _then(
      _$WorkoutTemplateDetailImpl(
        template: null == template
            ? _value.template
            : template // ignore: cast_nullable_to_non_nullable
                  as WorkoutTemplate,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutTemplateExerciseItem>,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutTemplateDetailImpl implements _WorkoutTemplateDetail {
  const _$WorkoutTemplateDetailImpl({
    required this.template,
    required final List<WorkoutTemplateExerciseItem> items,
  }) : _items = items;

  @override
  final WorkoutTemplate template;
  final List<WorkoutTemplateExerciseItem> _items;
  @override
  List<WorkoutTemplateExerciseItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'WorkoutTemplateDetail(template: $template, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutTemplateDetailImpl &&
            (identical(other.template, template) ||
                other.template == template) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    template,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of WorkoutTemplateDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutTemplateDetailImplCopyWith<_$WorkoutTemplateDetailImpl>
  get copyWith =>
      __$$WorkoutTemplateDetailImplCopyWithImpl<_$WorkoutTemplateDetailImpl>(
        this,
        _$identity,
      );
}

abstract class _WorkoutTemplateDetail implements WorkoutTemplateDetail {
  const factory _WorkoutTemplateDetail({
    required final WorkoutTemplate template,
    required final List<WorkoutTemplateExerciseItem> items,
  }) = _$WorkoutTemplateDetailImpl;

  @override
  WorkoutTemplate get template;
  @override
  List<WorkoutTemplateExerciseItem> get items;

  /// Create a copy of WorkoutTemplateDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutTemplateDetailImplCopyWith<_$WorkoutTemplateDetailImpl>
  get copyWith => throw _privateConstructorUsedError;
}
