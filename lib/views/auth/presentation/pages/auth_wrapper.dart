import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptac_invoice/core/di/injection.dart';
import 'package:ptac_invoice/views/auth/presentation/bloc/bloc/auth_bloc.dart';

import '../../../dashboard/presentation/pages/dashboard_page.dart';
import 'login_page.dart';

/// Auth wrapper to check authentication status on app start
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>()..add(const CheckAuthStatusEvent()),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading || state is AuthInitial) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (state is AuthAuthenticated) {
            return const DashboardPage();
          }

          return const LoginPage();
        },
      ),
    );
  }
}
