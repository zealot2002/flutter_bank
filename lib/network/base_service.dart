import 'package:flutter_bank/network/network_client.dart';
import 'package:flutter_bank/models/api_response.dart';
import 'package:flutter_bank/utils/logger.dart';

/// 基础Service抽象类
abstract class BaseService {
  final NetworkClient _client = NetworkClient.instance;

  /// 子类需要实现的具体模块标识
  String get moduleName;

  /// 处理API响应的通用方法
  Future<ApiResponse<T>> handleResponse<T>(
    NetworkResult<Map<String, dynamic>> result,
    T Function(dynamic)? fromJson,
  ) async {
    SimpleLogger.d('600', '[$moduleName] 处理API响应');
    SimpleLogger.d('601', '[$moduleName] 请求成功: ${result.success}');
    SimpleLogger.d('602', '[$moduleName] 状态码: ${result.statusCode}');
    SimpleLogger.d('603', '[$moduleName] 错误信息: ${result.error}');

    if (result.success && result.data != null) {
      try {
        final apiResponse = ApiResponse<T>.fromJson(result.data!, fromJson);
        SimpleLogger.d('604', '[$moduleName] API响应解析成功');
        SimpleLogger.d('605', '[$moduleName] API响应码: ${apiResponse.code}');
        SimpleLogger.d('606', '[$moduleName] API响应消息: ${apiResponse.message}');
        SimpleLogger.d('607', '[$moduleName] API响应成功: ${apiResponse.success}');
        
        return apiResponse;
      } catch (e) {
        SimpleLogger.e('608', '[$moduleName] API响应解析失败: $e');
        return ApiResponse<T>(
          code: -3,
          message: '响应解析失败: $e',
          data: null,
          success: false,
        );
      }
    } else {
      SimpleLogger.e('609', '[$moduleName] 网络请求失败: ${result.error}');
      return ApiResponse<T>(
        code: result.statusCode ?? -1,
        message: result.error ?? '网络请求失败',
        data: null,
        success: false,
      );
    }
  }

  /// 通用GET请求
  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
  }) async {
    SimpleLogger.d('610', '[$moduleName] 发起GET请求: $endpoint');
    
    final result = await _client.get<Map<String, dynamic>>(
      endpoint,
      headers: headers,
      queryParams: queryParams,
    );
    
    return handleResponse<T>(result, fromJson);
  }

  /// 通用POST请求
  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    SimpleLogger.d('611', '[$moduleName] 发起POST请求: $endpoint');
    
    final result = await _client.post<Map<String, dynamic>>(
      endpoint,
      body: body,
      headers: headers,
    );
    
    return handleResponse<T>(result, fromJson);
  }

  /// 通用PUT请求
  Future<ApiResponse<T>> put<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    SimpleLogger.d('612', '[$moduleName] 发起PUT请求: $endpoint');
    
    final result = await _client.put<Map<String, dynamic>>(
      endpoint,
      body: body,
      headers: headers,
    );
    
    return handleResponse<T>(result, fromJson);
  }

  /// 通用DELETE请求
  Future<ApiResponse<T>> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    T Function(dynamic)? fromJson,
  }) async {
    SimpleLogger.d('613', '[$moduleName] 发起DELETE请求: $endpoint');
    
    final result = await _client.delete<Map<String, dynamic>>(
      endpoint,
      headers: headers,
    );
    
    return handleResponse<T>(result, fromJson);
  }
}
