import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/exercise.dart';
import 'package:forge/domain/entities/workout_template.dart';
import 'package:forge/domain/entities/workout_template_detail.dart';
import 'package:forge/domain/entities/workout_template_item.dart';
import 'package:forge/features/templates/presentation/controllers/template_list_controller.dart';

class TemplateDraftItem {
  const TemplateDraftItem({
    required this.localId,
    required this.exercise,
    required this.targetSets,
    required this.targetReps,
    this.notes,
  });

  final String localId;
  final Exercise exercise;
  final int targetSets;
  final String targetReps;
  final String? notes;

  TemplateDraftItem copyWith({
    String? localId,
    Exercise? exercise,
    int? targetSets,
    String? targetReps,
    String? notes,
  }) {
    return TemplateDraftItem(
      localId: localId ?? this.localId,
      exercise: exercise ?? this.exercise,
      targetSets: targetSets ?? this.targetSets,
      targetReps: targetReps ?? this.targetReps,
      notes: notes ?? this.notes,
    );
  }
}

class TemplateBuilderState {
  const TemplateBuilderState({
    required this.templateId,
    required this.name,
    required this.notes,
    required this.items,
    required this.createdAt,
  });

  const TemplateBuilderState.initial()
    : templateId = null,
      name = '',
      notes = '',
      items = const [],
      createdAt = null;

  final String? templateId;
  final String name;
  final String notes;
  final List<TemplateDraftItem> items;
  final DateTime? createdAt;

  bool get canSave => name.trim().isNotEmpty && items.isNotEmpty;

  TemplateBuilderState copyWith({
    String? templateId,
    String? name,
    String? notes,
    List<TemplateDraftItem>? items,
    DateTime? createdAt,
  }) {
    return TemplateBuilderState(
      templateId: templateId ?? this.templateId,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      items: items ?? this.items,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

final templateBuilderControllerProvider =
    AsyncNotifierProvider.autoDispose<
      TemplateBuilderController,
      TemplateBuilderState
    >(TemplateBuilderController.new);

class TemplateBuilderController
    extends AutoDisposeAsyncNotifier<TemplateBuilderState> {
  @override
  FutureOr<TemplateBuilderState> build() {
    return const TemplateBuilderState.initial();
  }

  Future<void> load(String? templateId) async {
    if (templateId == null) {
      state = const AsyncData(TemplateBuilderState.initial());
      return;
    }

    state = const AsyncLoading();
    final repository = ref.read(workoutRepositoryProvider);
    final detail = await repository.getTemplateDetail(templateId);

    if (detail == null) {
      state = const AsyncData(TemplateBuilderState.initial());
      return;
    }

    state = AsyncData(_fromDetail(detail));
  }

  void setName(String value) {
    final current = state.valueOrNull ?? const TemplateBuilderState.initial();
    state = AsyncData(current.copyWith(name: value));
  }

  void setNotes(String value) {
    final current = state.valueOrNull ?? const TemplateBuilderState.initial();
    state = AsyncData(current.copyWith(notes: value));
  }

  void addExercise(Exercise exercise) {
    final current = state.valueOrNull ?? const TemplateBuilderState.initial();
    final uuid = ref.read(uuidServiceProvider);
    final items = [...current.items];
    items.add(
      TemplateDraftItem(
        localId: uuid.next(),
        exercise: exercise,
        targetSets: 3,
        targetReps: '8-12',
      ),
    );
    state = AsyncData(current.copyWith(items: items));
  }

  void updateItem({
    required String localId,
    int? targetSets,
    String? targetReps,
    String? notes,
  }) {
    final current = state.valueOrNull ?? const TemplateBuilderState.initial();
    final items = current.items
        .map(
          (item) => item.localId == localId
              ? item.copyWith(
                  targetSets: targetSets,
                  targetReps: targetReps,
                  notes: notes,
                )
              : item,
        )
        .toList(growable: false);
    state = AsyncData(current.copyWith(items: items));
  }

  void removeItem(String localId) {
    final current = state.valueOrNull ?? const TemplateBuilderState.initial();
    state = AsyncData(
      current.copyWith(
        items: current.items
            .where((item) => item.localId != localId)
            .toList(growable: false),
      ),
    );
  }

  Future<String?> save() async {
    final current = state.valueOrNull;
    if (current == null || !current.canSave) {
      return null;
    }

    state = const AsyncLoading();
    final repository = ref.read(workoutRepositoryProvider);
    final uuid = ref.read(uuidServiceProvider);
    final now = DateTime.now();
    final templateId = current.templateId ?? 'template-${uuid.next()}';
    final createdAt = current.createdAt ?? now;

    final template = WorkoutTemplate(
      id: templateId,
      name: current.name.trim(),
      notes: current.notes.trim().isEmpty ? null : current.notes.trim(),
      createdAt: createdAt,
      updatedAt: now,
    );

    final items = current.items
        .asMap()
        .entries
        .map((entry) {
          final draft = entry.value;
          return WorkoutTemplateItem(
            id: 'template-item-${uuid.next()}',
            templateId: templateId,
            exerciseId: draft.exercise.id,
            orderIndex: entry.key,
            targetSets: draft.targetSets,
            targetReps: draft.targetReps,
            notes: draft.notes,
            createdAt: now,
            updatedAt: now,
          );
        })
        .toList(growable: false);

    await repository.saveTemplate(template);
    await repository.replaceTemplateItems(templateId, items);
    ref.invalidate(workoutTemplatesProvider);
    state = AsyncData(
      current.copyWith(templateId: templateId, createdAt: createdAt),
    );
    return templateId;
  }

  TemplateBuilderState _fromDetail(WorkoutTemplateDetail detail) {
    return TemplateBuilderState(
      templateId: detail.template.id,
      name: detail.template.name,
      notes: detail.template.notes ?? '',
      items: detail.items
          .map(
            (item) => TemplateDraftItem(
              localId: item.item.id,
              exercise: item.exercise,
              targetSets: item.item.targetSets,
              targetReps: item.item.targetReps,
              notes: item.item.notes,
            ),
          )
          .toList(growable: false),
      createdAt: detail.template.createdAt,
    );
  }
}
