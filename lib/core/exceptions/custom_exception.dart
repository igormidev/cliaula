import 'package:dartz/dartz.dart';

abstract class CustomException implements Exception {
  const CustomException({required this.message, required this.description});

  final String message;
  final String description;
}

abstract class ContainsStackTrace {
  const ContainsStackTrace({
    required this.error,
    required this.stackTrace,
  });

  final Object error;
  final StackTrace stackTrace;
}

class UnknownError extends CustomException implements ContainsStackTrace {
  const UnknownError({
    required this.error,
    required this.stackTrace,
  }) : super(
          message: 'An unknown error has occurred',
          description: 'Try again. You can also try closing the '
              'application. If the error persists, contact support.',
        );

  @override
  final Object error;

  @override
  final StackTrace stackTrace;
}

typedef AsyncResp<T> = Future<Either<CustomException, T>>;
