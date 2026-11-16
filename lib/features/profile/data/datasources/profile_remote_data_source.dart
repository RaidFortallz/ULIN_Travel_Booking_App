import 'package:dio/dio.dart';
import 'package:ulin/core/error/failure.dart';
import 'package:ulin/features/auth/data/models/app_user_model.dart';

class ProfileRemoteDataSource {
  final Dio _dio;

  ProfileRemoteDataSource(this._dio);

  Future<AppUserModel> saveProfile(Map<String, dynamic> body) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        '/profile',
        data: body,
      );
      return _parse(response.data);
    } on DioException catch (e) {
      throw Failure.fromDio(e);
    }
  }

  Future<AppUserModel> uploadAvatar(String filePath) async {
    try {
      final form = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(filePath),
      });

      final response = await _dio.post<Map<String, dynamic>>(
        '/profile/avatar',
        data: form,
      );
      return _parse(response.data);
    } on DioException catch (e) {
      throw Failure.fromDio(e);
    }
  }

  AppUserModel _parse(Map<String, dynamic>? json) {
    final data = (json ?? {})['data'] as Map<String, dynamic>;
    return AppUserModel.fromJson(data['user'] as Map<String, dynamic>);
  }
}
