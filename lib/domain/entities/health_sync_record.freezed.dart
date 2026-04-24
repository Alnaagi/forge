// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'health_sync_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HealthSyncRecord {
  String get id => throw _privateConstructorUsedError;
  SyncSource get source => throw _privateConstructorUsedError;
  String get recordType => throw _privateConstructorUsedError;
  String? get externalId => throw _privateConstructorUsedError;
  String get payloadJson => throw _privateConstructorUsedError;
  DateTime get recordedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of HealthSyncRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HealthSyncRecordCopyWith<HealthSyncRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HealthSyncRecordCopyWith<$Res> {
  factory $HealthSyncRecordCopyWith(
    HealthSyncRecord value,
    $Res Function(HealthSyncRecord) then,
  ) = _$HealthSyncRecordCopyWithImpl<$Res, HealthSyncRecord>;
  @useResult
  $Res call({
    String id,
    SyncSource source,
    String recordType,
    String? externalId,
    String payloadJson,
    DateTime recordedAt,
    DateTime createdAt,
  });
}

/// @nodoc
class _$HealthSyncRecordCopyWithImpl<$Res, $Val extends HealthSyncRecord>
    implements $HealthSyncRecordCopyWith<$Res> {
  _$HealthSyncRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HealthSyncRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? source = null,
    Object? recordType = null,
    Object? externalId = freezed,
    Object? payloadJson = null,
    Object? recordedAt = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as SyncSource,
            recordType: null == recordType
                ? _value.recordType
                : recordType // ignore: cast_nullable_to_non_nullable
                      as String,
            externalId: freezed == externalId
                ? _value.externalId
                : externalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            payloadJson: null == payloadJson
                ? _value.payloadJson
                : payloadJson // ignore: cast_nullable_to_non_nullable
                      as String,
            recordedAt: null == recordedAt
                ? _value.recordedAt
                : recordedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HealthSyncRecordImplCopyWith<$Res>
    implements $HealthSyncRecordCopyWith<$Res> {
  factory _$$HealthSyncRecordImplCopyWith(
    _$HealthSyncRecordImpl value,
    $Res Function(_$HealthSyncRecordImpl) then,
  ) = __$$HealthSyncRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    SyncSource source,
    String recordType,
    String? externalId,
    String payloadJson,
    DateTime recordedAt,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$HealthSyncRecordImplCopyWithImpl<$Res>
    extends _$HealthSyncRecordCopyWithImpl<$Res, _$HealthSyncRecordImpl>
    implements _$$HealthSyncRecordImplCopyWith<$Res> {
  __$$HealthSyncRecordImplCopyWithImpl(
    _$HealthSyncRecordImpl _value,
    $Res Function(_$HealthSyncRecordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HealthSyncRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? source = null,
    Object? recordType = null,
    Object? externalId = freezed,
    Object? payloadJson = null,
    Object? recordedAt = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$HealthSyncRecordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as SyncSource,
        recordType: null == recordType
            ? _value.recordType
            : recordType // ignore: cast_nullable_to_non_nullable
                  as String,
        externalId: freezed == externalId
            ? _value.externalId
            : externalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        payloadJson: null == payloadJson
            ? _value.payloadJson
            : payloadJson // ignore: cast_nullable_to_non_nullable
                  as String,
        recordedAt: null == recordedAt
            ? _value.recordedAt
            : recordedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc

class _$HealthSyncRecordImpl implements _HealthSyncRecord {
  const _$HealthSyncRecordImpl({
    required this.id,
    required this.source,
    required this.recordType,
    this.externalId,
    required this.payloadJson,
    required this.recordedAt,
    required this.createdAt,
  });

  @override
  final String id;
  @override
  final SyncSource source;
  @override
  final String recordType;
  @override
  final String? externalId;
  @override
  final String payloadJson;
  @override
  final DateTime recordedAt;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'HealthSyncRecord(id: $id, source: $source, recordType: $recordType, externalId: $externalId, payloadJson: $payloadJson, recordedAt: $recordedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HealthSyncRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.recordType, recordType) ||
                other.recordType == recordType) &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.payloadJson, payloadJson) ||
                other.payloadJson == payloadJson) &&
            (identical(other.recordedAt, recordedAt) ||
                other.recordedAt == recordedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    source,
    recordType,
    externalId,
    payloadJson,
    recordedAt,
    createdAt,
  );

  /// Create a copy of HealthSyncRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HealthSyncRecordImplCopyWith<_$HealthSyncRecordImpl> get copyWith =>
      __$$HealthSyncRecordImplCopyWithImpl<_$HealthSyncRecordImpl>(
        this,
        _$identity,
      );
}

abstract class _HealthSyncRecord implements HealthSyncRecord {
  const factory _HealthSyncRecord({
    required final String id,
    required final SyncSource source,
    required final String recordType,
    final String? externalId,
    required final String payloadJson,
    required final DateTime recordedAt,
    required final DateTime createdAt,
  }) = _$HealthSyncRecordImpl;

  @override
  String get id;
  @override
  SyncSource get source;
  @override
  String get recordType;
  @override
  String? get externalId;
  @override
  String get payloadJson;
  @override
  DateTime get recordedAt;
  @override
  DateTime get createdAt;

  /// Create a copy of HealthSyncRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HealthSyncRecordImplCopyWith<_$HealthSyncRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
