import 'package:ulin/features/auth/domain/entities/app_user.dart';
import 'package:ulin/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:ulin/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remote;

  ProfileRepositoryImpl(this._remote);

  @override
  Future<AppUser> saveProfile({
    required String username,
    String? bio,
    String? phone,
    String? birthday,
    String? gender,
    String? location,
  }) {
    final body = <String, dynamic>{
      'username': username,
      'bio': bio,
      'phone': phone,
      'birthday': birthday,
      'gender': gender,
      'location': location,
    }..removeWhere((key, value) => value == null);

    return _remote.saveProfile(body);
  }

  @override
  Future<AppUser> uploadAvatar(String filePath) {
    return _remote.uploadAvatar(filePath);
  }
}
