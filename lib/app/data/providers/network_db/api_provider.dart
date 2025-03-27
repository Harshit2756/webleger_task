import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/utils/extension/platform_helper.dart';
import '../../../../core/utils/helpers/logger.dart';
import '../../models/response_model.dart';
import '../../services/base_service.dart';

class ApiProvider extends BaseService {
  late Dio _dio;
  // final ErrorHandlerService _errorHandler = ErrorHandlerService();

  ApiProvider() {
    final timeout = const Duration(seconds: 60);
    _dio = Dio(
      BaseOptions(
        connectTimeout: timeout,
        receiveTimeout: timeout,
        sendTimeout: PlatformHelper.isWeb ? null : timeout,
        validateStatus: (status) => true,
        followRedirects: true,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final logMessage = options.data is FormData
              ? '''
            ${options.method} Request:
            URL: ${options.path} 
            Headers: ${_dio.options.headers}
            Form Data Fields: ${options.data.fields}
            Form Data Files: ${options.data.files.map((f) => '${f.key}: ${f.value.filename}')}
          '''
              : '''
            ${options.method} Request:
            URL: ${options.path}
            Headers: ${_dio.options.headers}
            Body: ${options.data}
          ''';

          HLoggerHelper.info(logMessage);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          final logMessage = '''
            ${response.statusCode} Response:
            URL: ${response.requestOptions.path}
            Headers: ${response.headers}
            Body: ${response.data}
          ''';
          HLoggerHelper.info(logMessage);
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          _handleError(e);
          return handler.next(e);
        },
      ),
    );
  }

  void setToken(String token) {
    if (token.isEmpty) {
      HLoggerHelper.warning('Warning: Empty token provided');
      return;
    }
    _dio.options.headers['Authorization'] = 'Bearer $token';
    HLoggerHelper.info('Headers after setting token: ${_dio.options.headers}');
  }

  Future<ResponseModel> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: queryParams);
      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<ResponseModel> post(String endpoint, {dynamic body, Map<String, dynamic>? queryParams}) async {
    try {
      _dio.options.headers['Content-Type'] = body is FormData ? 'multipart/form-data' : 'application/json';
      final response = await _dio.post(endpoint, data: body, queryParameters: queryParams);
      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<ResponseModel> put(String endpoint, {dynamic body, Map<String, dynamic>? queryParams}) async {
    try {
      _dio.options.headers['Content-Type'] = body is FormData ? 'multipart/form-data' : 'application/json';
      final response = await _dio.put(endpoint, data: body, queryParameters: queryParams);
      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<ResponseModel> patch(String endpoint, {dynamic body, Map<String, dynamic>? queryParams}) async {
    try {
      _dio.options.headers['Content-Type'] = body is FormData ? 'multipart/form-data' : 'application/json';
      final response = await _dio.patch(endpoint, data: body, queryParameters: queryParams);
      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    }
  }

  Future<ResponseModel> delete(String endpoint, {dynamic body, Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.delete(endpoint, data: body, queryParameters: queryParams);
      return _handleResponse(response);
    } catch (error) {
      return _handleError(error);
    }
  }

  ResponseModel _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return ResponseModel.success(response.data, response.data?['message'] ?? 'Success');
    } else {
      final errorMessage = response.data?['message'] ?? 'An error occurred';
      return ResponseModel.error(errorMessage);
    }
  }

  ResponseModel _handleError(dynamic error) {
    String errorMessage;
    if (error is DioException && error.response != null) {
      if (error.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timed out. Please check your internet connection.';
      } else if (error.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'Server is taking too long to respond. Please try again later.';
      } else if (error.type == DioExceptionType.sendTimeout) {
        errorMessage = 'Request timed out. Please check your internet connection.';
      } else if (error.response?.statusCode == 401) {
        errorMessage = 'Unauthorized access. Please login again.';
      } else if (error.response?.statusCode == 403) {
        errorMessage = 'You do not have permission to access this resource.';
      } else if (error.response?.statusCode == 404) {
        errorMessage = 'The requested resource was not found.';
      } else if (error.response?.statusCode == 500) {
        errorMessage = 'Server error. Please try again later.';
      } else {
        errorMessage = error.response?.data['message'] ?? 'An unexpected error occurred';
      }
    } else if (error is SocketException) {
      errorMessage = 'No internet connection. Please check your network settings.';
    } else {
      errorMessage = 'An unexpected error occurred. Please try again.';
    }

    HLoggerHelper.error('''
        DioException Details:
        Error Type: ${error is DioException ? error.type : 'Unknown'}
        Response Status: ${error is DioException ? error.response?.statusCode : 'Unknown'}
        Response Data: ${error is DioException ? error.response?.data : 'Unknown'}
        Error Message: $errorMessage
      ''');

    return ResponseModel.error(errorMessage);
  }
}
