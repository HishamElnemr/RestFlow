import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/cubit/login/login_cubit.dart';
import '../../features/auth/presentation/cubit/otp/otp_cubit.dart';
import '../../features/auth/presentation/cubit/register/register_cubit.dart';
import '../../features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import '../../features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import '../../features/auth/presentation/cubit/change_password/change_password_cubit.dart';
import '../../features/auth/presentation/cubit/auth_session/auth_session_cubit.dart';
import '../../features/customers/data/repositories/customers_repository_impl.dart';
import '../../features/customers/domain/repositories/customers_repository.dart';
import '../../features/customers/presentation/cubit/customers/customers_cubit.dart';
import '../../features/inventory/data/repositories/inventory_repository_impl.dart';
import '../../features/inventory/domain/repositories/inventory_repository.dart';
import '../../features/inventory/presentation/cubit/inventory_categories/inventory_categories_cubit.dart';
import '../../features/inventory/presentation/cubit/inventory_items/inventory_items_cubit.dart';
import '../../features/inventory/presentation/cubit/low_stock/low_stock_cubit.dart';
import '../../features/inventory/presentation/cubit/low_stock_count/low_stock_count_cubit.dart';
import '../../features/inventory/presentation/cubit/stock_movements/stock_movements_cubit.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/presentation/cubit/notification_settings/notification_settings_cubit.dart';
import '../../features/settings/presentation/cubit/user_profile_settings/user_profile_settings_cubit.dart';
import '../../features/settings/presentation/cubit/restaurant_settings/restaurant_settings_cubit.dart';
import '../../features/reports/data/repositories/reports_repository_impl.dart';
import '../../features/reports/domain/repositories/reports_repository.dart';
import '../../features/reports/presentation/cubit/reports/reports_cubit.dart';
import '../constants/api_constants.dart';
import 'auth_api_service.dart';
import 'auth_interceptor.dart';
import 'customers_api_service.dart';
import 'inventory_api_service.dart';
import 'reports_api_service.dart';
import 'secure_storage_service.dart';
import 'settings_api_service.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  // ── Storage ──────────────────────────────────────────────────────────────
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );

  // ── Network (Dio + Auth Interceptor) ─────────────────────────────────────
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    dio.interceptors.add(AuthInterceptor(getIt<SecureStorageService>()));
    return dio;
  });

  // ── API Services ──────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(getIt<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  getIt.registerLazySingleton<CustomersApiService>(
    () => CustomersApiService(getIt<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  getIt.registerLazySingleton<InventoryApiService>(
    () => InventoryApiService(getIt<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  getIt.registerLazySingleton<SettingsApiService>(
    () => SettingsApiService(getIt<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  getIt.registerLazySingleton<ReportsApiService>(
    () => ReportsApiService(getIt<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  // ── Repositories ──────────────────────────────────────────────────────────
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiService: getIt<AuthApiService>(),
      secureStorage: getIt<SecureStorageService>(),
    ),
  );

  getIt.registerLazySingleton<CustomersRepository>(
    () => CustomersRepositoryImpl(apiService: getIt<CustomersApiService>()),
  );

  getIt.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(apiService: getIt<InventoryApiService>()),
  );

  getIt.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(apiService: getIt<SettingsApiService>()),
  );

  getIt.registerLazySingleton<ReportsRepository>(
    () => ReportsRepositoryImpl(apiService: getIt<ReportsApiService>()),
  );

  // ── Cubits / ViewModels ───────────────────────────────────────────────────
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<AuthRepository>()));

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<AuthRepository>()),
  );

  getIt.registerFactory<OtpCubit>(() => OtpCubit(getIt<AuthRepository>()));

  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(getIt<AuthRepository>()),
  );

  getIt.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(getIt<AuthRepository>()),
  );

  getIt.registerFactory<ChangePasswordCubit>(
    () => ChangePasswordCubit(getIt<AuthRepository>()),
  );

  getIt.registerFactory<AuthSessionCubit>(
    () => AuthSessionCubit(getIt<AuthRepository>()),
  );

  getIt.registerFactory<CustomersCubit>(
    () => CustomersCubit(getIt<CustomersRepository>()),
  );

  getIt.registerFactory<InventoryItemsCubit>(
    () => InventoryItemsCubit(getIt<InventoryRepository>()),
  );

  getIt.registerFactory<InventoryCategoriesCubit>(
    () => InventoryCategoriesCubit(getIt<InventoryRepository>()),
  );

  getIt.registerFactory<StockMovementsCubit>(
    () => StockMovementsCubit(getIt<InventoryRepository>()),
  );

  getIt.registerFactory<LowStockCubit>(
    () => LowStockCubit(getIt<InventoryRepository>()),
  );

  getIt.registerFactory<LowStockCountCubit>(
    () => LowStockCountCubit(getIt<InventoryRepository>()),
  );

  getIt.registerFactory<NotificationSettingsCubit>(
    () => NotificationSettingsCubit(getIt<SettingsRepository>()),
  );

  getIt.registerFactory<UserProfileSettingsCubit>(
    () => UserProfileSettingsCubit(getIt<SettingsRepository>()),
  );

  getIt.registerFactory<RestaurantSettingsCubit>(
    () => RestaurantSettingsCubit(getIt<SettingsRepository>()),
  );

  getIt.registerFactory<ReportsCubit>(
    () => ReportsCubit(getIt<ReportsRepository>()),
  );
}
