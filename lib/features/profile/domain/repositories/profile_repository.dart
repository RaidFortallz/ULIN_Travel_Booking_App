import 'package:ulin/features/auth/domain/entities/app_user.dart';

abstract class ProfileRepository {
  Future<AppUser> saveProfile({
    required String username,
    String? bio,
    String? phone,
    String? birthday,
    String? gender,
    String? location,
  });

  Future<AppUser> uploadAvatar(String filePath);
}
