import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:ptac_invoice/core/utils/user_preference.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/dashboard_models.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardResponseModel> getDashboardData();
}

@LazySingleton(as: DashboardRemoteDataSource)
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio _dio;

  DashboardRemoteDataSourceImpl(this._dio);

  @override
  Future<DashboardResponseModel> getDashboardData() async {
    try {
      final token = UserPreference.accessToken;

      if (token.isEmpty) {
        throw ServerException('Access token not found');
      }

      debugPrint('📊 === DASHBOARD DATA REQUEST ===');
      debugPrint('📍 URL: ${ApiConstants.baseUrl}${ApiConstants.dashboard}');
      debugPrint('🎫 Token: ${token.substring(0, 15)}...');
      debugPrint('================================\n');

      final response = await _dio.post(
        ApiConstants.dashboard,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      debugPrint('📥 === DASHBOARD RESPONSE ===');
      debugPrint('📊 Status Code: ${response.statusCode}');
      debugPrint('📦 Raw Response Type: ${response.data.runtimeType}');
      debugPrint('================================\n');

      if (response.statusCode != 200) {
        throw ServerException(
          'Dashboard request failed with status: ${response.statusCode}',
        );
      }

      // 🔐 SAFELY NORMALIZE RESPONSE
      dynamic responseData = response.data;

      // Handle string response (backend error OR JSON as string)
      if (responseData is String) {
        debugPrint('🧪 RAW STRING RESPONSE (first 500 chars):');
        debugPrint(
          responseData.length > 500
              ? responseData.substring(0, 500)
              : responseData,
        );
        // Detect backend SQL / HTML error
        if (responseData.contains('<pre>') ||
            responseData.contains('SQLSTATE') ||
            responseData.contains('stored procedure')) {
          throw ServerException(
            'Server error occurred while loading dashboard data',
          );
        }

        responseData = jsonDecode(responseData);
      }

      if (responseData is! Map<String, dynamic>) {
        throw ServerException('Invalid dashboard response format');
      }

      // ✅ Business logic
      if (responseData['status'] == true) {
        debugPrint('✅ Dashboard data loaded successfully');
        debugPrint(
          '📌 User Data Count: ${(responseData['data']['userData'] as List).length}',
        );
        debugPrint(
          '📌 Branch Count: ${(responseData['data']['branch'] as List).length}',
        );
        debugPrint(
          '📌 Form Data Count: ${(responseData['data']['formData'] as List).length}',
        );

        return DashboardResponseModel.fromJson(responseData);
      } else {
        throw ServerException(
          responseData['message'] ?? 'Failed to load dashboard data',
        );
      }
    } on DioException catch (e) {
      debugPrint('🔴 === DIO EXCEPTION (Dashboard) ===');
      debugPrint('❌ Type: ${e.type}');
      debugPrint('❌ Message: ${e.message}');
      debugPrint('❌ Status: ${e.response?.statusCode}');
      debugPrint('❌ Data: ${e.response?.data}');
      debugPrint('====================================\n');

      if (e.response?.statusCode == 401) {
        throw ServerException('Unauthorized. Please login again.');
      }

      throw ServerException(e.message ?? 'Network error occurred');
    } catch (e, stackTrace) {
      debugPrint('🔴 === UNEXPECTED ERROR (Dashboard) ===');
      debugPrint('❌ Error: $e');
      debugPrint('❌ Stack Trace: $stackTrace');
      debugPrint('========================================\n');

      if (e is ServerException) rethrow;
      throw ServerException('An unexpected error occurred');
    }
  }
}
