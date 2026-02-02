import 'package:flutter/material.dart';
import 'package:ptac_invoice/views/auth/presentation/pages/login_page.dart';
import 'package:ptac_invoice/views/custom_order/presentation/pages/customer_order_page.dart';
import 'package:ptac_invoice/views/dashboard/presentation/pages/dashboard_page.dart';

class AppRouter {
  // Route Names
  static const String login = '/login';
  static const String dashboard = '/';
  static const String partyMaster = '/party-master';
  static const String customerOrder = '/customer-order';
  static const String dispatch = '/dispatch';
  static const String receiptVoucher = '/receipt-voucher';
  static const String paymentVoucher = '/payment-voucher';
  static const String salesRegister = '/sales-register';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginPage(),
          settings: settings,
        );

      case dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardPage(),
          settings: settings,
        );

      case partyMaster:
        // return MaterialPageRoute(
        //   builder: (_) => const PartyMasterPage(),
        //   settings: settings,
        // );
        return _errorRoute('Party Master - Coming Soon');

      case customerOrder:
        return MaterialPageRoute(
          builder: (_) => const CustomerOrderPage(),
          settings: settings,
        );

      case dispatch:
        return _errorRoute('Dispatch - Coming Soon');

      case receiptVoucher:
        return _errorRoute('Receipt Voucher - Coming Soon');

      case paymentVoucher:
        return _errorRoute('Payment Voucher - Coming Soon');

      case salesRegister:
        return _errorRoute('Sales Register - Coming Soon');

      default:
        return _errorRoute('Route not found');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(message)),
      ),
    );
  }
}
