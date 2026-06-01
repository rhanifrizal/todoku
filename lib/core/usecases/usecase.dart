import 'package:todoku/core/errors/failures.dart';

/// Abstract contract for all Domain Use Cases.
/// [Type] is what the Use Case returns inside the record payload.
/// [Params] is the configuration data class passed into the execution window.
abstract interface class UseCase<Type, Params> {
  Future<(Failure?, Type?)> call(Params params);
}

/// A marker class used when a Use Case requires no execution parameters.
final class NoParams {
  const NoParams();
}
