import 'package:dio/dio.dart' as dio;
import 'package:slea_auv/app/api/models/auv_models.dart';

/// API 错误处理工具类
/// 
/// 提供统一的错误处理和响应解析功能
class AuvApiError {
  /// 错误码
  final int code;
  
  /// 错误消息
  final String message;
  
  /// 原始异常
  final dynamic originalError;

  const AuvApiError({
    this.code = -1,
    this.message = 'Unknown error',
    this.originalError,
  });

  /// 从 DioException 创建错误
  factory AuvApiError.fromDioException(dio.DioException e) {
    String message;
    int code = -1;

    switch (e.type) {
      case dio.DioExceptionType.connectionTimeout:
        message = 'Connection timeout';
        break;
      case dio.DioExceptionType.sendTimeout:
        message = 'Send timeout';
        break;
      case dio.DioExceptionType.receiveTimeout:
        message = 'Receive timeout';
        break;
      case dio.DioExceptionType.badCertificate:
        message = 'Bad certificate';
        break;
      case dio.DioExceptionType.badResponse:
        code = e.response?.statusCode ?? -1;
        message = _parseBadResponseMessage(e.response);
        break;
      case dio.DioExceptionType.cancel:
        message = 'Request cancelled';
        break;
      case dio.DioExceptionType.connectionError:
        message = 'Connection error';
        break;
      case dio.DioExceptionType.unknown:
      default:
        message = e.message ?? 'Unknown network error';
    }

    return AuvApiError(
      code: code,
      message: message,
      originalError: e,
    );
  }

  /// 解析响应错误消息
  static String _parseBadResponseMessage(dio.Response? response) {
    if (response == null) return 'Server error';

    try {
      final data = response.data;
      if (data is Map && data.containsKey('message')) {
        return data['message'];
      }
    } catch (_) {}

    return 'Server error (${response.statusCode})';
  }

  @override
  String toString() => 'AuvApiError(code: $code, message: $message)';
}

/// API 响应处理工具类
/// 
/// 提供统一的响应解析和错误处理功能
class AuvResponseHandler {
  /// 处理响应并转换为目标类型
  /// 
  /// [json] 响应JSON数据
  /// [fromJsonT] 类型转换函数
  /// [T] 目标数据类型
  static AuvShowDocResponse<T> handle<T>(
    Map<String, dynamic>? json,
    T Function(dynamic)? fromJsonT,
  ) {
    if (json == null) {
      return AuvShowDocResponse<T>(
        code: -1,
        message: 'Empty response',
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
    }

    return AuvShowDocResponse<T>(
      code: json['code'] ?? -1,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }

  /// 处理列表响应
  /// 
  /// [json] 响应JSON数据
  /// [fromJsonT] 类型转换函数
  /// [T] 目标数据类型
  static AuvShowDocResponse<List<T>> handleList<T>(
    Map<String, dynamic>? json,
    T Function(dynamic)? fromJsonT,
  ) {
    if (json == null) {
      return AuvShowDocResponse<List<T>>(
        code: -1,
        message: 'Empty response',
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
    }

    List<T>? data;
    if (json['data'] != null && fromJsonT != null) {
      try {
        data = (json['data'] as List).map((e) => fromJsonT(e)).toList();
      } catch (_) {
        data = null;
      }
    }

    return AuvShowDocResponse<List<T>>(
      code: json['code'] ?? -1,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      data: data,
    );
  }

  /// 处理空响应（仅返回状态）
  static AuvShowDocResponse<void> handleVoid(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvShowDocResponse<void>(
        code: -1,
        message: 'Empty response',
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
    }

    return AuvShowDocResponse<void>(
      code: json['code'] ?? -1,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      data: null,
    );
  }

  /// 处理单个值响应（如int等简单类型）
  static AuvShowDocResponse<T> handleSingleValue<T>(
    Map<String, dynamic>? json,
    T Function(dynamic)? fromJsonT,
  ) {
    if (json == null) {
      return AuvShowDocResponse<T>(
        code: -1,
        message: 'Empty response',
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
    }

    return AuvShowDocResponse<T>(
      code: json['code'] ?? -1,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      data: json['data'] != null && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }

  /// 处理嵌套对象响应（如data.list结构）
  static AuvShowDocResponse<T> handleObject<T>(
    Map<String, dynamic>? json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    if (json == null) {
      return AuvShowDocResponse<T>(
        code: -1,
        message: 'Empty response',
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
    }

    return AuvShowDocResponse<T>(
      code: json['code'] ?? -1,
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? 0,
      data: json['data'] != null && json['data'] is Map && fromJsonT != null
          ? fromJsonT(json['data'])
          : null,
    );
  }

  /// 处理 API 错误响应
  static AuvShowDocResponse<T> handleError<T>(dynamic error) {
    String message;
    int code = -1;

    if (error is dio.DioException) {
      final apiError = AuvApiError.fromDioException(error);
      message = apiError.message;
      code = apiError.code;
    } else {
      message = error.toString();
    }

    return AuvShowDocResponse<T>(
      code: code,
      message: message,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }
}
