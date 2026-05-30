enum FailureType { network, timeout, serialization, server, unknown }

class AppFailure {
  const AppFailure({required this.type, required this.message});

  final FailureType type;
  final String message;

  @override
  String toString() => message;
}
