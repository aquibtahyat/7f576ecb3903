import 'result.dart';

abstract base class Repository {
  Future<Result<T>> asyncGuard<T>(Future<T> Function() operation) async {
    try {
      final result = await operation();
      return Success<T>(result);
    } catch (e) {
      return Failure.mapExceptionToFailure(e);
    }
  }

  Result<T> guard<T>(T Function() operation) {
    try {
      final result = operation();
      return Success(result);
    } catch (e) {
      return Failure.mapExceptionToFailure(e);
    }
  }
}
