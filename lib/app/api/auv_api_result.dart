import 'package:slea_auv/app/api/auv_api_code.dart';

/// API 响应结果封装
class AuvApiResult<T> {
  final bool success;
  final T? data;
  final String? message;
  final int code;
  final AuvApiCode apiCode;

  AuvApiResult({
    required this.success,
    this.data,
    this.message,
    required this.code,
  }) : apiCode = AuvApiCode.fromCode(code);

  factory AuvApiResult.success(T? data, {String? message, int? code}) {
    return AuvApiResult(
      success: true,
      data: data,
      message: message,
      code: code ?? 0,
    );
  }

  factory AuvApiResult.fail(String message, {int? code}) {
    return AuvApiResult(
      success: false,
      message: message,
      code: code ?? 1001,
    );
  }

  factory AuvApiResult.fromResponse(dynamic response) {
    final code = response['code'] as int? ?? 1001;
    final apiCode = AuvApiCode.fromCode(code);
    return AuvApiResult(
      success: apiCode.isSuccess,
      data: response['data'],
      message: response['msg'] ?? response['message'] ?? apiCode.message,
      code: code,
    );
  }

  /// 解析泛型数据
  R parse<R>(R Function(dynamic data) parser) {
    if (success && data != null) {
      return parser(data);
    }
    throw AuvApiException(apiCode, message ?? apiCode.message);
  }

  /// 获取错误提示（中文优先）
  String get errorMessage {
    if (message != null && message!.isNotEmpty) {
      return message!;
    }
    return apiCode.message;
  }
}

/// API 异常
class AuvApiException implements Exception {
  final AuvApiCode code;
  final String message;

  AuvApiException(this.code, this.message);

  @override
  String toString() => 'AuvApiException: [$code] $message';
}
