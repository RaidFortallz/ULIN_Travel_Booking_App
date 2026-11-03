import 'package:dio/dio.dart';

class Failure implements Exception {
  final String message;
  final String? code;
  final int? statusCode;
  final int? retryAfter;
  final Map<String, String> fieldErrors;

  const Failure(
    this.message, {
    this.code,
    this.statusCode,
    this.retryAfter,
    this.fieldErrors = const {},
  });

  factory Failure.fromDio(DioException e) {
    final response = e.response;

    if (response == null) {
      return const Failure(
        'Cannot reach the server. Check your connection and try again.',
      );
    }

    var message = 'Something went wrong. Please try again.';
    String? code;
    int? retryAfter;
    final fieldErrors = <String, String>{};

    final data = response.data;
    if (data is Map<String, dynamic>) {
      message = (data['message'] as String?) ?? message;
      code = data['code'] as String?;
      retryAfter = data['retry_after'] as int?;

      final errors = data['errors'];
      if (errors is Map<String, dynamic>) {
        errors.forEach((key, value) {
          if (value is List && value.isNotEmpty) {
            fieldErrors[key] = value.first.toString();
          }
        });
        if (fieldErrors.isNotEmpty) {
          message = fieldErrors.values.first;
        }
      }
    }

    return Failure(
      message,
      code: code,
      statusCode: response.statusCode,
      retryAfter: retryAfter,
      fieldErrors: fieldErrors,
    );
  }

  @override
  String toString() => message;
}
