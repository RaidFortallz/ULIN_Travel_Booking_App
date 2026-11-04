import 'package:ulin/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required bool terms,
  });

  Future<AppUser> login({
    required String email,
    required String password,
    required bool remember,
  });

  Future<AppUser> loginWithGoogle({required bool remember});

  Future<AppUser?> restoreSession();

  Future<void> logout();

  Future<void> clearLocalSession();

  Future<int> sendVerificationCode();

  Future<AppUser> verifyEmail(String code);

  Future<void> forgotPassword(String email);

  Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
  });
}
