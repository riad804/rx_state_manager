sealed class Failure {
  final String message;
  final Object? error;
  final StackTrace? stackTrace;
  const Failure(this.message, {this.error, this.stackTrace});
}


class NetworkFailure extends Failure {
  const NetworkFailure(super.message, {super.error, super.stackTrace});
}


class ParsingFailure extends Failure {
  const ParsingFailure(super.message, {super.error, super.stackTrace});
}


class UnknownFailure extends Failure {
  const UnknownFailure(super.message, {super.error, super.stackTrace});
}