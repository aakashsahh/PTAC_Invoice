import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptac_invoice/core/di/injection.dart';
import 'package:ptac_invoice/core/extensions/responsive_extension.dart';
import 'package:ptac_invoice/views/auth/presentation/bloc/bloc/auth_bloc.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class PtacInvoiceApp extends StatelessWidget {
  const PtacInvoiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Device.setScreenSize(context, constraints);
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  getIt<AuthBloc>()..add(const CheckAuthStatusEvent()),
            ),
          ],
          child: MaterialApp(
            title: 'PTAC Invoice',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.light,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: AppRouter.login,
          ),
        );
      },
    );
  }
}
