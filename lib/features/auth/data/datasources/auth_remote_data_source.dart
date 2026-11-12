import 'package:dio/dio.dart';
import 'package:ulin/core/error/failure.dart';
import 'package:ulin/features/auth/data/models/app_user_model.dart';

typedef AuthSession = ({String token, AppUserModel user});

class AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSource(this._dio);

  Future<Map<String, dynamic>> _send(
    String method,
    String path, {
    Object? data,
  }) async {
    try {
      final response = await _dio.request<Map<String, dynamic>>(
        path,
        data: data,
        options: Options(method: method),
      );
      return response.data ?? {};
    } on DioException catch (e) {
      throw Failure.fromDio(e);
    }
  }

  AuthSession _parseSession(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return (
      token: data['token'] as String,
      user: AppUserModel.fromJson(data['user'] as Map<String, dynamic>),
    );
  }

  AppUserModel _parseUser(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return AppUserModel.fromJson(data['user'] as Map<String, dynamic>);
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required bool terms,
  }) async {
    await _send(
      'POST',
      '/auth/register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'terms': terms,
      },
    );
  }

  Future<AuthSession> login(String email, String password) async {
    final json = await _send(
      'POST',
      '/auth/login',
      data: {
        'email': email,
        'password': password,
        'device_name': 'ulin-mobile',
      },
    );
    return _parseSession(json);
  }

  Future<AuthSession> loginWithGoogle(String idToken) async {
    final json = await _send(
      'POST',
      '/auth/google',
      data: {'id_token': idToken, 'device_name': 'ulin-mobile'},
    );
    return _parseSession(json);
  }

  Future<AppUserModel> me() async {
    final json = await _send('GET', '/auth/me');
    return _parseUser(json);
  }

  Future<void> logout() async {
    await _send('POST', '/auth/logout');
  }

  Future<int> sendVerificationCode() async {
    final json = await _send('POST', '/email/verification-code');
    final data = json['data'] as Map<String, dynamic>?;
    return (data?['resend_in'] as int?) ?? 60;
  }

  Future<AppUserModel> verifyEmail(String code) async {
    final json = await _send('POST', '/email/verify', data: {'code': code});
    return _parseUser(json);
  }

  Future<void> forgotPassword(String email) async {
    await _send('POST', '/auth/forgot-password', data: {'email': email});
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    await _send(
      'POST',
      '/auth/reset-password',
      data: {'email': email, 'code': code, 'password': password},
    );
  }
}
