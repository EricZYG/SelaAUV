import 'package:dio/dio.dart' as dio;
import 'package:slea_auv/app/core/auv_config.dart';
import 'package:slea_auv/app/utils/auv_sign_util.dart';
import 'package:slea_auv/app/services/auv_storage_service.dart';
import 'package:get/get.dart';

/// API 服务
class AuvApiService {
  static final AuvApiService _instance = AuvApiService._internal();
  factory AuvApiService() => _instance;
  AuvApiService._internal();

  late final dio.Dio _dio;
  String? _signKey;

  /// 需要签名的路由列表
  /// 
  /// 签名规则：
  /// 1. 将请求参数按照参数名ASCII码从小到大排序（字典序）
  /// 2. 使用URL键值对格式拼接成字符串 stringA
  /// 3. 在stringA最后拼接 time 和 key，得到 stringSignTemp
  /// 4. 对stringSignTemp进行MD5运算，结果转小写得到sign值
  static const List<String> _signRoutes = [
    // 登录注册相关
    '/user/login/guest',
    '/user/login/phone',
    '/user/login/google',
    '/user/login/apple',
    '/user/login/password',
    '/manager/login/guild',
    // 签到
    '/user/sign/signIn',
    // 下单
    '/p/order/createOrder',
    // 送礼
    '/user/gift/sendReal',
    '/user/gift/sendLucky',
  ];

  /// 初始化 Sign Key（从应用配置接口获取）
  void setSignKey(String key) {
    _signKey = key;
  }

  String? get signKey => _signKey;

  void init() {
    _dio = dio.Dio(dio.BaseOptions(
      baseUrl: AuvConfig.baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(dio.LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    _dio.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (options, handler) {
        // Debug 模式下添加公共头参数
        if (AuvConfig.debugMode) {
          options.headers['Accept-Encoding'] = 'gzip, deflate, br';
          options.headers['Connection'] = 'keep-alive';
          options.headers['authorization'] = AuvConfig.debugAuth;
          options.headers['content-type'] = 'application/json; charset=utf-8';
          options.headers['device-id'] = AuvConfig.debugDeviceId;
          options.headers['user-agent'] = AuvConfig.debugUserAgent;
          options.headers['user-language'] = 'zh';
        }

        // 添加 Token
        final storage = Get.find<AuvStorageService>();
        final token = storage.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        // 仅对需要签名的路由添加签名
        _addSignIfNeeded(options);

        return handler.next(options);
      },
      onError: (error, handler) {
        // 统一错误处理
        return handler.next(error);
      },
    ));
  }

  dio.Dio get dioClient => _dio;

  /// 检查路由是否需要签名
  bool _needsSign(String path) {
    for (final route in _signRoutes) {
      if (path.contains(route)) {
        return true;
      }
    }
    return false;
  }

  /// 仅对需要签名的路由添加签名
  void _addSignIfNeeded(dio.RequestOptions options) {
    if (!_needsSign(options.path)) {
      return;
    }

    final time = DateTime.now().millisecondsSinceEpoch.toString();
    options.headers['s-time'] = time;

    // 获取请求参数（合并 query 和 body）
    final params = <String, dynamic>{};

    if (options.queryParameters.isNotEmpty) {
      params.addAll(options.queryParameters);
    }

    if (options.data != null && options.data is Map) {
      params.addAll(Map<String, dynamic>.from(options.data as Map));
    }

    // 生成签名
    if (_signKey != null) {
      final sign = AuvSignUtil.generateSign(params, time, _signKey!);
      options.headers['s-sign'] = sign;
    }
  }

  /// 添加签名到请求头（保留向后兼容）
  void _addSign(dio.RequestOptions options) {
    _addSignIfNeeded(options);
  }

  Future<dio.Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<dio.Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<dio.Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  Future<dio.Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
