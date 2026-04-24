import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_setting.freezed.dart';

@freezed
class AppSetting with _$AppSetting {
  const factory AppSetting({
    required String key,
    required String value,
    required DateTime updatedAt,
  }) = _AppSetting;
}
