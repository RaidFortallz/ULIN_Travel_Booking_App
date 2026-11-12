import 'package:ulin/core/error/failure.dart';
import 'package:ulin/core/storage/token_storage.dart';
import 'package:ulin/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ulin/features/auth/data/datasources/google_auth_data_source.dart';
import 'package:ulin/features/auth/domain/entities/app_user.dart';
import 'package:ulin/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final GoogleAuthDataSource _google;
  final TokenStorage _tokens;

  AuthRepositoryImpl(this._remote, this._google, this._tokens);

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required bool terms,
  }) {
    return _remote.register(
      name: name,
      email: email,
      password: password,
      terms: terms,
    );
  }

  @override
  Future<AppUser> login({
    required String email,
    required String password,
    required bool remember,
  }) async {
    final session = await _remote.login(email, password);
    await _tokens.save(session.token, persist: remember);
    return session.user;
  }

  @override
  Future<AppUser> loginWithGoogle({required bool remember}) async {
    final idToken = await _google.getIdToken();

    if (idToken == null) {
      throw const Failure('Google sign-in was cancelled.', code: 'cancelled');
    }

    final session = await _remote.loginWithGoogle(idToken);
    await _tokens.save(session.token, persist: remember);
    return session.user;
  }

  @override
  Future<AppUser?> restoreSession() async {
    final token = await _tokens.read();
    if (token == null) return null;

    try {
      return await _remote.me();
    } on Failure catch (f) {
      if (f.statusCode == 401) {
        await _tokens.clear();
        return null;
      }
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remote.logout();
    } on Failure catch (_) {}
    await clearLocalSession();
  }

  @override
  Future<void> clearLocalSession() async {
    await _tokens.clear();
    await _google.signOut();
  }

  @override
  Future<int> sendVerificationCode() async {
    try {
      return await _remote.sendVerificationCode();
    } on Failure catch (f) {
      if (f.statusCode == 429 && f.retryAfter != null) {
        return f.retryAfter!;
      }
      rethrow;
    }
  }

  @override
  Future<AppUser> verifyEmail(String code) => _remote.verifyEmail(code);

  @override
  Future<void> forgotPassword(String email) => _remote.forgotPassword(email);

  @override
  Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
  }) {
    return _remote.resetPassword(email: email, code: code, password: password);
  }
}
