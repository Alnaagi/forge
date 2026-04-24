import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/shared/enums/insight_category.dart';
import 'package:forge/shared/enums/insight_severity.dart';
import 'package:forge/shared/enums/insight_status.dart';

part 'insight.freezed.dart';

@freezed
class Insight with _$Insight {
  const factory Insight({
    required String id,
    required InsightCategory category,
    required InsightSeverity severity,
    required InsightStatus status,
    required String title,
    required String shortMessage,
    required String fullExplanation,
    required String evidenceJson,
    required double confidence,
    required String suggestedAction,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Insight;
}
