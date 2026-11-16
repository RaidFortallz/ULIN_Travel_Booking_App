import 'package:ulin/core/state/request_cubit.dart';
import 'package:ulin/features/auth/domain/entities/app_user.dart';
import 'package:ulin/features/profile/domain/repositories/profile_repository.dart';

class ProfileCubit extends RequestCubit<AppUser> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository);

  Future<void> saveProfile({
    required String username,
    String? bio,
    String? phone,
    String? birthday,
    String? gender,
    String? location,
  }) {
    return run(
      () => _repository.saveProfile(
        username: username,
        bio: bio,
        phone: phone,
        birthday: birthday,
        gender: gender,
        location: location,
      ),
    );
  }

  Future<void> uploadAvatar(String filePath) {
    return run(() => _repository.uploadAvatar(filePath));
  }
}
