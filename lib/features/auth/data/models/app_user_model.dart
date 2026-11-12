import 'package:ulin/features/auth/domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  const AppUserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.emailVerified,
    required super.hasPassword,
    required super.profileCompleted,
    super.username,
    super.bio,
    super.phone,
    super.birthday,
    super.gender,
    super.location,
    super.avatarUrl,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] as Map<String, dynamic>?;

    return AppUserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      emailVerified: json['email_verified'] as bool,
      hasPassword: json['has_password'] as bool,
      profileCompleted: json['profile_completed'] as bool,
      username: profile?['username'] as String?,
      bio: profile?['bio'] as String?,
      phone: profile?['phone'] as String?,
      birthday: profile?['birthday'] as String?,
      gender: profile?['gender'] as String?,
      location: profile?['location'] as String?,
      avatarUrl: profile?['avatar_url'] as String?,
    );
  }
}
