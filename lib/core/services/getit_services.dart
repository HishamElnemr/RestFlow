import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/cubit/login/login_cubit.dart';
import '../../features/auth/presentation/cubit/otp/otp_cubit.dart';
import '../../features/auth/presentation/cubit/register/register_cubit.dart';
import '../../features/customers/data/repositories/customers_repository_impl.dart';
import '../../features/customers/domain/repositories/customers_repository.dart';
import '../../features/customers/presentation/cubit/customers/customers_cubit.dart';
import '../../features/inventory/data/repositories/inventory_repository_impl.dart';
import '../../features/inventory/domain/repositories/inventory_repository.dart';
import '../../features/inventory/presentation/cubit/inventory_categories/inventory_categories_cubit.dart';
import '../../features/inventory/presentation/cubit/inventory_items/inventory_items_cubit.dart';
import '../../features/inventory/presentation/cubit/low_stock/low_stock_cubit.dart';
import '../../features/inventory/presentation/cubit/stock_movements/stock_movements_cubit.dart';
import '../constants/api_constants.dart';
import 'auth_api_service.dart';
import 'customers_api_service.dart';
import 'inventory_api_service.dart';
import 'secure_storage_service.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(baseUrl: ApiConstants.baseUrl)),
  );

  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(getIt<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  getIt.registerLazySingleton<CustomersApiService>(
    () => CustomersApiService(getIt<Dio>(), baseUrl: ApiConstants.baseUrl),
  );

  getIt.registerLazySingleton<InventoryApiService>(
    () => InventoryApiService(getIt<Dio>(), baseUrl: ApiConstants.baseUrl),
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

  getIt.registerLazySingleton<CustomersRepository>(
    () => CustomersRepositoryImpl(apiService: getIt<CustomersApiService>()),
  );

  getIt.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(apiService: getIt<InventoryApiService>()),
  );

  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt<AuthRepository>()));

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<AuthRepository>()),
  );

  getIt.registerFactory<OtpCubit>(() => OtpCubit(getIt<AuthRepository>()));

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
}
