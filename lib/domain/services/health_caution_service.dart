import 'package:forge/domain/entities/health_profile.dart';
import 'package:forge/domain/entities/health_status_log.dart';

class HealthCautionService {
  const HealthCautionService();

  HealthFoodGuidance evaluateFood({
    required String foodName,
    HealthProfile? profile,
    required List<HealthStatusLog> activeLogs,
  }) {
    final normalizedFood = foodName.toLowerCase();
    final alerts = <HealthFoodAlert>[];
    final supportiveNotes = <String>[];

    if (profile != null) {
      for (final allergy in profile.allergies) {
        final allergen = allergy.toLowerCase();
        for (final keyword in _allergenKeywords[allergen] ?? [allergen]) {
          if (normalizedFood.contains(keyword)) {
            alerts.add(
              HealthFoodAlert(
                title: 'Allergy caution',
                message:
                    'This food looks like it may contain $allergy, which is listed in your health profile.',
              ),
            );
            break;
          }
        }
      }

      for (final medication in profile.medications) {
        final normalizedMedication = medication.toLowerCase();
        for (final interaction in _medicationInteractions) {
          if (interaction.medicationKeywords.any(
                normalizedMedication.contains,
              ) &&
              interaction.foodKeywords.any(normalizedFood.contains)) {
            alerts.add(
              HealthFoodAlert(
                title: 'Medication caution',
                message:
                    '${interaction.foodLabel} can interact with $medication. Double-check with your clinician or pharmacist if this applies to you.',
              ),
            );
          }
        }
      }
    }

    for (final log in activeLogs) {
      final symptomText = [
        log.title,
        ...log.symptomTags,
        log.notes ?? '',
      ].join(' ').toLowerCase();

      for (final rule in _symptomRules) {
        if (!rule.symptomKeywords.any(symptomText.contains)) {
          continue;
        }
        if (rule.foodKeywords.any(normalizedFood.contains)) {
          supportiveNotes.add(rule.supportiveNote);
        }
        if (rule.avoidKeywords.any(normalizedFood.contains)) {
          alerts.add(
            HealthFoodAlert(
              title: '${rule.label} caution',
              message: rule.avoidNote,
            ),
          );
        }
      }
    }

    return HealthFoodGuidance(
      alerts: alerts,
      supportiveNotes: supportiveNotes.toSet().toList(growable: false),
    );
  }

  List<String> buildGeneralAdvice({
    HealthProfile? profile,
    required List<HealthStatusLog> activeLogs,
  }) {
    final advice = <String>[];

    if (profile != null) {
      if (profile.allergies.isNotEmpty) {
        advice.add(
          'Allergy watch is active for: ${profile.allergies.join(', ')}.',
        );
      }
      if (profile.medications.isNotEmpty) {
        advice.add(
          'Medication checks are enabled for: ${profile.medications.join(', ')}.',
        );
      }
    }

    for (final log in activeLogs.take(3)) {
      final symptomText = [
        log.title,
        ...log.symptomTags,
      ].join(' ').toLowerCase();
      for (final rule in _symptomRules) {
        if (rule.symptomKeywords.any(symptomText.contains)) {
          advice.add(rule.generalAdvice);
          break;
        }
      }
    }

    return advice.toSet().toList(growable: false);
  }
}

class HealthFoodGuidance {
  const HealthFoodGuidance({
    required this.alerts,
    required this.supportiveNotes,
  });

  final List<HealthFoodAlert> alerts;
  final List<String> supportiveNotes;

  bool get hasAnySignals => alerts.isNotEmpty || supportiveNotes.isNotEmpty;
}

class HealthFoodAlert {
  const HealthFoodAlert({required this.title, required this.message});

  final String title;
  final String message;
}

class _MedicationInteractionRule {
  const _MedicationInteractionRule({
    required this.medicationKeywords,
    required this.foodKeywords,
    required this.foodLabel,
  });

