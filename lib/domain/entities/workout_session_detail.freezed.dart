// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_session_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutSessionDetail {
  WorkoutSession get session => throw _privateConstructorUsedError;
  List<WorkoutLoggedExercise> get exercises =>
      throw _privateConstructorUsedError;
  int get totalSets => throw _privateConstructorUsedError;
  double get totalVolumeKilograms => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSessionDetailCopyWith<WorkoutSessionDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSessionDetailCopyWith<$Res> {
  factory $WorkoutSessionDetailCopyWith(
    WorkoutSessionDetail value,
    $Res Function(WorkoutSessionDetail) then,
  ) = _$WorkoutSessionDetailCopyWithImpl<$Res, WorkoutSessionDetail>;
  @useResult
  $Res call({
    WorkoutSession session,
    List<WorkoutLoggedExercise> exercises,
    int totalSets,
    double totalVolumeKilograms,
  });

  $WorkoutSessionCopyWith<$Res> get session;
}

/// @nodoc
class _$WorkoutSessionDetailCopyWithImpl<
  $Res,
  $Val extends WorkoutSessionDetail
>
    implements $WorkoutSessionDetailCopyWith<$Res> {
  _$WorkoutSessionDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? exercises = null,
    Object? totalSets = null,
    Object? totalVolumeKilograms = null,
  }) {
    return _then(
      _value.copyWith(
            session: null == session
                ? _value.session
                : session // ignore: cast_nullable_to_non_nullable
                      as WorkoutSession,
            exercises: null == exercises
                ? _value.exercises
                : exercises // ignore: cast_nullable_to_non_nullable
                      as List<WorkoutLoggedExercise>,
            totalSets: null == totalSets
                ? _value.totalSets
                : totalSets // ignore: cast_nullable_to_non_nullable
                      as int,
            totalVolumeKilograms: null == totalVolumeKilograms
                ? _value.totalVolumeKilograms
                : totalVolumeKilograms // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }

  /// Create a copy of WorkoutSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WorkoutSessionCopyWith<$Res> get session {
    return $WorkoutSessionCopyWith<$Res>(_value.session, (value) {
      return _then(_value.copyWith(session: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WorkoutSessionDetailImplCopyWith<$Res>
    implements $WorkoutSessionDetailCopyWith<$Res> {
  factory _$$WorkoutSessionDetailImplCopyWith(
    _$WorkoutSessionDetailImpl value,
    $Res Function(_$WorkoutSessionDetailImpl) then,
  ) = __$$WorkoutSessionDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    WorkoutSession session,
    List<WorkoutLoggedExercise> exercises,
    int totalSets,
    double totalVolumeKilograms,
  });

  @override
  $WorkoutSessionCopyWith<$Res> get session;
}

/// @nodoc
class __$$WorkoutSessionDetailImplCopyWithImpl<$Res>
    extends _$WorkoutSessionDetailCopyWithImpl<$Res, _$WorkoutSessionDetailImpl>
    implements _$$WorkoutSessionDetailImplCopyWith<$Res> {
  __$$WorkoutSessionDetailImplCopyWithImpl(
    _$WorkoutSessionDetailImpl _value,
    $Res Function(_$WorkoutSessionDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? session = null,
    Object? exercises = null,
    Object? totalSets = null,
    Object? totalVolumeKilograms = null,
  }) {
    return _then(
      _$WorkoutSessionDetailImpl(
        session: null == session
            ? _value.session
            : session // ignore: cast_nullable_to_non_nullable
                  as WorkoutSession,
        exercises: null == exercises
            ? _value._exercises
            : exercises // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutLoggedExercise>,
        totalSets: null == totalSets
            ? _value.totalSets
            : totalSets // ignore: cast_nullable_to_non_nullable
                  as int,
        totalVolumeKilograms: null == totalVolumeKilograms
            ? _value.totalVolumeKilograms
            : totalVolumeKilograms // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc

class _$WorkoutSessionDetailImpl implements _WorkoutSessionDetail {
  const _$WorkoutSessionDetailImpl({
    required this.session,
    required final List<WorkoutLoggedExercise> exercises,
    required this.totalSets,
    required this.totalVolumeKilograms,
  }) : _exercises = exercises;

  @override
  final WorkoutSession session;
  final List<WorkoutLoggedExercise> _exercises;
  @override
  List<WorkoutLoggedExercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  final int totalSets;
  @override
  final double totalVolumeKilograms;

  @override
  String toString() {
    return 'WorkoutSessionDetail(session: $session, exercises: $exercises, totalSets: $totalSets, totalVolumeKilograms: $totalVolumeKilograms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSessionDetailImpl &&
            (identical(other.session, session) || other.session == session) &&
            const DeepCollectionEquality().equals(
              other._exercises,
              _exercises,
            ) &&
            (identical(other.totalSets, totalSets) ||
                other.totalSets == totalSets) &&
            (identical(other.totalVolumeKilograms, totalVolumeKilograms) ||
                other.totalVolumeKilograms == totalVolumeKilograms));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    session,
    const DeepCollectionEquality().hash(_exercises),
    totalSets,
    totalVolumeKilograms,
  );

  /// Create a copy of WorkoutSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSessionDetailImplCopyWith<_$WorkoutSessionDetailImpl>
  get copyWith =>
      __$$WorkoutSessionDetailImplCopyWithImpl<_$WorkoutSessionDetailImpl>(
        this,
        _$identity,
      );
}

abstract class _WorkoutSessionDetail implements WorkoutSessionDetail {
  const factory _WorkoutSessionDetail({
    required final WorkoutSession session,
    required final List<WorkoutLoggedExercise> exercises,
    required final int totalSets,
    required final double totalVolumeKilograms,
  }) = _$WorkoutSessionDetailImpl;

  @override
  WorkoutSession get session;
  @override
  List<WorkoutLoggedExercise> get exercises;
  @override
  int get totalSets;
  @override
  double get totalVolumeKilograms;

  /// Create a copy of WorkoutSessionDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSessionDetailImplCopyWith<_$WorkoutSessionDetailImpl>
  get copyWith => throw _privateConstructorUsedError;
}
