import 'package:equatable/equatable.dart';

/// Base structural class for all domain-level failures.
/// Extending Equatable ensures object comparison works out-of-the-box
/// when BLoC states are evaluating state changes.
abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}

/// Triggered when domain business rules are violated (e.g., invalid date ranges)
final class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Triggered when local storage (Isar, Secure Storage) failures occur
final class CacheFailure extends Failure {
  const CacheFailure(super.message, {super.statusCode});
}

/// Triggered by network failures, timeout limits, or 500-range backend responses
final class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.statusCode});
}

/// Explicitly triggered when a token refresh fails or a 401 Unauthorized is intercepted
final class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message, {super.statusCode});
}
