import 'dart:io';

import 'package:dio/dio.dart';

import 'app_failure.dart';

class ErrorHandler {
  const ErrorHandler._();

  static AppFailure handle(Object error) {
    if (error is DioException) {
      return _handleDioError(error);
    }
    if (error is SocketException) {
      return const AppFailure(
        type: FailureType.network,
        message: 'No internet connection.',
      );
    }
    if (error is FormatException || error is TypeError) {
      return const AppFailure(
        type: FailureType.serialization,
        message: 'Failed to process data.',
      );
    }
    return AppFailure(type: FailureType.unknown, message: error.toString());
  }

  static AppFailure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppFailure(
          type: FailureType.timeout,
          message: 'Request timed out. Please try again.',
        );
      case DioExceptionType.connectionError:
        return const AppFailure(
          type: FailureType.network,
          message: 'No internet connection.',
        );
      case DioExceptionType.badResponse:
        return const AppFailure(
          type: FailureType.server,
          message: 'Unexpected server response.',
        );
      case DioExceptionType.badCertificate:
      case DioExceptionType.cancel:
      case DioExceptionType.unknown:
        return AppFailure(
          type: FailureType.unknown,
          message: error.message ?? 'Unexpected error occurred.',
        );
    }
  }
}
