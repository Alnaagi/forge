import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:forge/app/core/errors/failure.dart';

part 'result.freezed.dart';

@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T value) = Success<T>;
  const factory Result.failure(Failure failure) = ResultFailure<T>;
}
