import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_bank/utils/logger.dart';

/// 网络请求配置
class NetworkConfig {
  final String baseUrl;
  final Duration timeout;
  final Map<String, String> defaultHeaders;
  final bool enableLogging;

  const NetworkConfig({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 30),
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    this.enableLogging = true,
  });
}

/// 网络请求结果
class NetworkResult<T> {
  final bool success;
  final T? data;
  final String? error;
  final int? statusCode;
  final Map<String, String>? headers;

  NetworkResult({
    required this.success,
    this.data,
    this.error,
    this.statusCode,
    this.headers,
  });

  factory NetworkResult.success(T data, {int? statusCode, Map<String, String>? headers}) {
    return NetworkResult<T>(
      success: true,
      data: data,
      statusCode: statusCode,
      headers: headers,
    );
  }

  factory NetworkResult.error(String error, {int? statusCode, Map<String, String>? headers}) {
    return NetworkResult<T>(
      success: false,
      error: error,
      statusCode: statusCode,
      headers: headers,
    );
  }
}

/// 底层网络请求客户端
class NetworkClient {
  static NetworkClient? _instance;
  late NetworkConfig _config;
  late http.Client _client;

  NetworkClient._();

  static NetworkClient get instance {
    _instance ??= NetworkClient._();
    return _instance!;
  }

  /// 初始化网络客户端
  void init(NetworkConfig config) {
    _config = config;
    _client = http.Client();
    SimpleLogger.d('500', 'NetworkClient初始化完成，BaseURL: ${config.baseUrl}');
  }

