// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'insight.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Insight {
  String get id => throw _privateConstructorUsedError;
  InsightCategory get category => throw _privateConstructorUsedError;
  InsightSeverity get severity => throw _privateConstructorUsedError;
  InsightStatus get status => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get shortMessage => throw _privateConstructorUsedError;
  String get fullExplanation => throw _privateConstructorUsedError;
  String get evidenceJson => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String get suggestedAction => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Create a copy of Insight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InsightCopyWith<Insight> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InsightCopyWith<$Res> {
  factory $InsightCopyWith(Insight value, $Res Function(Insight) then) =
      _$InsightCopyWithImpl<$Res, Insight>;
  @useResult
  $Res call({
    String id,
    InsightCategory category,
    InsightSeverity severity,
    InsightStatus status,
    String title,
    String shortMessage,
    String fullExplanation,
    String evidenceJson,
    double confidence,
    String suggestedAction,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$InsightCopyWithImpl<$Res, $Val extends Insight>
    implements $InsightCopyWith<$Res> {
  _$InsightCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Insight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? severity = null,
    Object? status = null,
    Object? title = null,
    Object? shortMessage = null,
    Object? fullExplanation = null,
    Object? evidenceJson = null,
    Object? confidence = null,
    Object? suggestedAction = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as InsightCategory,
            severity: null == severity
                ? _value.severity
                : severity // ignore: cast_nullable_to_non_nullable
                      as InsightSeverity,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as InsightStatus,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            shortMessage: null == shortMessage
                ? _value.shortMessage
                : shortMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            fullExplanation: null == fullExplanation
                ? _value.fullExplanation
                : fullExplanation // ignore: cast_nullable_to_non_nullable
                      as String,
            evidenceJson: null == evidenceJson
                ? _value.evidenceJson
                : evidenceJson // ignore: cast_nullable_to_non_nullable
                      as String,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            suggestedAction: null == suggestedAction
                ? _value.suggestedAction
                : suggestedAction // ignore: cast_nullable_to_non_nullable
                      as String,
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
}

/// @nodoc
abstract class _$$InsightImplCopyWith<$Res> implements $InsightCopyWith<$Res> {
  factory _$$InsightImplCopyWith(
    _$InsightImpl value,
    $Res Function(_$InsightImpl) then,
  ) = __$$InsightImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    InsightCategory category,
    InsightSeverity severity,
    InsightStatus status,
    String title,
    String shortMessage,
    String fullExplanation,
    String evidenceJson,
    double confidence,
    String suggestedAction,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$InsightImplCopyWithImpl<$Res>
    extends _$InsightCopyWithImpl<$Res, _$InsightImpl>
    implements _$$InsightImplCopyWith<$Res> {
  __$$InsightImplCopyWithImpl(
    _$InsightImpl _value,
    $Res Function(_$InsightImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Insight
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? category = null,
    Object? severity = null,
    Object? status = null,
    Object? title = null,
    Object? shortMessage = null,
    Object? fullExplanation = null,
    Object? evidenceJson = null,
    Object? confidence = null,
    Object? suggestedAction = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$InsightImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as InsightCategory,
        severity: null == severity
            ? _value.severity
            : severity // ignore: cast_nullable_to_non_nullable
                  as InsightSeverity,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as InsightStatus,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        shortMessage: null == shortMessage
            ? _value.shortMessage
            : shortMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        fullExplanation: null == fullExplanation
            ? _value.fullExplanation
            : fullExplanation // ignore: cast_nullable_to_non_nullable
                  as String,
        evidenceJson: null == evidenceJson
            ? _value.evidenceJson
            : evidenceJson // ignore: cast_nullable_to_non_nullable
                  as String,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        suggestedAction: null == suggestedAction
            ? _value.suggestedAction
            : suggestedAction // ignore: cast_nullable_to_non_nullable
                  as String,
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

class _$InsightImpl implements _Insight {
  const _$InsightImpl({
    required this.id,
    required this.category,
    required this.severity,
    required this.status,
    required this.title,
    required this.shortMessage,
    required this.fullExplanation,
    required this.evidenceJson,
    required this.confidence,
    required this.suggestedAction,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  final String id;
  @override
  final InsightCategory category;
  @override
  final InsightSeverity severity;
  @override
  final InsightStatus status;
  @override
  final String title;
  @override
  final String shortMessage;
  @override
  final String fullExplanation;
  @override
  final String evidenceJson;
  @override
  final double confidence;
  @override
  final String suggestedAction;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Insight(id: $id, category: $category, severity: $severity, status: $status, title: $title, shortMessage: $shortMessage, fullExplanation: $fullExplanation, evidenceJson: $evidenceJson, confidence: $confidence, suggestedAction: $suggestedAction, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InsightImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.shortMessage, shortMessage) ||
                other.shortMessage == shortMessage) &&
            (identical(other.fullExplanation, fullExplanation) ||
                other.fullExplanation == fullExplanation) &&
            (identical(other.evidenceJson, evidenceJson) ||
                other.evidenceJson == evidenceJson) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.suggestedAction, suggestedAction) ||
                other.suggestedAction == suggestedAction) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    category,
    severity,
    status,
    title,
    shortMessage,
    fullExplanation,
    evidenceJson,
    confidence,
    suggestedAction,
    createdAt,
    updatedAt,
  );

  /// Create a copy of Insight
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InsightImplCopyWith<_$InsightImpl> get copyWith =>
      __$$InsightImplCopyWithImpl<_$InsightImpl>(this, _$identity);
}

abstract class _Insight implements Insight {
  const factory _Insight({
    required final String id,
    required final InsightCategory category,
    required final InsightSeverity severity,
    required final InsightStatus status,
    required final String title,
    required final String shortMessage,
    required final String fullExplanation,
    required final String evidenceJson,
    required final double confidence,
    required final String suggestedAction,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$InsightImpl;

  @override
  String get id;
  @override
  InsightCategory get category;
  @override
  InsightSeverity get severity;
  @override
  InsightStatus get status;
  @override
  String get title;
  @override
  String get shortMessage;
  @override
  String get fullExplanation;
  @override
  String get evidenceJson;
  @override
  double get confidence;
  @override
  String get suggestedAction;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Insight
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InsightImplCopyWith<_$InsightImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
