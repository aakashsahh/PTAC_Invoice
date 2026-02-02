import 'package:shared_preferences/shared_preferences.dart';

import '../constants/storage_constants.dart';
import '../di/injection.dart';

/// Helper class to easily access stored user data
///
/// Usage:
/// ```dart
/// final companyName = StorageHelper.companyName;
/// final token = StorageHelper.accessToken;
/// ```
class UserPreference {
  // Private constructor to prevent instantiation
  UserPreference._();

  /// Get SharedPreferences instance from GetIt
  static SharedPreferences get _prefs => getIt<SharedPreferences>();

  // ============ GETTERS ============

  /// Get company name from storage
  /// Returns empty string if not found
  static String get companyName =>
      _prefs.getString(StorageConstants.companyName) ?? '';

  /// Get company logo URL from storage
  /// Returns empty string if not found
  static String get companyLogo =>
      _prefs.getString(StorageConstants.companyLogo) ?? '';

  /// Get access token from storage
  /// Returns empty string if not found
  static String get accessToken =>
      _prefs.getString(StorageConstants.accessToken) ?? '';

  /// Get user status from storage
  /// Returns 0 if not found
  /// Status: 1 = Active, 0 = Inactive
  static int get userStatus => _prefs.getInt(StorageConstants.userStatus) ?? 0;

  /// Check if user is logged in
  /// Returns true if access token exists
  static bool get isLoggedIn => accessToken.isNotEmpty;

  /// Check if user is active
  /// Returns true if user status is 1
  static bool get isActive => userStatus == 1;

  /// Get all user data as a map
  static Map<String, dynamic> get userData => {
    'companyName': companyName,
    'companyLogo': companyLogo,
    'accessToken': accessToken,
    'userStatus': userStatus,
    'isLoggedIn': isLoggedIn,
    'isActive': isActive,
  };

  // ============ SETTERS ============

  /// Update company name in storage
  static Future<bool> setCompanyName(String name) async {
    return await _prefs.setString(StorageConstants.companyName, name);
  }

  /// Update company logo URL in storage
  static Future<bool> setCompanyLogo(String url) async {
    return await _prefs.setString(StorageConstants.companyLogo, url);
  }

  /// Update access token in storage
  static Future<bool> setAccessToken(String token) async {
    return await _prefs.setString(StorageConstants.accessToken, token);
  }

  /// Update user status in storage
  static Future<bool> setUserStatus(int status) async {
    return await _prefs.setInt(StorageConstants.userStatus, status);
  }

  // ============ CHECKERS ============

  /// Check if a specific key exists in storage
  static bool hasKey(String key) {
    return _prefs.containsKey(key);
  }

  /// Check if company name is stored
  static bool get hasCompanyName =>
      hasKey(StorageConstants.companyName) && companyName.isNotEmpty;

  /// Check if token is stored
  static bool get hasToken =>
      hasKey(StorageConstants.accessToken) && accessToken.isNotEmpty;

  // ============ CLEAR METHODS ============

  /// Clear all stored user data (logout)
  static Future<void> clearAll() async {
    await _prefs.remove(StorageConstants.accessToken);
    await _prefs.remove(StorageConstants.companyName);
    await _prefs.remove(StorageConstants.companyLogo);
    await _prefs.remove(StorageConstants.userStatus);
  }

  /// Clear only authentication data (keep other app settings)
  static Future<void> clearAuthData() async {
    await _prefs.remove(StorageConstants.accessToken);
    await _prefs.remove(StorageConstants.refreshToken);
  }

  /// Clear specific key
  static Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// Clear all app data
  static Future<bool> clearAllData() async {
    return await _prefs.clear();
  }
}
