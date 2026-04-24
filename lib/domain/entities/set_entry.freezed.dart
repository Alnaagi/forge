// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SetEntry {
  String get id => throw _privateConstructorUsedError;
  String get exerciseEntryId => throw _privateConstructorUsedError;
  SetType get setType => throw _privateConstructorUsedError;
  int get orderIndex => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  WeightValue? get weight => throw _privateConstructorUsedError;
  double? get rpe => throw _privateConstructorUsedError;
  String? get tempo => throw _privateConstructorUsedError;
  int? get restSeconds => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of SetEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SetEntryCopyWith<SetEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SetEntryCopyWith<$Res> {
  factory $SetEntryCopyWith(SetEntry value, $Res Function(SetEntry) then) =
      _$SetEntryCopyWithImpl<$Res, SetEntry>;
  @useResult
  $Res call({
    String id,
    String exerciseEntryId,
    SetType setType,
    int orderIndex,
    int reps,
    WeightValue? weight,
    double? rpe,
    String? tempo,
    int? restSeconds,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });

  $WeightValueCopyWith<$Res>? get weight;
}

/// @nodoc
class _$SetEntryCopyWithImpl<$Res, $Val extends SetEntry>
    implements $SetEntryCopyWith<$Res> {
  _$SetEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SetEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseEntryId = null,
    Object? setType = null,
    Object? orderIndex = null,
    Object? reps = null,
    Object? weight = freezed,
    Object? rpe = freezed,
    Object? tempo = freezed,
    Object? restSeconds = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            exerciseEntryId: null == exerciseEntryId
                ? _value.exerciseEntryId
                : exerciseEntryId // ignore: cast_nullable_to_non_nullable
                      as String,
            setType: null == setType
                ? _value.setType
                : setType // ignore: cast_nullable_to_non_nullable
                      as SetType,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            weight: freezed == weight
                ? _value.weight
                : weight // ignore: cast_nullable_to_non_nullable
                      as WeightValue?,
            rpe: freezed == rpe
                ? _value.rpe
                : rpe // ignore: cast_nullable_to_non_nullable
                      as double?,
            tempo: freezed == tempo
                ? _value.tempo
                : tempo // ignore: cast_nullable_to_non_nullable
                      as String?,
            restSeconds: freezed == restSeconds
                ? _value.restSeconds
                : restSeconds // ignore: cast_nullable_to_non_nullable
                      as int?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
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

  /// Create a copy of SetEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WeightValueCopyWith<$Res>? get weight {
    if (_value.weight == null) {
      return null;
    }

    return $WeightValueCopyWith<$Res>(_value.weight!, (value) {
      return _then(_value.copyWith(weight: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SetEntryImplCopyWith<$Res>
    implements $SetEntryCopyWith<$Res> {
  factory _$$SetEntryImplCopyWith(
    _$SetEntryImpl value,
    $Res Function(_$SetEntryImpl) then,
  ) = __$$SetEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String exerciseEntryId,
    SetType setType,
    int orderIndex,
    int reps,
    WeightValue? weight,
    double? rpe,
    String? tempo,
    int? restSeconds,
    String? notes,
    DateTime createdAt,
    DateTime updatedAt,
  });

  @override
  $WeightValueCopyWith<$Res>? get weight;
}

/// @nodoc
class __$$SetEntryImplCopyWithImpl<$Res>
    extends _$SetEntryCopyWithImpl<$Res, _$SetEntryImpl>
    implements _$$SetEntryImplCopyWith<$Res> {
  __$$SetEntryImplCopyWithImpl(
    _$SetEntryImpl _value,
    $Res Function(_$SetEntryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SetEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? exerciseEntryId = null,
    Object? setType = null,
    Object? orderIndex = null,
    Object? reps = null,
    Object? weight = freezed,
    Object? rpe = freezed,
    Object? tempo = freezed,
    Object? restSeconds = freezed,
    Object? notes = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$SetEntryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        exerciseEntryId: null == exerciseEntryId
            ? _value.exerciseEntryId
            : exerciseEntryId // ignore: cast_nullable_to_non_nullable
                  as String,
        setType: null == setType
            ? _value.setType
            : setType // ignore: cast_nullable_to_non_nullable
                  as SetType,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        weight: freezed == weight
            ? _value.weight
            : weight // ignore: cast_nullable_to_non_nullable
                  as WeightValue?,
        rpe: freezed == rpe
            ? _value.rpe
            : rpe // ignore: cast_nullable_to_non_nullable
                  as double?,
        tempo: freezed == tempo
            ? _value.tempo
            : tempo // ignore: cast_nullable_to_non_nullable
                  as String?,
        restSeconds: freezed == restSeconds
            ? _value.restSeconds
            : restSeconds // ignore: cast_nullable_to_non_nullable
                  as int?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
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

class _$SetEntryImpl implements _SetEntry {
  const _$SetEntryImpl({
    required this.id,
    required this.exerciseEntryId,
    required this.setType,
    required this.orderIndex,
    required this.reps,
    this.weight,
    this.rpe,
    this.tempo,
    this.restSeconds,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final String exerciseEntryId;
  @override
  final SetType setType;
  @override
  final int orderIndex;
  @override
  final int reps;
  @override
  final WeightValue? weight;
  @override
  final double? rpe;
  @override
  final String? tempo;
  @override
  final int? restSeconds;
  @override
  final String? notes;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'SetEntry(id: $id, exerciseEntryId: $exerciseEntryId, setType: $setType, orderIndex: $orderIndex, reps: $reps, weight: $weight, rpe: $rpe, tempo: $tempo, restSeconds: $restSeconds, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SetEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.exerciseEntryId, exerciseEntryId) ||
                other.exerciseEntryId == exerciseEntryId) &&
            (identical(other.setType, setType) || other.setType == setType) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.rpe, rpe) || other.rpe == rpe) &&
            (identical(other.tempo, tempo) || other.tempo == tempo) &&
            (identical(other.restSeconds, restSeconds) ||
                other.restSeconds == restSeconds) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    exerciseEntryId,
    setType,
    orderIndex,
    reps,
    weight,
    rpe,
    tempo,
    restSeconds,
    notes,
    createdAt,
    updatedAt,
  );

  /// Create a copy of SetEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SetEntryImplCopyWith<_$SetEntryImpl> get copyWith =>
      __$$SetEntryImplCopyWithImpl<_$SetEntryImpl>(this, _$identity);
}

abstract class _SetEntry implements SetEntry {
  const factory _SetEntry({
    required final String id,
    required final String exerciseEntryId,
    required final SetType setType,
    required final int orderIndex,
    required final int reps,
    final WeightValue? weight,
    final double? rpe,
    final String? tempo,
    final int? restSeconds,
    final String? notes,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$SetEntryImpl;

  @override
  String get id;
  @override
  String get exerciseEntryId;
  @override
  SetType get setType;
  @override
  int get orderIndex;
  @override
  int get reps;
  @override
  WeightValue? get weight;
  @override
  double? get rpe;
  @override
  String? get tempo;
  @override
  int? get restSeconds;
  @override
  String? get notes;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of SetEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SetEntryImplCopyWith<_$SetEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
