import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@lazySingleton
class LoggingInterceptor extends Interceptor {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 75,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i(
      'REQUEST[${options.method}] => PATH: ${options.baseUrl}${options.path}\n'
      'Headers: ${options.headers}\n'
      'Query Parameters: ${options.queryParameters}\n'
      'Data: ${options.data}',
    );
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}\n'
      'Data: ${response.data}',
    );
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}\n'
      'Message: ${err.message}\n'
      'Error: ${err.error}\n'
      'Response: ${err.response?.data}',
    );
    return handler.next(err);
  }
}
