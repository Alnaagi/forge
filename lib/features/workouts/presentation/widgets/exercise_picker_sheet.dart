import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:forge/app/core/widgets/app_panel.dart';
import 'package:forge/app/core/widgets/app_search_field.dart';
import 'package:forge/app/core/widgets/app_state_view.dart';
import 'package:forge/app/theme/app_spacing.dart';
import 'package:forge/application/providers/workout_providers.dart';
import 'package:forge/domain/entities/exercise.dart';

class ExercisePickerSheet extends ConsumerStatefulWidget {
  const ExercisePickerSheet({this.title = 'Pick Exercise', super.key});

  final String title;

  @override
  ConsumerState<ExercisePickerSheet> createState() =>
      _ExercisePickerSheetState();
}

class _ExercisePickerSheetState extends ConsumerState<ExercisePickerSheet> {
  String _query = '';
  late Future<List<Exercise>> _future;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _future = _load();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<Exercise>> _load() {
    return ref
        .read(exerciseRepositoryProvider)
        .getAll(query: _query.trim().isEmpty ? null : _query.trim());
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
      _future = _load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: AppPanel(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSpacing.md),
              AppSearchField(
                controller: _searchController,
                hintText: 'Search exercises',
                onChanged: _onSearchChanged,
              ),
              const SizedBox(height: AppSpacing.md),
              Flexible(
                child: FutureBuilder<List<Exercise>>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return AppErrorState(message: snapshot.error.toString());
                    }
                    if (!snapshot.hasData) {
                      return const AppLoadingView(label: 'Loading exercises');
                    }

                    final exercises = snapshot.data!;
                    if (exercises.isEmpty) {
                      return const AppEmptyState(
                        icon: Icons.search_off,
                        title: 'No exercises found',
                        message:
                            'Try a broader search or create a custom exercise.',
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        final exercise = exercises[index];
                        return ListTile(
                          title: Text(exercise.name),
                          subtitle: Text(exercise.primaryMuscleGroup),
                          onTap: () => Navigator.of(context).pop(exercise),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
