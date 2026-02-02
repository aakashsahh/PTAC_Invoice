class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://api.srssoftwares.in';

  // Auth Endpoints
  static const String login = '/AndroidApp/auth.php';
  // Dashboard Endpoints
  static const String dashboard = '/AndroidApp/getuserdata.php';

  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Party Master Endpoints
  static const String parties = '/parties';
  static const String partyById = '/parties/{id}';

  // Customer Order Endpoints
  static const String orders = '/orders';
  static const String orderById = '/orders/{id}';

  // Dispatch Endpoints
  static const String dispatches = '/dispatches';
  static const String dispatchById = '/dispatches/{id}';

  // Receipt Voucher Endpoints
  static const String receiptVouchers = '/receipt-vouchers';
  static const String receiptVoucherById = '/receipt-vouchers/{id}';

  // Payment Voucher Endpoints
  static const String paymentVouchers = '/payment-vouchers';
  static const String paymentVoucherById = '/payment-vouchers/{id}';

  // Sales Register Endpoints
  static const String salesRegister = '/sales-register';

  // Dashboard Endpoints
  static const String dashboardStats = '/dashboard/stats';
}
