import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/routes_name.dart';
import 'core/services/getit_services.dart';
import 'features/auth/presentation/cubit/auth_session/auth_session_cubit.dart';
import 'features/auth/presentation/cubit/login/login_cubit.dart';
import 'features/auth/presentation/cubit/otp/otp_cubit.dart';
import 'features/auth/presentation/cubit/register/register_cubit.dart';
import 'features/customers/presentation/cubit/customers/customers_cubit.dart';
import 'features/inventory/presentation/cubit/inventory_categories/inventory_categories_cubit.dart';
import 'features/inventory/presentation/cubit/inventory_items/inventory_items_cubit.dart';
import 'features/inventory/presentation/cubit/low_stock/low_stock_cubit.dart';
import 'features/inventory/presentation/cubit/low_stock_count/low_stock_count_cubit.dart';
import 'features/inventory/presentation/cubit/stock_movements/stock_movements_cubit.dart';
import 'features/notification/presentation/cubit/notification_settings/notification_settings_cubit.dart';
import 'features/notification/presentation/cubit/notifications_list/notifications_list_cubit.dart';

void main() {
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthSessionCubit>(
          create: (_) => getIt<AuthSessionCubit>(),
        ),
        BlocProvider<LoginCubit>(create: (_) => getIt<LoginCubit>()),
        BlocProvider<RegisterCubit>(create: (_) => getIt<RegisterCubit>()),
        BlocProvider<OtpCubit>(create: (_) => getIt<OtpCubit>()),
        BlocProvider<CustomersCubit>(create: (_) => getIt<CustomersCubit>()),
        BlocProvider<InventoryItemsCubit>(
          create: (_) => getIt<InventoryItemsCubit>(),
        ),
        BlocProvider<InventoryCategoriesCubit>(
          create: (_) => getIt<InventoryCategoriesCubit>(),
        ),
        BlocProvider<StockMovementsCubit>(
          create: (_) => getIt<StockMovementsCubit>(),
        ),
        BlocProvider<LowStockCubit>(create: (_) => getIt<LowStockCubit>()),
        BlocProvider<LowStockCountCubit>(
          create: (_) => getIt<LowStockCountCubit>(),
        ),
        BlocProvider<NotificationSettingsCubit>(
          create: (_) => getIt<NotificationSettingsCubit>(),
        ),
        BlocProvider<NotificationsListCubit>(
          create: (_) => getIt<NotificationsListCubit>(),
        ),
      ],
      child: MaterialApp( 
        title: 'Restflow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(),
        initialRoute: RoutesName.splash,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
