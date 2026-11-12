import 'package:ulin/core/state/request_cubit.dart';
import 'package:ulin/features/auth/domain/repositories/auth_repository.dart';

class PasswordResetCubit extends RequestCubit<Object> {
  final AuthRepository _repository;

  PasswordResetCubit(this._repository);

  Future<void> forgotPassword(String email) {
    return run(() async {
      await _repository.forgotPassword(email);
      return null;
    });
  }

  Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
  }) {
    return run(() async {
      await _repository.resetPassword(
        email: email,
        code: code,
        password: password,
      );
      return null;
    });
  }
}
