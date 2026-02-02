import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:ptac_invoice/views/auth/data/models/login_models.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login(LoginRequestModel request);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      // Create Basic Auth credentials
      final credentials = '${request.username}:${request.password}';
      final base64Credentials = base64Encode(utf8.encode(credentials));

      // Log request details
      debugPrint('🔐 === LOGIN REQUEST ===');
      debugPrint('📍 URL: ${ApiConstants.baseUrl}${ApiConstants.login}');
      debugPrint('👤 Username: ${request.username}');
      debugPrint('🔑 Password: ${'*' * request.password.length}');
      debugPrint('🎫 Auth Header: Basic $base64Credentials');
      debugPrint('========================\n');

      final response = await _dio.post(
        ApiConstants.login,
        options: Options(
          headers: {
            'Authorization': 'Basic $base64Credentials',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          validateStatus: (status) {
            // Accept any status code to see the response
            return status != null && status < 500;
          },
        ),
      );

      // Log response details
      debugPrint('📥 === LOGIN RESPONSE ===');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📋 Headers: ${response.headers}');
      debugPrint('📦 Response Data: ${response.data}');
      debugPrint('📦 Response Type: ${response.data.runtimeType}');
      debugPrint('=========================\n');

      if (response.statusCode == 200) {
        dynamic responseData = response.data;

        // 👇 Handle string JSON response
        if (responseData is String) {
          responseData = jsonDecode(responseData);
        }

        if (responseData is Map<String, dynamic>) {
          debugPrint('✅ Response is Map');
          debugPrint('📌 Status: ${responseData['status']}');
          debugPrint('📌 Message: ${responseData['message']}');

          if (responseData['status'] == true) {
            return LoginResponseModel.fromJson(responseData);
          } else {
            throw ServerException(responseData['message'] ?? 'Login failed');
          }
        }

        throw ServerException('Invalid response format');
      } else if (response.statusCode == 401) {
        debugPrint('❌ Unauthorized - Invalid credentials');
        throw ServerException('Invalid username or password');
      } else {
        debugPrint('❌ Login failed with status: ${response.statusCode}');
        throw ServerException(
          'Login failed with status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      debugPrint('🔴 === DIO EXCEPTION ===');
      debugPrint('❌ Error Type: ${e.type}');
      debugPrint('❌ Error Message: ${e.message}');
      debugPrint('❌ Status Code: ${e.response?.statusCode}');
      debugPrint('❌ Response Data: ${e.response?.data}');
      debugPrint('❌ Request URL: ${e.requestOptions.uri}');
      debugPrint('❌ Request Headers: ${e.requestOptions.headers}');

      if (e.type == DioExceptionType.connectionTimeout) {
        debugPrint('❌ Connection timeout');
        throw ServerException('Connection timeout. Check your internet.');
      } else if (e.type == DioExceptionType.connectionError) {
        debugPrint('❌ Connection error - Cannot reach server');
        throw ServerException('Cannot reach server. Check base URL.');
      } else if (e.type == DioExceptionType.unknown) {
        debugPrint('❌ Unknown error: ${e.error}');
        throw ServerException('Network error: ${e.error}');
      } else if (e.response?.statusCode == 401) {
        debugPrint('❌ 401 Unauthorized');
        throw ServerException('Invalid username or password');
      }

      debugPrint('========================\n');
      throw ServerException(e.message ?? 'Network error occurred');
    } catch (e, stackTrace) {
      debugPrint('🔴 === UNEXPECTED ERROR ===');
      debugPrint('❌ Error: $e');
      debugPrint('❌ Stack Trace: $stackTrace');
      debugPrint('===========================\n');

      if (e is ServerException) rethrow;
      throw ServerException('An unexpected error occurred: $e');
    }
  }
}
