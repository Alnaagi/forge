// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_logged_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutLoggedExercise {
  WorkoutExerciseEntry get entry => throw _privateConstructorUsedError;
  Exercise get exercise => throw _privateConstructorUsedError;
  List<SetEntry> get sets => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutLoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutLoggedExerciseCopyWith<WorkoutLoggedExercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutLoggedExerciseCopyWith<$Res> {
  factory $WorkoutLoggedExerciseCopyWith(
    WorkoutLoggedExercise value,
    $Res Function(WorkoutLoggedExercise) then,
  ) = _$WorkoutLoggedExerciseCopyWithImpl<$Res, WorkoutLoggedExercise>;
  @useResult
  $Res call({
    WorkoutExerciseEntry entry,
    Exercise exercise,
    List<SetEntry> sets,
  });

  $WorkoutExerciseEntryCopyWith<$Res> get entry;
  $ExerciseCopyWith<$Res> get exercise;
}

/// @nodoc
class _$WorkoutLoggedExerciseCopyWithImpl<
  $Res,
  $Val extends WorkoutLoggedExercise
>
    implements $WorkoutLoggedExerciseCopyWith<$Res> {
  _$WorkoutLoggedExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutLoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? exercise = null,
    Object? sets = null,
  }) {
    return _then(
      _value.copyWith(
            entry: null == entry
                ? _value.entry
                : entry // ignore: cast_nullable_to_non_nullable
                      as WorkoutExerciseEntry,
            exercise: null == exercise
                ? _value.exercise
                : exercise // ignore: cast_nullable_to_non_nullable
                      as Exercise,
            sets: null == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as List<SetEntry>,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutLoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutExerciseEntryCopyWith<$Res> get entry {
    return $WorkoutExerciseEntryCopyWith<$Res>(_value.entry, (value) {
      return _then(_value.copyWith(entry: value) as $Val);
    });
  }

  /// Create a copy of WorkoutLoggedExercise
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
abstract class _$$WorkoutLoggedExerciseImplCopyWith<$Res>
    implements $WorkoutLoggedExerciseCopyWith<$Res> {
  factory _$$WorkoutLoggedExerciseImplCopyWith(
    _$WorkoutLoggedExerciseImpl value,
    $Res Function(_$WorkoutLoggedExerciseImpl) then,
  ) = __$$WorkoutLoggedExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WorkoutExerciseEntry entry,
    Exercise exercise,
    List<SetEntry> sets,
  });

  @override
  $WorkoutExerciseEntryCopyWith<$Res> get entry;
  @override
  $ExerciseCopyWith<$Res> get exercise;
}

/// @nodoc
class __$$WorkoutLoggedExerciseImplCopyWithImpl<$Res>
    extends
        _$WorkoutLoggedExerciseCopyWithImpl<$Res, _$WorkoutLoggedExerciseImpl>
    implements _$$WorkoutLoggedExerciseImplCopyWith<$Res> {
  __$$WorkoutLoggedExerciseImplCopyWithImpl(
    _$WorkoutLoggedExerciseImpl _value,
    $Res Function(_$WorkoutLoggedExerciseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutLoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? entry = null,
    Object? exercise = null,
    Object? sets = null,
  }) {
    return _then(
      _$WorkoutLoggedExerciseImpl(
        entry: null == entry
            ? _value.entry
            : entry // ignore: cast_nullable_to_non_nullable
                  as WorkoutExerciseEntry,
        exercise: null == exercise
            ? _value.exercise
            : exercise // ignore: cast_nullable_to_non_nullable
                  as Exercise,
        sets: null == sets
            ? _value._sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as List<SetEntry>,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutLoggedExerciseImpl implements _WorkoutLoggedExercise {
  const _$WorkoutLoggedExerciseImpl({
    required this.entry,
    required this.exercise,
    required final List<SetEntry> sets,
  }) : _sets = sets;

  @override
  final WorkoutExerciseEntry entry;
  @override
  final Exercise exercise;
  final List<SetEntry> _sets;
  @override
  List<SetEntry> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  @override
  String toString() {
    return 'WorkoutLoggedExercise(entry: $entry, exercise: $exercise, sets: $sets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutLoggedExerciseImpl &&
            (identical(other.entry, entry) || other.entry == entry) &&
            (identical(other.exercise, exercise) ||
                other.exercise == exercise) &&
            const DeepCollectionEquality().equals(other._sets, _sets));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    entry,
    exercise,
    const DeepCollectionEquality().hash(_sets),
  );

  /// Create a copy of WorkoutLoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutLoggedExerciseImplCopyWith<_$WorkoutLoggedExerciseImpl>
  get copyWith =>
      __$$WorkoutLoggedExerciseImplCopyWithImpl<_$WorkoutLoggedExerciseImpl>(
        this,
        _$identity,
      );
}

abstract class _WorkoutLoggedExercise implements WorkoutLoggedExercise {
  const factory _WorkoutLoggedExercise({
    required final WorkoutExerciseEntry entry,
    required final Exercise exercise,
    required final List<SetEntry> sets,
  }) = _$WorkoutLoggedExerciseImpl;

  @override
  WorkoutExerciseEntry get entry;
  @override
  Exercise get exercise;
  @override
  List<SetEntry> get sets;

  /// Create a copy of WorkoutLoggedExercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutLoggedExerciseImplCopyWith<_$WorkoutLoggedExerciseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
