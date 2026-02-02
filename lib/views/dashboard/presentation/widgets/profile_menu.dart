import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptac_invoice/core/extensions/context_extensions.dart';
import 'package:ptac_invoice/core/router/app_router.dart';
import 'package:ptac_invoice/core/utils/user_preference.dart';
import 'package:ptac_invoice/views/dashboard/presentation/bloc/bloc/dashboard_bloc.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoaded && state.userData != null) {
                final userData = state.userData!;
                return Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: context.primaryColor.withOpacity(
                            0.1,
                          ),
                          child: Icon(
                            Icons.business,
                            size: 30,
                            color: context.primaryColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData.accountName,
                                style: context.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(userData.userRole, style: context.bodySmall),
                              Text(userData.userId, style: context.bodySmall),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              context.showSnackBar('PTAC Invoice v1.0.0');
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              Navigator.pop(context);
              await UserPreference.clearAll();
              if (context.mounted) {
                context.showSuccessSnackBar('Logged out successfully');
                context.pushNamedAndRemoveUntil(
                  AppRouter.login,
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
