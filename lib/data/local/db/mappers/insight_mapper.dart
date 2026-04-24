import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/insight.dart';

extension InsightDataMapper on InsightsTableData {
  Insight toDomain() {
    return Insight(
      id: id,
      category: category,
      severity: severity,
      status: status,
      title: title,
      shortMessage: shortMessage,
      fullExplanation: fullExplanation,
      evidenceJson: evidenceJson,
      confidence: confidence,
      suggestedAction: suggestedAction,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension InsightCompanionMapper on Insight {
  InsightsTableCompanion toCompanion() {
    return InsightsTableCompanion(
      id: Value(id),
      category: Value(category),
      severity: Value(severity),
      status: Value(status),
      title: Value(title),
      shortMessage: Value(shortMessage),
      fullExplanation: Value(fullExplanation),
      evidenceJson: Value(evidenceJson),
      confidence: Value(confidence),
      suggestedAction: Value(suggestedAction),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
