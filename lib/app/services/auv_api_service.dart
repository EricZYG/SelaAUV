import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart' as dio;
import 'package:slea_auv/app/core/auv_config.dart';
import 'package:slea_auv/app/utils/auv_sign_util.dart';
import 'package:slea_auv/app/services/auv_storage_service.dart';
import 'package:slea_auv/app/utils/auv_logger.dart';
import 'package:get/get.dart';

/// 生成唯一的 device-id
String _generateDeviceId() {
  // 尝试使用稳定的设备标识
  final random = Random();
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  
  // 生成类似原格式的 device-id: d89793035d98c48f-Xiaomi
  final randomHex = random.nextInt(0xFFFFFFFF).toRadixString(16).padLeft(8, '0') +
                    random.nextInt(0xFFFFFFFF).toRadixString(16).padLeft(8, '0');
  final platform = Platform.isAndroid ? 'Android' : 'iOS';
  
  return '$randomHex-$platform';
}

/// API 服务
class AuvApiService {
  static final AuvApiService _instance = AuvApiService._internal();
  factory AuvApiService() => _instance;
  AuvApiService._internal();

  late final dio.Dio _dio;
  String? _signKey;
  bool _initialized = false;

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
    // 防止重复初始化
    if (_initialized) {
      AuvLogger.warning('AuvApiService already initialized, skipping', tag: 'API');
      return;
    }
    _initialized = true;

    // 生成 device-id
    final deviceId = _generateDeviceId();
    AuvLogger.debug('Generated device-id: $deviceId', tag: 'API');
    
    AuvLogger.info('Initializing Dio client with baseUrl: ${AuvConfig.baseUrl}', tag: 'API');
    _dio = dio.Dio(dio.BaseOptions(
      baseUrl: AuvConfig.baseUrl,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      headers: {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'content-type': 'application/json; charset=utf-8',
        'user-language': 'en',
        'device-id': deviceId,
        'user-agent': 'sela,3.0.8,android Mi Note 3,9,sela100,40',
      },
    ));

    _dio.interceptors.add(dio.LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    _dio.interceptors.add(dio.InterceptorsWrapper(
      onRequest: (options, handler) {
        // 打印详细请求日志
        _logRequest(options);

        // 添加 Token（仅在有 token 时）
        try {
          final storage = Get.find<AuvStorageService>();
          final token = storage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['authorization'] = token;
            AuvLogger.debug('Added authorization token to request', tag: 'API');
          }
        } catch (e) {
          AuvLogger.debug('Storage service not available, skipping token', tag: 'API');
        }

        // 仅对需要签名的路由添加签名
        _addSignIfNeeded(options);

        return handler.next(options);
      },
      onResponse: (response, handler) {
        // 打印详细响应日志
        _logResponse(response);
        return handler.next(response);
      },
      onError: (error, handler) {
        // 打印详细错误日志
        _logError(error);
        return handler.next(error);
      },
    ));
    AuvLogger.success('Dio client initialized', tag: 'API');
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

  /// 保留向后兼容的签名方法（内部调用_addSignIfNeeded）
  // ignore: unused_element
  void _addSign(dio.RequestOptions options) {
    _addSignIfNeeded(options);
  }

  /// 打印详细请求日志
  void _logRequest(dio.RequestOptions options) {
    final buffer = StringBuffer();
    buffer.writeln('╔═══════════════════════════════════════════════════════════════════');
    buffer.writeln('║                        API REQUEST                                ║');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════════');
    
    // 请求方法
    buffer.writeln('║ 📌 Method: ${options.method}');
    
    // 完整请求地址
    final fullUrl = '${options.uri}';
    buffer.writeln('║ 📌 URL: $fullUrl');
    
    // 请求头
    buffer.writeln('║ ────────────────────────────────────────────────────────────────────');
    buffer.writeln('║ 📋 HEADERS:');
    options.headers.forEach((key, value) {
      // 隐藏token的具体值，避免日志过长
      if (key.toLowerCase() == 'authorization' && value != null) {
        final tokenStr = value.toString();
        if (tokenStr.length > 20) {
          buffer.writeln('║    $key: ${tokenStr.substring(0, 20)}...${tokenStr.substring(tokenStr.length - 10)}');
        } else {
          buffer.writeln('║    $key: $value');
        }
      } else {
        buffer.writeln('║    $key: $value');
      }
    });
    
    // Query Parameters
    if (options.queryParameters.isNotEmpty) {
      buffer.writeln('║ ────────────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📋 QUERY PARAMS:');
      _formatJsonToLog(buffer, Map<String, dynamic>.from(options.queryParameters));
    }
    
    // Request Body
    if (options.data != null) {
      buffer.writeln('║ ────────────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📋 REQUEST BODY:');
      if (options.data is Map) {
        _formatJsonToLog(buffer, Map<String, dynamic>.from(options.data as Map));
      } else if (options.data is List) {
        _formatJsonToLog(buffer, {'_list': options.data});
      } else {
        buffer.writeln('║    ${options.data}');
      }
    }
    
    buffer.writeln('╚═══════════════════════════════════════════════════════════════════');
    AuvLogger.info(buffer.toString(), tag: 'API');
  }

