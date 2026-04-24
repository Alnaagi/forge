import 'package:freezed_annotation/freezed_annotation.dart';

part 'percentage_value.freezed.dart';

@freezed
class PercentageValue with _$PercentageValue {
  @Assert('value >= 0 && value <= 100', 'Percentage must be between 0 and 100.')
  const factory PercentageValue({required double value}) = _PercentageValue;
}
