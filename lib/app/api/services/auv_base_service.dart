import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_api_error.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/utils/auv_sign_util.dart';

/// ShowDoc API 服务基类
///
/// 提供签名、响应处理等通用功能
abstract class AuvBaseService extends GetxService {
  late final AuvApiService _api;

  /// 签名密钥（从应用配置接口获取的 ok 参数）
  String? _signKey;

  /// 初始化服务
  /// 
  /// [api] AuvApiService实例
  void init(AuvApiService api) {
    _api = api;
  }

  /// 设置签名密钥
  /// 
  /// [key] 从getAppConfig接口返回的ok字段值
  /// 
  /// 调用时机: 在调用需要签名的接口之前，需要先调用getAppConfig获取并设置
  void setSignKey(String key) {
    _signKey = key;
  }

  /// 获取签名密钥
  String? get signKey => _signKey;

  /// 获取签名请求头
  /// 
  /// [params] 请求参数
  /// 
  /// 返回包含s-time和s-sign的请求头Map
  /// 如果未设置签名密钥，sign为空字符串
  Map<String, String> _getSignHeaders(Map<String, dynamic> params) {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String sign = '';
    if (_signKey != null) {
      sign = AuvSignUtil.generateSign(params, timestamp, _signKey!);
    }
    return {
      's-time': timestamp,
      's-sign': sign,
    };
  }

  /// POST请求（带签名）
  Future<dio.Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    bool needSign = true,
  }) async {
    final signHeaders = needSign && data != null
        ? _getSignHeaders(data is Map ? data.cast<String, dynamic>() : {})
        : <String, String>{};

    final mergedOptions = options?.copyWith(
      headers: {
        ...?options.headers,
        ...signHeaders,
      },
    ) ?? (signHeaders.isNotEmpty ? dio.Options(headers: signHeaders) : null);

    return _api.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: mergedOptions,
    );
  }

  /// GET请求
  Future<dio.Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
  }) async {
    return _api.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// 处理单个对象响应
  AuvShowDocResponse<T> handleResponse<T>(
    Map<String, dynamic>? json,
    T Function(dynamic)? fromJsonT,
  ) {
    return AuvResponseHandler.handle(json, fromJsonT);
  }

  /// 处理列表响应
  AuvShowDocResponse<List<T>> handleListResponse<T>(
    Map<String, dynamic>? json,
    T Function(dynamic)? fromJsonT,
  ) {
    return AuvResponseHandler.handleList(json, fromJsonT);
  }

  /// 处理空响应
  AuvShowDocResponse<void> handleVoidResponse(Map<String, dynamic>? json) {
    return AuvResponseHandler.handleVoid(json);
  }

  /// 处理单个值响应（如int等简单类型）
  AuvShowDocResponse<T> handleSingleValueResponse<T>(
    Map<String, dynamic>? json,
    T Function(dynamic)? fromJsonT,
  ) {
    return AuvResponseHandler.handleSingleValue(json, fromJsonT);
  }

  /// 处理嵌套对象响应（如data.list结构）
  AuvShowDocResponse<T> handleObjectResponse<T>(
    Map<String, dynamic>? json,
    T Function(Map<String, dynamic>)? fromJsonT,
  ) {
    return AuvResponseHandler.handleObject(json, fromJsonT);
  }

  /// 处理错误响应
  AuvShowDocResponse<T> handleError<T>(dynamic error) {
    return AuvResponseHandler.handleError<T>(error);
  }
}
