import 'package:equatable/equatable.dart';

class AppUser extends Equatable {
  final int id;
  final String name;
  final String email;
  final bool emailVerified;
  final bool hasPassword;
  final bool profileCompleted;
  final String? username;
  final String? bio;
  final String? phone;
  final String? birthday;
  final String? gender;
  final String? location;
  final String? avatarUrl;

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerified,
    required this.hasPassword,
    required this.profileCompleted,
    this.username,
    this.bio,
    this.phone,
    this.birthday,
    this.gender,
    this.location,
    this.avatarUrl,
  });

  String get displayName =>
      (username != null && username!.isNotEmpty) ? username! : name;

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    emailVerified,
    hasPassword,
    profileCompleted,
    username,
    bio,
    phone,
    birthday,
    gender,
    location,
    avatarUrl,
  ];
}