  final List<String> medicationKeywords;
  final List<String> foodKeywords;
  final String foodLabel;
}

class _SymptomFoodRule {
  const _SymptomFoodRule({
    required this.label,
    required this.symptomKeywords,
    required this.foodKeywords,
    required this.avoidKeywords,
    required this.supportiveNote,
    required this.avoidNote,
    required this.generalAdvice,
  });

  final String label;
  final List<String> symptomKeywords;
  final List<String> foodKeywords;
  final List<String> avoidKeywords;
  final String supportiveNote;
  final String avoidNote;
  final String generalAdvice;
}

const _allergenKeywords = <String, List<String>>{
  'peanut': ['peanut'],
  'nuts': ['nut', 'almond', 'cashew', 'walnut', 'pistachio'],
  'milk': ['milk', 'cheese', 'yogurt', 'cream'],
  'lactose': ['milk', 'cheese', 'yogurt', 'cream'],
  'egg': ['egg', 'mayo'],
  'soy': ['soy', 'tofu'],
  'gluten': ['bread', 'pasta', 'wheat'],
  'shellfish': ['shrimp', 'prawn', 'crab', 'lobster'],
};

const _medicationInteractions = <_MedicationInteractionRule>[
  _MedicationInteractionRule(
    medicationKeywords: ['warfarin'],
    foodKeywords: ['spinach', 'kale', 'broccoli'],
    foodLabel: 'Leafy greens',
  ),
  _MedicationInteractionRule(
    medicationKeywords: ['atorvastatin', 'simvastatin', 'statin'],
    foodKeywords: ['grapefruit'],
    foodLabel: 'Grapefruit',
  ),
  _MedicationInteractionRule(
    medicationKeywords: ['metronidazole', 'flagyl'],
    foodKeywords: ['beer', 'wine', 'alcohol'],
    foodLabel: 'Alcohol',
  ),
  _MedicationInteractionRule(
    medicationKeywords: ['phenelzine', 'tranylcypromine', 'maoi'],
    foodKeywords: ['aged cheese', 'salami', 'soy sauce'],
    foodLabel: 'High-tyramine foods',
  ),
];

const _symptomRules = <_SymptomFoodRule>[
  _SymptomFoodRule(
    label: 'Stomach',
    symptomKeywords: ['stomach', 'nausea', 'vomit', 'diarrhea'],
    foodKeywords: ['banana', 'rice', 'toast', 'ginger', 'soup'],
    avoidKeywords: ['spicy', 'fried', 'alcohol'],
    supportiveNote: 'This may be gentler on your stomach right now.',
    avoidNote:
        'This food could be rough on your stomach based on your current status.',
    generalAdvice:
        'Stomach symptoms logged: focus on hydration and gentler foods until things settle.',
  ),
  _SymptomFoodRule(
    label: 'Migraine',
    symptomKeywords: ['migraine', 'headache'],
    foodKeywords: ['water', 'banana', 'soup'],
    avoidKeywords: ['alcohol', 'energy drink', 'aged cheese'],
    supportiveNote: 'This may be easier to tolerate during a headache window.',
    avoidNote:
        'Some people find this can make headaches worse, so treat it carefully.',
    generalAdvice:
        'Migraine or headache logged: keep hydration and meal timing consistent and be careful with known triggers.',
  ),
  _SymptomFoodRule(
    label: 'Fatigue',
    symptomKeywords: ['fatigue', 'tired', 'exhausted'],
    foodKeywords: ['oats', 'eggs', 'yogurt', 'chicken'],
    avoidKeywords: ['energy drink', 'candy'],
    supportiveNote: 'This looks more supportive for steady energy.',
    avoidNote:
        'This may spike and crash energy while you are already run down.',
    generalAdvice:
        'Fatigue logged: prioritize fluids, steady meals, and sleep rather than chasing quick sugar hits.',
  ),
];
