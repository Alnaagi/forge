// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_history_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WorkoutHistoryItem {
  String get sessionId => throw _privateConstructorUsedError;
  String? get templateName => throw _privateConstructorUsedError;
  DateTime get startedAt => throw _privateConstructorUsedError;
  DateTime? get endedAt => throw _privateConstructorUsedError;
  int get exerciseCount => throw _privateConstructorUsedError;
  int get setCount => throw _privateConstructorUsedError;
  double get totalVolumeKilograms => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutHistoryItemCopyWith<WorkoutHistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutHistoryItemCopyWith<$Res> {
  factory $WorkoutHistoryItemCopyWith(
    WorkoutHistoryItem value,
    $Res Function(WorkoutHistoryItem) then,
  ) = _$WorkoutHistoryItemCopyWithImpl<$Res, WorkoutHistoryItem>;
  @useResult
  $Res call({
    String sessionId,
    String? templateName,
    DateTime startedAt,
    DateTime? endedAt,
    int exerciseCount,
    int setCount,
    double totalVolumeKilograms,
  });
}

/// @nodoc
class _$WorkoutHistoryItemCopyWithImpl<$Res, $Val extends WorkoutHistoryItem>
    implements $WorkoutHistoryItemCopyWith<$Res> {
  _$WorkoutHistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? templateName = freezed,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? exerciseCount = null,
    Object? setCount = null,
    Object? totalVolumeKilograms = null,
  }) {
    return _then(
      _value.copyWith(
            sessionId: null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                      as String,
            templateName: freezed == templateName
                ? _value.templateName
                : templateName // ignore: cast_nullable_to_non_nullable
                      as String?,
            startedAt: null == startedAt
                ? _value.startedAt
                : startedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endedAt: freezed == endedAt
                ? _value.endedAt
                : endedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            exerciseCount: null == exerciseCount
                ? _value.exerciseCount
                : exerciseCount // ignore: cast_nullable_to_non_nullable
                      as int,
            setCount: null == setCount
                ? _value.setCount
                : setCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalVolumeKilograms: null == totalVolumeKilograms
                ? _value.totalVolumeKilograms
                : totalVolumeKilograms // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutHistoryItemImplCopyWith<$Res>
    implements $WorkoutHistoryItemCopyWith<$Res> {
  factory _$$WorkoutHistoryItemImplCopyWith(
    _$WorkoutHistoryItemImpl value,
    $Res Function(_$WorkoutHistoryItemImpl) then,
  ) = __$$WorkoutHistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String sessionId,
    String? templateName,
    DateTime startedAt,
    DateTime? endedAt,
    int exerciseCount,
    int setCount,
    double totalVolumeKilograms,
  });
}

/// @nodoc
class __$$WorkoutHistoryItemImplCopyWithImpl<$Res>
    extends _$WorkoutHistoryItemCopyWithImpl<$Res, _$WorkoutHistoryItemImpl>
    implements _$$WorkoutHistoryItemImplCopyWith<$Res> {
  __$$WorkoutHistoryItemImplCopyWithImpl(
    _$WorkoutHistoryItemImpl _value,
    $Res Function(_$WorkoutHistoryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? templateName = freezed,
    Object? startedAt = null,
    Object? endedAt = freezed,
    Object? exerciseCount = null,
    Object? setCount = null,
    Object? totalVolumeKilograms = null,
  }) {
    return _then(
      _$WorkoutHistoryItemImpl(
        sessionId: null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                  as String,
        templateName: freezed == templateName
            ? _value.templateName
            : templateName // ignore: cast_nullable_to_non_nullable
                  as String?,
        startedAt: null == startedAt
            ? _value.startedAt
            : startedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endedAt: freezed == endedAt
            ? _value.endedAt
            : endedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        exerciseCount: null == exerciseCount
            ? _value.exerciseCount
            : exerciseCount // ignore: cast_nullable_to_non_nullable
                  as int,
        setCount: null == setCount
            ? _value.setCount
            : setCount // ignore: cast_nullable_to_non_nullable
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

class _$WorkoutHistoryItemImpl implements _WorkoutHistoryItem {
  const _$WorkoutHistoryItemImpl({
    required this.sessionId,
    this.templateName,
    required this.startedAt,
    this.endedAt,
    required this.exerciseCount,
    required this.setCount,
    required this.totalVolumeKilograms,
  });

  @override
  final String sessionId;
  @override
  final String? templateName;
  @override
  final DateTime startedAt;
  @override
  final DateTime? endedAt;
  @override
  final int exerciseCount;
  @override
  final int setCount;
  @override
  final double totalVolumeKilograms;

  @override
  String toString() {
    return 'WorkoutHistoryItem(sessionId: $sessionId, templateName: $templateName, startedAt: $startedAt, endedAt: $endedAt, exerciseCount: $exerciseCount, setCount: $setCount, totalVolumeKilograms: $totalVolumeKilograms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutHistoryItemImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.templateName, templateName) ||
                other.templateName == templateName) &&
            (identical(other.startedAt, startedAt) ||
                other.startedAt == startedAt) &&
            (identical(other.endedAt, endedAt) || other.endedAt == endedAt) &&
            (identical(other.exerciseCount, exerciseCount) ||
                other.exerciseCount == exerciseCount) &&
            (identical(other.setCount, setCount) ||
                other.setCount == setCount) &&
            (identical(other.totalVolumeKilograms, totalVolumeKilograms) ||
                other.totalVolumeKilograms == totalVolumeKilograms));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    sessionId,
    templateName,
    startedAt,
    endedAt,
    exerciseCount,
    setCount,
    totalVolumeKilograms,
  );

  /// Create a copy of WorkoutHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutHistoryItemImplCopyWith<_$WorkoutHistoryItemImpl> get copyWith =>
      __$$WorkoutHistoryItemImplCopyWithImpl<_$WorkoutHistoryItemImpl>(
        this,
        _$identity,
      );
}

abstract class _WorkoutHistoryItem implements WorkoutHistoryItem {
  const factory _WorkoutHistoryItem({
    required final String sessionId,
    final String? templateName,
    required final DateTime startedAt,
    final DateTime? endedAt,
    required final int exerciseCount,
    required final int setCount,
    required final double totalVolumeKilograms,
  }) = _$WorkoutHistoryItemImpl;

  @override
  String get sessionId;
  @override
  String? get templateName;
  @override
  DateTime get startedAt;
  @override
  DateTime? get endedAt;
  @override
  int get exerciseCount;
  @override
  int get setCount;
  @override
  double get totalVolumeKilograms;

  /// Create a copy of WorkoutHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutHistoryItemImplCopyWith<_$WorkoutHistoryItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
