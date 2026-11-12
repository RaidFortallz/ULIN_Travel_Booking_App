import 'package:ulin/core/state/request_cubit.dart';
import 'package:ulin/features/auth/domain/repositories/auth_repository.dart';

class RegisterCubit extends RequestCubit<Object> {
  final AuthRepository _repository;

  RegisterCubit(this._repository);

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required bool terms,
  }) {
    return run(() async {
      await _repository.register(
        name: name,
        email: email,
        password: password,
        terms: terms,
      );
      return null;
    });
  }
}
