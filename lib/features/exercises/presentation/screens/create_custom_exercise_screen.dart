import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:forge/app/core/widgets/app_scaffold.dart';
import 'package:forge/features/exercises/presentation/controllers/exercise_library_controller.dart';

class CreateCustomExerciseScreen extends ConsumerStatefulWidget {
  const CreateCustomExerciseScreen({super.key});

  @override
  ConsumerState<CreateCustomExerciseScreen> createState() =>
      _CreateCustomExerciseScreenState();
}

class _CreateCustomExerciseScreenState
    extends ConsumerState<CreateCustomExerciseScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _muscleController;
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _muscleController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _muscleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final saveState = ref.watch(customExerciseControllerProvider);

    return AppScaffold(
      title: 'Custom Exercise',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _muscleController,
              decoration: const InputDecoration(
                labelText: 'Primary muscle group',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: saveState.isLoading ? null : _save,
              child: Text(saveState.isLoading ? 'Saving...' : 'Save Exercise'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (_nameController.text.trim().isEmpty ||
        _muscleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name and primary muscle group are required.'),
        ),
      );
      return;
    }

    await ref
        .read(customExerciseControllerProvider.notifier)
        .create(
          name: _nameController.text,
          primaryMuscleGroup: _muscleController.text,
          notes: _notesController.text,
        );

    if (!mounted) {
      return;
    }
    context.pop();
  }
}
