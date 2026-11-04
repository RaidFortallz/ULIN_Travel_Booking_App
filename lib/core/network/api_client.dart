import 'package:dio/dio.dart';
import 'package:ulin/core/config/app_config.dart';
import 'package:ulin/core/network/auth_interceptor.dart';
import 'package:ulin/core/network/session_expired_notifier.dart';
import 'package:ulin/core/storage/token_storage.dart';

Dio createDio(TokenStorage tokenStorage, SessionExpiredNotifier notifier) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 20),
      headers: {'Accept': 'application/json'},
    ),
  );

  dio.interceptors.add(AuthInterceptor(tokenStorage, notifier.notify));

  return dio;
}
