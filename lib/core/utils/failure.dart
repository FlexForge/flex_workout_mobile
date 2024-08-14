import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed

/// Represents all app failures
class Failure implements Exception {
  const Failure._();

  /// Expected value is null or empty
  const factory Failure.empty() = _EmptyFailure;

  ///  Expected value has invalid format
  const factory Failure.unprocessableEntity({required String message}) =
      _UnprocessableEntityFailure;

  /// Represent 401 error
  const factory Failure.unauthorized() = _UnauthorizedFailure;

  /// Represents 400 error
  const factory Failure.badRequest() = _BadRequestFailure;

  /// Represents 500 error
  const factory Failure.internalServerError({String? message}) =
      _InternalServerErrorFailure;

  /// Get the error message for specified failure
  String get error {
    if (this is _UnprocessableEntityFailure) {
      return (this as _UnprocessableEntityFailure).message;
    }

    if (this is _InternalServerErrorFailure) {
      return (this as _InternalServerErrorFailure).message ?? '$this';
    }

    return '$this';
  }
}
