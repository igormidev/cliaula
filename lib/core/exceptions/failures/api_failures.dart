import 'package:cliaula/core/exceptions/custom_exception.dart';

abstract class ApiFailure extends CustomException {
  const ApiFailure({
    required this.code,
    required super.message,
    required super.description,
  });

  /// The code of the error. We will use it to typify the error later.
  final String? code;
}

/// This error will be used when we get a error casting the json from the api
/// to a dart object with `fromMap` or `fromJson`.
class ApiFailureCastingObject extends ApiFailure implements ContainsStackTrace {
  const ApiFailureCastingObject({
    required this.response,
    required this.error,
    required this.stackTrace,
  }) : super(
          code: null,
          message: 'An error occurred while handling server data.',
          description: 'Try again latter. If the error persists, '
              'please contact support.',
        );

  @override
  final Object error;

  @override
  final StackTrace stackTrace;

  final dynamic response;

  @override
  String toString() =>
      'ApiFailureCastingObject(error: $error, stackTrace: $stackTrace';
}

class ApiFailureInvalidResponse extends ApiFailure
    implements ContainsStackTrace {
  const ApiFailureInvalidResponse({
    required String code,
    required this.response,
    required this.error,
    required this.stackTrace,
  }) : super(
          code: code,
          message: 'An unknown error has occurred',
          description: 'Try again. You can also try closing the '
              'application. If the error persists, contact support.',
        );

  @override
  final Object error;

  @override
  final StackTrace stackTrace;

  final dynamic response;

  @override
  String toString() =>
      'ApiFailureInvalidResponse(code: $code, error: $error, stackTrace: $stackTrace)';
}

class ApiFailureUnknownFailure extends ApiFailure
    implements ContainsStackTrace {
  const ApiFailureUnknownFailure({
    required String code,
    required this.error,
    required this.stackTrace,
  }) : super(
          code: code,
          message: 'An unknown error has occurred',
          description: 'Try again. You can also try closing the '
              'application. If the error persists, contact support.',
        );

  @override
  final Object error;

  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'ApiFailureUnknownFailure(code: $code, error: $error, stackTrace: $stackTrace)';
  }
}

class ApiFailureObjectNotFound extends ApiFailure
    implements ContainsStackTrace {
  const ApiFailureObjectNotFound({
    required String code,
    String? description,
    required this.error,
    required this.stackTrace,
  }) : super(
          code: code,
          message: 'Desired result not found',
          description: description ??
              "Maybe the data that you are trying to obtain dosen't exists.",
        );

  @override
  final Object error;

  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'ApiFailureObjectNotFound(code: $code, description: $description, error: $error, stackTrace: $stackTrace)';
  }
}

class ApiFailureInternalError extends ApiFailure implements ContainsStackTrace {
  const ApiFailureInternalError({
    required String code,
    String? description,
    required this.error,
    required this.stackTrace,
  }) : super(
          code: code,
          message: 'Our server is congested',
          description: description ??
              'The problem is currently being analyzed by our technicians. '
                  'Please, try again later.',
        );

  @override
  final Object error;

  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'ApiFailureInternalError(code: $code, description: $description, error: $error, stackTrace: $stackTrace)';
  }
}

class ApiFailureUnauthenticated extends ApiFailure
    implements ContainsStackTrace {
  const ApiFailureUnauthenticated({
    required String code,
    String? description,
    required this.error,
    required this.stackTrace,
  }) : super(
          code: code,
          message: 'You need to be authenticated to access this data',
          description:
              description ?? 'Please authenticate yourself and try again.',
        );

  @override
  final Object error;

  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'ApiFailureUnauthenticated(code: $code, description: $description, error: $error, stackTrace: $stackTrace)';
  }
}

class ApiFailureNoInternet extends ApiFailure implements ContainsStackTrace {
  const ApiFailureNoInternet({
    required String code,
    required String? description,
    required this.error,
    required this.stackTrace,
  }) : super(
          code: code,
          message: 'No internet.',
          description: description ??
              'The device is not connected to the internet or has an unstable connection.',
        );

  @override
  final Object error;

  @override
  final StackTrace stackTrace;

  @override
  String toString() {
    return 'ApiFailureUnauthenticated(code: $code, description: $description, error: $error, stackTrace: $stackTrace)';
  }
}

class ApiFailureUnautorized extends ApiFailure implements ContainsStackTrace {
  const ApiFailureUnautorized({
    required String code,
    String? description,
    required this.error,
    required this.stackTrace,
  }) : super(
          code: code,
          message: 'You are not authorized to view this content',
          description: description ??
              'You do not have the required permission to '
                  'perform this operation.',
        );

  @override
  final Object error;

  @override
  final StackTrace stackTrace;
  @override
  String toString() {
    return 'ApiFailureUnautorized(code: $code, description: $description, error: $error, stackTrace: $stackTrace)';
  }
}
