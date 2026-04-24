import 'package:freezed_annotation/freezed_annotation.dart';

part 'macro_target.freezed.dart';

@freezed
class MacroTarget with _$MacroTarget {
  @Assert('calories >= 0', 'Calories cannot be negative.')
  @Assert('proteinGrams >= 0', 'Protein cannot be negative.')
  @Assert('carbsGrams >= 0', 'Carbs cannot be negative.')
  @Assert('fatGrams >= 0', 'Fat cannot be negative.')
  const factory MacroTarget({
    required int calories,
    required double proteinGrams,
    required double carbsGrams,
    required double fatGrams,
  }) = _MacroTarget;
}