  /// 通用GET请求
  Future<NetworkResult<T>> get<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
  }) async {
    return _request<T>(
      method: 'GET',
      endpoint: endpoint,
      headers: headers,
      queryParams: queryParams,
      fromJson: fromJson,
    );
  }

  /// 通用POST请求
  Future<NetworkResult<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return _request<T>(
      method: 'POST',
      endpoint: endpoint,
      body: body,
      headers: headers,
      fromJson: fromJson,
    );
  }

  /// 通用PUT请求
  Future<NetworkResult<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return _request<T>(
      method: 'PUT',
      endpoint: endpoint,
      body: body,
      headers: headers,
      fromJson: fromJson,
    );
  }

  /// 通用DELETE请求
  Future<NetworkResult<T>> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    return _request<T>(
      method: 'DELETE',
      endpoint: endpoint,
      headers: headers,
      fromJson: fromJson,
    );
  }

  /// 核心请求方法
  Future<NetworkResult<T>> _request<T>({
    required String method,
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
  }) async {
    final String fullUrl = _buildUrl(endpoint, queryParams);
    final Map<String, String> requestHeaders = {
      ..._config.defaultHeaders,
      ...?headers,
    };

    if (_config.enableLogging) {
      SimpleLogger.d('501', '=== 开始$method请求 ===');
      SimpleLogger.d('502', '请求URL: $fullUrl');
      SimpleLogger.d('503', '请求方法: $method');
      SimpleLogger.d('504', '请求头: $requestHeaders');
      if (body != null) {
        SimpleLogger.d('505', '请求体: ${json.encode(body)}');
      }
      if (queryParams != null) {
        SimpleLogger.d('506', '查询参数: $queryParams');
      }
      SimpleLogger.d('507', '超时时间: ${_config.timeout.inSeconds}秒');
    }

    final stopwatch = Stopwatch()..start();

    try {
      http.Response response;
      
      switch (method.toUpperCase()) {
        case 'GET':
          response = await _client.get(
            Uri.parse(fullUrl),
            headers: requestHeaders,
          ).timeout(_config.timeout);
          break;
        case 'POST':
          response = await _client.post(
            Uri.parse(fullUrl),
            headers: requestHeaders,
            body: body != null ? json.encode(body) : null,
          ).timeout(_config.timeout);
          break;
        case 'PUT':
          response = await _client.put(
            Uri.parse(fullUrl),
            headers: requestHeaders,
            body: body != null ? json.encode(body) : null,
          ).timeout(_config.timeout);
          break;
        case 'DELETE':
          response = await _client.delete(
            Uri.parse(fullUrl),
            headers: requestHeaders,
          ).timeout(_config.timeout);
          break;
        default:
          throw UnsupportedError('不支持的HTTP方法: $method');
      }

      stopwatch.stop();

      if (_config.enableLogging) {
        SimpleLogger.d('508', '=== $method请求完成 ===');
        SimpleLogger.d('509', '响应状态码: ${response.statusCode}');
        SimpleLogger.d('510', '响应头: ${response.headers}');
        SimpleLogger.d('511', '响应体长度: ${response.body.length}字节');
        SimpleLogger.d('512', '请求耗时: ${stopwatch.elapsedMilliseconds}ms');
        SimpleLogger.d('513', '响应体内容: ${response.body}');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          final dynamic jsonData = json.decode(response.body);
          
          if (_config.enableLogging) {
            SimpleLogger.d('514', 'JSON解析成功');
            SimpleLogger.d('515', '解析后数据: $jsonData');
          }

          T? data;
          if (fromJson != null) {
            data = fromJson(jsonData);
          } else {
            data = jsonData as T?;
          }

          if (_config.enableLogging) {
            SimpleLogger.d('516', '数据转换成功: ${data != null ? data.runtimeType : 'null'}');
          }

          return NetworkResult.success(
            data!,
            statusCode: response.statusCode,
            headers: response.headers,
          );
        } catch (e) {
          if (_config.enableLogging) {
            SimpleLogger.e('517', 'JSON解析失败: $e');
            SimpleLogger.e('518', '原始响应体: ${response.body}');
          }
          return NetworkResult.error(
            'JSON解析失败: $e',
            statusCode: response.statusCode,
            headers: response.headers,
          );
        }
      } else {
        if (_config.enableLogging) {
          SimpleLogger.e('519', '=== $method请求失败 ===');
          SimpleLogger.e('520', 'HTTP状态码: ${response.statusCode}');
          SimpleLogger.e('521', '响应体: ${response.body}');
        }
        return NetworkResult.error(
          'HTTP请求失败: ${response.statusCode}',
          statusCode: response.statusCode,
          headers: response.headers,
        );
      }
    } on SocketException catch (e) {
      stopwatch.stop();
      if (_config.enableLogging) {
        SimpleLogger.e('522', '=== 网络连接异常 ===');
        SimpleLogger.e('523', '异常类型: SocketException');
        SimpleLogger.e('524', '异常信息: $e');
        SimpleLogger.e('525', '请求URL: $fullUrl');
      }
      return NetworkResult.error('网络连接失败: ${e.message}');
    } on HttpException catch (e) {
      stopwatch.stop();
      if (_config.enableLogging) {
        SimpleLogger.e('526', '=== HTTP异常 ===');
        SimpleLogger.e('527', '异常类型: HttpException');
        SimpleLogger.e('528', '异常信息: $e');
        SimpleLogger.e('529', '请求URL: $fullUrl');
      }
      return NetworkResult.error('HTTP请求异常: ${e.message}');
    } on FormatException catch (e) {
      stopwatch.stop();
      if (_config.enableLogging) {
        SimpleLogger.e('530', '=== 数据格式异常 ===');
        SimpleLogger.e('531', '异常类型: FormatException');
        SimpleLogger.e('532', '异常信息: $e');
        SimpleLogger.e('533', '请求URL: $fullUrl');
      }
      return NetworkResult.error('数据格式错误: ${e.message}');
    } catch (e) {
      stopwatch.stop();
      if (_config.enableLogging) {
        SimpleLogger.e('534', '=== 未知异常 ===');
        SimpleLogger.e('535', '异常类型: ${e.runtimeType}');
        SimpleLogger.e('536', '异常信息: $e');
        SimpleLogger.e('537', '请求URL: $fullUrl');
      }
      return NetworkResult.error('请求异常: $e');
    }
  }

  /// 构建完整URL
  String _buildUrl(String endpoint, Map<String, dynamic>? queryParams) {
    String url = '${_config.baseUrl}$endpoint';
    
    if (queryParams != null && queryParams.isNotEmpty) {
      final uri = Uri.parse(url);
      final newUri = uri.replace(queryParameters: {
        ...uri.queryParameters,
        ...queryParams.map((key, value) => MapEntry(key, value.toString())),
      });
      url = newUri.toString();
    }
    
    return url;
  }

  /// 释放资源
  void dispose() {
    _client.close();
    SimpleLogger.d('538', 'NetworkClient资源已释放');
  }
}
