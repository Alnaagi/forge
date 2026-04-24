import 'package:drift/drift.dart';
import 'package:forge/data/local/db/app_database.dart';
import 'package:forge/domain/entities/body_log.dart';
import 'package:forge/shared/value_objects/measurement_value.dart';
import 'package:forge/shared/value_objects/percentage_value.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

extension BodyLogDataMapper on BodyLogsTableData {
  BodyLog toDomain() {
    return BodyLog(
      id: id,
      loggedAt: loggedAt,
      bodyWeight:
          originalWeightValue != null &&
              originalWeightUnit != null &&
              canonicalWeightKilograms != null
          ? WeightValue(
              originalValue: originalWeightValue!,
              originalUnit: originalWeightUnit!,
              canonicalKilograms: canonicalWeightKilograms!,
            )
          : null,
      bodyFatPercentage: bodyFatPercentage != null
          ? PercentageValue(value: bodyFatPercentage!)
          : null,
      waist:
          originalWaistValue != null &&
              originalWaistUnit != null &&
              canonicalWaistCentimeters != null
          ? MeasurementValue(
              originalValue: originalWaistValue!,
              originalUnit: originalWaistUnit!,
              canonicalCentimeters: canonicalWaistCentimeters!,
            )
          : null,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

extension BodyLogCompanionMapper on BodyLog {
  BodyLogsTableCompanion toCompanion() {
    return BodyLogsTableCompanion(
      id: Value(id),
      loggedAt: Value(loggedAt),
      originalWeightValue: Value(bodyWeight?.originalValue),
      originalWeightUnit: Value(bodyWeight?.originalUnit),
      canonicalWeightKilograms: Value(bodyWeight?.canonicalKilograms),
      bodyFatPercentage: Value(bodyFatPercentage?.value),
      originalWaistValue: Value(waist?.originalValue),
      originalWaistUnit: Value(waist?.originalUnit),
      canonicalWaistCentimeters: Value(waist?.canonicalCentimeters),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }
}
