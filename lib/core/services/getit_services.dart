import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/cubit/login/login_cubit.dart';
import '../../features/auth/presentation/cubit/otp/otp_cubit.dart';
import '../../features/auth/presentation/cubit/register/register_cubit.dart';
import '../constants/api_constants.dart';
import 'auth_api_service.dart';
import 'secure_storage_service.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: ApiConstants.baseUrl)),
  );

  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(getIt<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiService: getIt<AuthApiService>(),
      secureStorage: getIt<SecureStorageService>(),
    ),
  );

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<AuthRepository>()));

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<AuthRepository>()),
  );

  getIt.registerFactory<OtpCubit>(() => OtpCubit(getIt<AuthRepository>()));
}
