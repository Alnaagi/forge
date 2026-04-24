import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/shared/enums/set_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/unit_system/unit_converter.dart';
import 'package:forge/shared/value_objects/weight_value.dart';

import 'e1rm_service.dart';
import 'pr_detection_service.dart';
import 'volume_service.dart';

class WorkoutMetricsService {
  const WorkoutMetricsService({
    required UnitConverter unitConverter,
    required E1rmService e1rmService,
    required VolumeService volumeService,
    required PrDetectionService prDetectionService,
  }) : _unitConverter = unitConverter,
       _e1rmService = e1rmService,
       _volumeService = volumeService,
       _prDetectionService = prDetectionService;

  final UnitConverter _unitConverter;
  final E1rmService _e1rmService;
  final VolumeService _volumeService;
  final PrDetectionService _prDetectionService;

  WeightValue createWeightValue({
    required double originalValue,
    required WeightUnit originalUnit,
  }) {
    return WeightValue(
      originalValue: originalValue,
      originalUnit: originalUnit,
      canonicalKilograms: _unitConverter.toKilograms(
        originalValue,
        originalUnit,
      ),
    );
  }

  double estimateOneRepMax(SetEntry setEntry) {
    final kilograms = setEntry.weight?.canonicalKilograms ?? 0;
    if (kilograms <= 0 || setEntry.reps <= 0) {
      return 0;
    }
    return _e1rmService.estimate(
      weightKilograms: kilograms,
      reps: setEntry.reps,
    );
  }

  double volumeForSet(SetEntry setEntry) {
    final kilograms = setEntry.weight?.canonicalKilograms ?? 0;
    if (kilograms <= 0 || setEntry.reps <= 0) {
      return 0;
    }
    return _volumeService.calculate(
      weightKilograms: kilograms,
      reps: setEntry.reps,
      sets: 1,
    );
  }

  bool isPersonalRecord({
    required SetEntry candidate,
    required Iterable<SetEntry> previousSets,
  }) {
    if (!_isPrEligible(candidate.setType)) {
      return false;
    }

    final candidateEstimate = estimateOneRepMax(candidate);
    if (candidateEstimate <= 0) {
      return false;
    }

    final previousBest = previousSets
        .where((setEntry) => _isPrEligible(setEntry.setType))
        .map(estimateOneRepMax)
        .fold<double>(0, (best, current) => current > best ? current : best);

    return _prDetectionService.isNewRepMax(
      currentEstimate: candidateEstimate,
      previousBestEstimate: previousBest,
    );
  }

  bool _isPrEligible(SetType setType) => setType == SetType.normal;
}
