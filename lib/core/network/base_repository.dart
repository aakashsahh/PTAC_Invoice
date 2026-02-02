import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';

abstract class BaseRepository {
  Future<Either<Failure, T>> handleApiCall<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('Connection timeout. Please try again.');

      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);

      case DioExceptionType.cancel:
        return ServerFailure('Request cancelled');

      case DioExceptionType.unknown:
        if (error.error.toString().contains('SocketException')) {
          return NetworkFailure('No internet connection');
        }
        return ServerFailure('Unexpected error occurred');

      default:
        return ServerFailure('Unexpected error occurred');
    }
  }

  Failure _handleResponseError(Response? response) {
    final statusCode = response?.statusCode ?? 0;

    switch (statusCode) {
      case 400:
        return ServerFailure(_extractErrorMessage(response) ?? 'Bad request');
      case 401:
        return ServerFailure('Unauthorized. Please login again.');
      case 403:
        return ServerFailure('Access forbidden');
      case 404:
        return ServerFailure('Resource not found');
      case 500:
        return ServerFailure('Internal server error');
      case 503:
        return ServerFailure('Service unavailable');
      default:
        return ServerFailure(
          _extractErrorMessage(response) ?? 'Error occurred: $statusCode',
        );
    }
  }

  String? _extractErrorMessage(Response? response) {
    try {
      if (response?.data is Map) {
        final data = response!.data as Map<String, dynamic>;
        return data['message'] ?? data['error'] ?? data['msg'];
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
