import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ulin/core/network/api_client.dart';
import 'package:ulin/core/network/session_expired_notifier.dart';
import 'package:ulin/core/storage/token_storage.dart';


final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage(getIt()));
  getIt.registerLazySingleton<SessionExpiredNotifier>(
    () => SessionExpiredNotifier(),
  );
  getIt.registerLazySingleton<Dio>(() => createDio(getIt(), getIt()));

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<GoogleAuthDataSource>(
    () => GoogleAuthDataSource(),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt(), getIt(), getIt()),
  );

  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<AuthBloc>(() => AuthBloc(getIt(), getIt()));
  getIt.registerFactory<RegisterCubit>(() => RegisterCubit(getIt()));
  getIt.registerFactory<EmailVerificationCubit>(
    () => EmailVerificationCubit(getIt()),
  );
  getIt.registerFactory<PasswordResetCubit>(() => PasswordResetCubit(getIt()));
  getIt.registerFactory<ProfileCubit>(() => ProfileCubit(getIt()));
}