  /// 打印详细响应日志
  void _logResponse(dio.Response response) {
    final buffer = StringBuffer();
    buffer.writeln('╔═══════════════════════════════════════════════════════════════════');
    buffer.writeln('║                        API RESPONSE                                ║');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════════');
    
    // 请求信息
    buffer.writeln('║ 📌 Request: ${response.requestOptions.method} ${response.requestOptions.uri}');
    
    // 状态码
    final statusEmoji = response.statusCode == 200 ? '✅' : '⚠️';
    buffer.writeln('║ 📌 Status: $statusEmoji ${response.statusCode}');
    
    // 响应时间（如果有）
    final responseTime = response.headers.value('x-response-time');
    if (responseTime != null) {
      buffer.writeln('║ 📌 Response Time: $responseTime');
    }
    
    // 响应头
    buffer.writeln('║ ────────────────────────────────────────────────────────────────────');
    buffer.writeln('║ 📋 HEADERS:');
    response.headers.forEach((key, values) {
      buffer.writeln('║    $key: ${values.join(', ')}');
    });
    
    // 响应体
    buffer.writeln('║ ────────────────────────────────────────────────────────────────────');
    buffer.writeln('║ 📋 RESPONSE BODY:');
    if (response.data != null) {
      if (response.data is Map) {
        _formatJsonToLog(buffer, Map<String, dynamic>.from(response.data as Map));
      } else if (response.data is List) {
        _formatJsonToLog(buffer, {'_list': response.data});
      } else {
        buffer.writeln('║    ${response.data}');
      }
    } else {
      buffer.writeln('║    (empty response)');
    }
    
    buffer.writeln('╚═══════════════════════════════════════════════════════════════════');
    AuvLogger.success(buffer.toString(), tag: 'API');
  }

  /// 打印错误日志
  void _logError(dio.DioError error) {
    final buffer = StringBuffer();
    buffer.writeln('╔═══════════════════════════════════════════════════════════════════');
    buffer.writeln('║                        API ERROR                                   ║');
    buffer.writeln('╠═══════════════════════════════════════════════════════════════════');
    
    // 请求信息
    buffer.writeln('║ 📌 Request: ${error.requestOptions.method} ${error.requestOptions.uri}');
    
    // 错误类型
    buffer.writeln('║ 📌 Error Type: ${error.type}');
    buffer.writeln('║ 📌 Error Message: ${error.message}');
    
    // 错误码
    if (error.response != null) {
      buffer.writeln('║ 📌 Response Status: ${error.response?.statusCode}');
      
      // 响应数据
      buffer.writeln('║ ────────────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📋 RESPONSE DATA:');
      if (error.response?.data != null) {
        if (error.response!.data is Map) {
          _formatJsonToLog(buffer, Map<String, dynamic>.from(error.response!.data as Map));
        } else if (error.response!.data is List) {
          _formatJsonToLog(buffer, {'_list': error.response!.data});
        } else {
          buffer.writeln('║    ${error.response?.data}');
        }
      }
    }
    
    // 堆栈跟踪
    if (error.stackTrace != null) {
      buffer.writeln('║ ────────────────────────────────────────────────────────────────────');
      buffer.writeln('║ 📋 STACK TRACE:');
      final stackLines = error.stackTrace.toString().split('\n');
      for (final line in stackLines.take(5)) {
        buffer.writeln('║    $line');
      }
    }
    
    buffer.writeln('╚═══════════════════════════════════════════════════════════════════');
    AuvLogger.error(buffer.toString(), tag: 'API', error: error);
  }

  /// 格式化JSON数据用于日志输出
  void _formatJsonToLog(StringBuffer buffer, Map<String, dynamic> data, {int indent = 0}) {
    final prefix = '║    ' + '  ' * indent;
    
    data.forEach((key, value) {
      if (value is Map) {
        buffer.writeln('$prefix$key:');
        _formatJsonToLog(buffer, Map<String, dynamic>.from(value), indent: indent + 1);
      } else if (value is List) {
        buffer.writeln('$prefix$key:');
        for (var i = 0; i < value.length; i++) {
          if (value[i] is Map) {
            buffer.writeln('$prefix  [$i]:');
            _formatJsonToLog(buffer, Map<String, dynamic>.from(value[i] as Map), indent: indent + 2);
          } else {
            buffer.writeln('$prefix  [$i]: ${value[i]}');
          }
        }
      } else if (value == null) {
        buffer.writeln('$prefix$key: null');
      } else {
        final strValue = value.toString();
        // 格式化长字符串
        if (strValue.length > 200) {
          buffer.writeln('$prefix$key: "${strValue.substring(0, 200)}..." (length: ${strValue.length})');
        } else {
          buffer.writeln('$prefix$key: $strValue');
        }
      }
    });
  }

  Future<dio.Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
  }) {
    AuvLogger.api(path, method: 'GET');
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
    AuvLogger.api(path, method: 'POST');
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
    AuvLogger.api(path, method: 'PUT');
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
    AuvLogger.api(path, method: 'DELETE');
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
