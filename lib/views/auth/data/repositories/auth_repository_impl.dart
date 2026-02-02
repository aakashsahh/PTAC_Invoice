import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:ptac_invoice/views/auth/data/models/login_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/storage_constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/base_repository.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends BaseRepository implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final SharedPreferences _prefs;

  AuthRepositoryImpl(this._remoteDataSource, this._prefs);

  @override
  Future<Either<Failure, User>> login({
    required String username,
    required String password,
  }) async {
    return handleApiCall(() async {
      final request = LoginRequestModel(username: username, password: password);

      final response = await _remoteDataSource.login(request);

      // Save user data to shared preferences
      await _saveUserData(response);

      return response.toEntity();
    });
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _clearUserData();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to logout'));
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = _prefs.getString(StorageConstants.accessToken);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<String?> getToken() async {
    return _prefs.getString(StorageConstants.accessToken);
  }

  Future<void> _saveUserData(dynamic response) async {
    await _prefs.setString(StorageConstants.accessToken, response.data.tokenNo);
    await _prefs.setString(
      StorageConstants.companyName,
      response.data.companyName,
    );
    await _prefs.setString(StorageConstants.companyLogo, response.data.logo);
    await _prefs.setInt(StorageConstants.userStatus, response.data.status);
  }

  Future<void> _clearUserData() async {
    await _prefs.remove(StorageConstants.accessToken);
    await _prefs.remove(StorageConstants.companyName);
    await _prefs.remove(StorageConstants.companyLogo);
    await _prefs.remove(StorageConstants.userStatus);
  }
}
