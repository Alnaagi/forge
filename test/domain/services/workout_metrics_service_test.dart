import 'package:flutter_test/flutter_test.dart';
import 'package:forge/domain/entities/set_entry.dart';
import 'package:forge/domain/services/e1rm_service.dart';
import 'package:forge/domain/services/pr_detection_service.dart';
import 'package:forge/domain/services/volume_service.dart';
import 'package:forge/domain/services/workout_metrics_service.dart';
import 'package:forge/shared/enums/set_type.dart';
import 'package:forge/shared/enums/weight_unit.dart';
import 'package:forge/shared/unit_system/unit_converter.dart';

const _service = WorkoutMetricsService(
  unitConverter: UnitConverter(),
  e1rmService: E1rmService(),
  volumeService: VolumeService(),
  prDetectionService: PrDetectionService(),
);

void main() {
  test('warm-up sets never qualify for PR detection', () {
    final candidate = _buildSet(
      id: 'warmup',
      setType: SetType.warmUp,
      originalWeightValue: 100,
      reps: 5,
    );

    final isPr = _service.isPersonalRecord(
      candidate: candidate,
      previousSets: [
        _buildSet(
          id: 'previous',
          setType: SetType.normal,
          originalWeightValue: 90,
          reps: 5,
        ),
      ],
    );

    expect(isPr, isFalse);
  });

  test('drop sets never qualify for PR detection', () {
    final candidate = _buildSet(
      id: 'drop',
      setType: SetType.drop,
      originalWeightValue: 100,
      reps: 8,
    );

    final isPr = _service.isPersonalRecord(
      candidate: candidate,
      previousSets: const [],
    );

    expect(isPr, isFalse);
  });

  test('failure sets never qualify for PR detection', () {
    final candidate = _buildSet(
      id: 'failure',
      setType: SetType.failure,
      originalWeightValue: 110,
      reps: 6,
    );

    final isPr = _service.isPersonalRecord(
      candidate: candidate,
      previousSets: const [],
    );

    expect(isPr, isFalse);
  });

  test('special sets do not block a later normal-set PR', () {
    final candidate = _buildSet(
      id: 'normal',
      setType: SetType.normal,
      originalWeightValue: 100,
      reps: 5,
    );

    final isPr = _service.isPersonalRecord(
      candidate: candidate,
      previousSets: [
        _buildSet(
          id: 'drop-previous',
          setType: SetType.drop,
          originalWeightValue: 120,
          reps: 10,
        ),
      ],
    );

    expect(isPr, isTrue);
  });
}

SetEntry _buildSet({
  required String id,
  required SetType setType,
  required double originalWeightValue,
  required int reps,
}) {
  final now = DateTime(2026, 4, 13, 12);
  return SetEntry(
    id: id,
    exerciseEntryId: 'entry-1',
    setType: setType,
    orderIndex: 0,
    reps: reps,
    weight: _service.createWeightValue(
      originalValue: originalWeightValue,
      originalUnit: WeightUnit.kilograms,
    ),
    rpe: null,
    tempo: null,
    restSeconds: null,
    notes: null,
    createdAt: now,
    updatedAt: now,
  );
}
