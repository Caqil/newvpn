import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../models/user_model.dart';
import '../models/device_model.dart';
import '../models/subscription_model.dart';
import '../models/receipt_model.dart';
import '../utils/helpers.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late final Dio _dio;
  bool _isInitialized = false;

  // Initialize the API service
  Future<void> initialize() async {
    if (_isInitialized) return;

    _dio = Dio(BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: ApiConfig.connectTimeout,
      receiveTimeout: ApiConfig.receiveTimeout,
      sendTimeout: ApiConfig.sendTimeout,
      headers: ApiConfig.defaultHeaders,
    ));

    _setupInterceptors();
    _isInitialized = true;
  }

  void _setupInterceptors() {
    // Request interceptor
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('🌐 API Request: ${options.method} ${options.path}');
        if (options.data != null) {
          print('📤 Request Data: ${options.data}');
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        print('✅ API Response: ${response.statusCode} ${response.requestOptions.path}');
        handler.next(response);
      },
      onError: (error, handler) {
        print('❌ API Error: ${error.message}');
        print('📍 Path: ${error.requestOptions.path}');
        handler.next(_handleDioError(error));
      },
    ));

    // Retry interceptor
    _dio.interceptors.add(RetryInterceptor(
      dio: _dio,
      options: const RetryOptions(
        retries: ApiConfig.maxRetries,
        retryInterval: ApiConfig.retryDelay,
      ),
    ));
  }

  DioException _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return DioException(
          requestOptions: error.requestOptions,
          message: 'Connection timeout. Please check your internet connection.',
          type: error.type,
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        String message = 'Server error occurred';
        
        switch (statusCode) {
          case 400:
            message = 'Invalid request';
            break;
          case 401:
            message = 'Authentication failed';
            break;
          case 403:
            message = 'Access forbidden';
            break;
          case 404:
            message = 'Resource not found';
            break;
          case 429:
            message = 'Too many requests. Please try again later.';
            break;
          case 500:
            message = 'Internal server error';
            break;
          case 503:
            message = 'Service unavailable';
            break;
        }
        
        return DioException(
          requestOptions: error.requestOptions,
          message: message,
          response: error.response,
          type: error.type,
        );
      default:
        return error;
    }
  }

  // User API methods
  Future<UserModel> getUser(String deviceId) async {
    try {
      final response = await _dio.get(
        ApiConfig.userEndpoint(deviceId),
        options: Options(headers: ApiConfig.authHeaders),
      );
      
      return UserModel.fromApiResponse(response.data);
    } catch (e) {
      throw ApiException('Failed to get user data: $e');
    }
  }

  Future<UserModel> registerDevice(Map<String, dynamic> deviceData) async {
    try {
      final response = await _dio.post(
        ApiConfig.registerDeviceEndpoint,
        data: deviceData,
        options: Options(headers: ApiConfig.authHeaders),
      );
      
      return UserModel.fromApiResponse(response.data);
    } catch (e) {
      throw ApiException('Failed to register device: $e');
    }
  }

  // Subscription API methods
  Future<Map<String, dynamic>> validateReceipt(Map<String, dynamic> receiptData) async {
    try {
      final response = await _dio.post(
        ApiConfig.validateReceiptEndpoint,
        data: receiptData,
        options: Options(headers: ApiConfig.authHeaders),
      );
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw ApiException('Failed to validate receipt: $e');
    }
  }

  Future<Map<String, dynamic>> getSubscriptionStatus(String deviceId) async {
    try {
      final response = await _dio.get(
        '${ApiConfig.subscriptionStatusEndpoint}/$deviceId',
        options: Options(headers: ApiConfig.authHeaders),
      );
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw ApiException('Failed to get subscription status: $e');
    }
  }

  Future<Map<String, dynamic>> updateSubscription(
    String deviceId, 
    Map<String, dynamic> subscriptionData,
  ) async {
    try {
      final response = await _dio.put(
        '${ApiConfig.subscriptionStatusEndpoint}/$deviceId',
        data: subscriptionData,
        options: Options(headers: ApiConfig.authHeaders),
      );
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw ApiException('Failed to update subscription: $e');
    }
  }

  // Server API methods
  Future<List<String>> getServerList(String deviceId) async {
    try {
      final response = await _dio.get(
        ApiConfig.userEndpoint(deviceId),
        options: Options(headers: ApiConfig.authHeaders),
      );
      
      final userData = response.data as Map<String, dynamic>;
      final links = userData[ApiConfig.linksField] as List?;
      
      if (links == null) {
        throw ApiException('No server links found in response');
      }
      
      return links
          .where((link) => link is String && link != 'False')
          .cast<String>()
          .toList();
    } catch (e) {
      throw ApiException('Failed to get server list: $e');
    }
  }

  // Usage statistics API methods
  Future<Map<String, dynamic>> getUsageStats(String deviceId) async {
    try {
      final response = await _dio.get(
        '${ApiConfig.usageStatsEndpoint}/$deviceId',
        options: Options(headers: ApiConfig.authHeaders),
      );
      
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw ApiException('Failed to get usage statistics: $e');
    }
  }

  Future<void> updateUsageStats(
    String deviceId,
    Map<String, dynamic> usageData,
  ) async {
    try {
      await _dio.post(
        '${ApiConfig.usageStatsEndpoint}/$deviceId',
        data: usageData,
        options: Options(headers: ApiConfig.authHeaders),
      );
    } catch (e) {
      throw ApiException('Failed to update usage statistics: $e');
    }
  }

  // Generic HTTP methods
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      throw ApiException('GET request failed: $e');
    }
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      throw ApiException('POST request failed: $e');
    }
  }

  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      throw ApiException('PUT request failed: $e');
    }
  }

  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } catch (e) {
      throw ApiException('DELETE request failed: $e');
    }
  }

  // Health check
  Future<bool> isApiHealthy() async {
    try {
      final response = await _dio.get(
        '/health',
        options: Options(
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Cache management
  void clearCache() {
    // Clear any cached responses if implemented
  }

  // Dispose resources
  void dispose() {
    _dio.close();
    _isInitialized = false;
  }
}

// Retry interceptor for failed requests
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final RetryOptions options;

  RetryInterceptor({
    required this.dio,
    required this.options,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final retryKey = '${err.requestOptions.method}-${err.requestOptions.path}';
    var retryCount = err.requestOptions.extra['retry_count'] as int? ?? 0;

    if (retryCount < options.retries && _shouldRetry(err)) {
      retryCount++;
      print('🔄 Retrying request ($retryCount/${options.retries}): ${err.requestOptions.path}');

      await Future.delayed(options.retryInterval);

      final requestOptions = err.requestOptions;
      requestOptions.extra['retry_count'] = retryCount;

      try {
        final response = await dio.fetch(requestOptions);
        handler.resolve(response);
      } catch (e) {
        if (e is DioException) {
          handler.next(e);
        } else {
          handler.next(DioException(
            requestOptions: requestOptions,
            message: e.toString(),
          ));
        }
      }
    } else {
      handler.next(err);
    }
  }

  bool _shouldRetry(DioException error) {
    // Retry on network errors and 5xx server errors
    return error.type == DioExceptionType.connectionTimeout ||
           error.type == DioExceptionType.sendTimeout ||
           error.type == DioExceptionType.receiveTimeout ||
           error.type == DioExceptionType.connectionError ||
           (error.response?.statusCode != null && 
            error.response!.statusCode! >= 500);
  }
}

class RetryOptions {
  final int retries;
  final Duration retryInterval;

  const RetryOptions({
    required this.retries,
    required this.retryInterval,
  });
}

// Custom exception for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException(this.message, {this.statusCode, this.data});

  @override
  String toString() => 'ApiException: $message';
}

// API response wrapper
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? error;
  final int? statusCode;

  const ApiResponse({
    required this.success,
    this.data,
    this.error,
    this.statusCode,
  });

  factory ApiResponse.success(T data) {
    return ApiResponse(
      success: true,
      data: data,
    );
  }

  factory ApiResponse.error(String error, {int? statusCode}) {
    return ApiResponse(
      success: false,
      error: error,
      statusCode: statusCode,
    );
  }
}

// API client builder for different endpoints
class ApiClient {
  static Future<ApiResponse<T>> request<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      final data = await apiCall();
      return ApiResponse.success(data);
    } on DioException catch (e) {
      return ApiResponse.error(
        e.message ?? 'Network error occurred',
        statusCode: e.response?.statusCode,
      );
    } on ApiException catch (e) {
      return ApiResponse.error(
        e.message,
        statusCode: e.statusCode,
      );
    } catch (e) {
      return ApiResponse.error('Unexpected error: $e');
    }
  }
}