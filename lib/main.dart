import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/routes_name.dart';
import 'core/services/getit_services.dart';
import 'features/auth/presentation/cubit/login/login_cubit.dart';
import 'features/auth/presentation/cubit/otp/otp_cubit.dart';
import 'features/auth/presentation/cubit/register/register_cubit.dart';
import 'features/customers/presentation/cubit/customers/customers_cubit.dart';

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
        BlocProvider<LoginCubit>(create: (_) => getIt<LoginCubit>()),
        BlocProvider<RegisterCubit>(create: (_) => getIt<RegisterCubit>()),
        BlocProvider<OtpCubit>(create: (_) => getIt<OtpCubit>()),
        BlocProvider<CustomersCubit>(create: (_) => getIt<CustomersCubit>()),
      ],
      child: MaterialApp(
        title: 'Restflow Auth',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'Georgia',
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF0F6F5C),
            secondary: Color(0xFFF4A261),
            surface: Color(0xFFF7F3EB),
            surfaceContainerHighest: Color(0xFFEDE6D9),
            outlineVariant: Color(0xFFDED4C6),
            onSurface: Color(0xFF1B1B1B),
            onSurfaceVariant: Color(0xFF5B5247),
          ),
        ),
        initialRoute: RoutesName.customersTest,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
