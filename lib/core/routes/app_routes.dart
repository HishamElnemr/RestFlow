import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import '../../features/auth/presentation/cubit/login/login_cubit.dart';
import '../../features/auth/presentation/cubit/otp/otp_cubit.dart';
import '../../features/auth/presentation/cubit/register/register_cubit.dart';
import '../../features/auth/presentation/cubit/reset_password/reset_password_cubit.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/otp_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/reset_password_page.dart';
import '../../features/customers/presentation/pages/customers_test_page.dart';
import '../../features/home/presentation/pages/employee_home_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/inventory/presentation/pages/inventory_test_page.dart';
import '../../features/inventory/presentation/pages/low_stock_alerts_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/settings/presentation/pages/notification_settings_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../services/getit_services.dart';
import 'routes_name.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
      case RoutesName.onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
          settings: settings,
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<LoginCubit>(),
            child: const LoginPage(),
          ),
          settings: settings,
        );
      case RoutesName.register:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<RegisterCubit>(),
            child: const RegisterPage(),
          ),
          settings: settings,
        );
      case RoutesName.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ForgotPasswordCubit>(),
            child: const ForgotPasswordPage(),
          ),
          settings: settings,
        );
      case RoutesName.otp:
        final args = settings.arguments;
        String email = '';
        bool isResetPassword = false;

        if (args is String) {
          email = args;
        } else if (args is Map<String, dynamic>) {
          email = args['email'] as String? ?? '';
          isResetPassword = args['isResetPassword'] as bool? ?? false;
        }

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<OtpCubit>(),
            child: OtpPage(email: email, isResetPassword: isResetPassword),
          ),
          settings: settings,
        );
      case RoutesName.resetPassword:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        final email = args['email'] as String? ?? '';
        final otpCode = args['otpCode'] as String? ?? '';

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ResetPasswordCubit>(),
            child: ResetPasswordPage(email: email, otpCode: otpCode),
          ),
          settings: settings,
        );

      case RoutesName.customersTest:
        return MaterialPageRoute(
          builder: (_) => const CustomersTestPage(),
          settings: settings,
        );
      case RoutesName.inventoryTest:
        return MaterialPageRoute(
          builder: (_) => const InventoryTestPage(),
          settings: settings,
        );
      case RoutesName.lowStockAlerts:
        return MaterialPageRoute(
          builder: (_) => const LowStockAlertsPage(),
          settings: settings,
        );
      case RoutesName.notificationSettings:
        return MaterialPageRoute(
          builder: (_) => const NotificationSettingsPage(),
          settings: settings,
        );
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
      case RoutesName.employeeHome:
        return MaterialPageRoute(
          builder: (_) => const EmployeeHomePage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
          settings: settings,
        );
    }
  }
}
