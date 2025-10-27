import 'package:fpdart/fpdart.dart';
import 'package:merchant/core/failure/failure.dart';

TaskEither<Failure, R> tryCatchWithFailure<R>(Future<R> Function() f) {
  return TaskEither.tryCatch(f, (error, stackTrace) {
    if (error is Failure) {
      return error;
    }
    return Failure.server(error.toString());
  });
}
