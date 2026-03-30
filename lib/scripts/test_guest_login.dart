#!/usr/bin/env dart
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

/// 全局静态配置
class AppConfig {
  static const String appName = 'SleaAUV';
  static const String appVersion = '1.0.0';
  static const String baseUrl = 'https://testapi.selalive.com';

  // Debug 模式配置（用于其他需要认证的接口）
  static const String debugDeviceId = 'f47ac10b-58cc-4372-a567-0e02b2c3d479-OnePlus';
  static const String debugUserAgent = 'sela,3.0.8,android OnePlus 9 Pro,11,sela100,50';
}

/// API 路由
class ApiRoutes {
  // 应用配置
  static const String appConfig = '/system/app/getConfig';
  static const String appConfigName = '获取应用配置';

  // 游客登录
  static const String guestLogin = '/user/login/guest';
  static const String guestLoginName = '游客登录';
}

/// 请求数据记录
class RequestData {
  final String url;
  final String method;
  final Map<String, dynamic> headers;
  final dynamic body;

  RequestData({
    required this.url,
    required this.method,
    required this.headers,
    this.body,
  });
}

/// 响应数据记录
class ResponseData {
  final int statusCode;
  final Map<String, dynamic> headers;
  final dynamic body;

  ResponseData({
    required this.statusCode,
    required this.headers,
    required this.body,
  });
}

/// 签名工具类
class SignUtil {
  /// 生成签名
  /// 规则：
  /// 1. 将请求参数按照参数名ASCII码从小到大排序（字典序）
  /// 2. 使用URL键值对格式拼接成字符串 stringA
  /// 3. 在stringA最后拼接 time 和 key，得到 stringSignTemp
  /// 4. 对stringSignTemp进行MD5运算，结果转小写得到sign值
  static String generateSign(Map<String, dynamic> params, String time, String key) {
    // 第一步：过滤空值，并按参数名ASCII码从小到大排序（字典序）
    final sortedKeys = params.keys
        .where((k) => params[k] != null && params[k].toString().isNotEmpty)
        .toList()
      ..sort();

    // 第二步：拼接成URL键值对格式
    final stringA = sortedKeys.map((k) => '$k=${params[k]}').join('&');

    // 第三步：在最后拼接 time 和 key
    final stringSignTemp = '$stringA&time=$time&key=$key';

    // 第四步：MD5运算并转小写
    final md5Hash = md5.convert(utf8.encode(stringSignTemp));

    return md5Hash.toString().toLowerCase();
  }
}

/// HTTP 客户端
class HttpClient {
  final Dio _dio;
  RequestData? _lastRequest;
  ResponseData? _lastResponse;

  HttpClient() : _dio = Dio() {
    _dio.options.baseUrl = AppConfig.baseUrl;
    _dio.options.connectTimeout = 30000;
    _dio.options.receiveTimeout = 30000;
    _dio.options.validateStatus = (status) => true;

    _dio.options.headers = {
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'content-type': 'application/json; charset=utf-8',
      'device-id': AppConfig.debugDeviceId,
      'user-agent': AppConfig.debugUserAgent,
      'user-language': 'zh',
    };

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        _lastRequest = RequestData(
          url: options.uri.toString(),
          method: options.method,
          headers: Map<String, dynamic>.from(options.headers),
          body: options.data,
        );
        handler.next(options);
      },
      onResponse: (response, handler) {
        final headers = <String, dynamic>{};
        response.headers.forEach((name, values) {
          headers[name] = values.join(', ');
        });
        _lastResponse = ResponseData(
          statusCode: response.statusCode ?? 0,
          headers: headers,
          body: response.data,
        );
        handler.next(response);
      },
    ));
  }

  RequestData? get lastRequest => _lastRequest;
  ResponseData? get lastResponse => _lastResponse;

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data, Map<String, String>? headers}) async {
    return await _dio.post(path, data: data, options: Options(headers: headers));
  }
}

/// 获取应用配置
Future<Map<String, dynamic>?> fetchAppConfig(HttpClient client) async {
  print('\n[1/2] 正在获取应用配置...');
  final response = await client.get(ApiRoutes.appConfig);

  if (response.statusCode == 200) {
    final data = response.data;
    if (data is Map<String, dynamic> && data['code'] == 0) {
      print('✓ 应用配置获取成功');
      return data['data'];
    } else {
      print('✗ 应用配置返回异常: ${data['message']}');
    }
  }
  return null;
}

/// 生成随机密码（32位MD5格式）
String generateRandomPassword() {
  // 使用更随机的种子
  final random = DateTime.now().microsecond + (DateTime.now().millisecond * 1000);
  final input = 'guest_test_$random';
  final bytes = utf8.encode(input);
  final digest = md5.convert(bytes);
  return digest.toString();
}

/// 游客登录
Future<Map<String, dynamic>?> guestLogin(HttpClient client, String signKey) async {
  print('\n[2/2] 正在调用游客登录接口...');

  // 生成随机参数
  final password = generateRandomPassword();
  final aidLimit = 0;
  final aid = 'google_${DateTime.now().millisecondsSinceEpoch}';
  final useVpn = 0;

  // 构建请求参数
  final params = <String, dynamic>{
    'password': password,
    'aidLimit': aidLimit,
    'aid': aid,
    'useVpn': useVpn,
  };

  // 生成签名
  final time = DateTime.now().millisecondsSinceEpoch.toString();
  final sign = SignUtil.generateSign(params, time, signKey);

  print('\n签名计算过程:');
  print('  参数: $params');
  print('  time: $time');
  print('  key: $signKey');
  print('  生成的签名: $sign');

  // 设置请求头
  final headers = {
    's-time': time,
    's-sign': sign,
  };

  final response = await client.post(
    ApiRoutes.guestLogin,
    data: params,
    headers: headers,
  );

  // 打印请求和响应数据
  print('\n========== 请求数据 ==========');
  print('URL: ${ApiRoutes.guestLogin}');
  print('Method: POST');
  print('Headers:');
  headers.forEach((k, v) => print('  $k: $v'));
  print('Body:');
  print(JsonEncoder.withIndent('  ').convert(params));

  if (response.statusCode == 200) {
    final data = response.data;
    print('\n========== 返回报文 ==========');
    print('Status: ${response.statusCode}');
    print('Body:');
    print(JsonEncoder.withIndent('  ').convert(data));

    if (data is Map<String, dynamic>) {
      if (data['code'] == 0) {
        print('\n✓ 游客登录成功!');
        return data['data'];
      } else {
        print('\n✗ 游客登录失败: ${data['message']}');
      }
    }
  }
  return null;
}

/// 保存数据到文件
Future<void> saveToFile(String filename, RequestData request, ResponseData response) async {
  final content = '''
========== 请求数据 ==========
URL: ${request.url}
Method: ${request.method}

--- Headers ---
${const JsonEncoder.withIndent('  ').convert(request.headers)}

--- Body ---
${request.body != null ? const JsonEncoder.withIndent('  ').convert(request.body) : '(无)'}

========== 返回报文 ==========
Status: ${response.statusCode}

--- Headers ---
${const JsonEncoder.withIndent('  ').convert(response.headers)}

--- Body ---
${const JsonEncoder.withIndent('  ').convert(response.body)}
''';

  final file = File(filename);
  await file.writeAsString(content);
  print('已保存到: $filename');
}

void main() async {
  print('=' * 50);
  print('SleaAUV 游客登录测试');
  print('=' * 50);

  final client = HttpClient();

  // 第一步：获取应用配置（获取签名key）
  final config = await fetchAppConfig(client);

  if (config != null) {
    // 保存应用配置请求日志
    if (client.lastRequest != null && client.lastResponse != null) {
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      await saveToFile('api_debug_${ApiRoutes.appConfigName}_$timestamp.txt', client.lastRequest!, client.lastResponse!);
    }

    // 打印配置信息
    print('\n配置信息:');
    print('  ok (签名key): ${config['ok'] ?? '无'}');

    final signKey = config['ok']?.toString() ?? '';
    if (signKey.isEmpty) {
      print('✗ 签名key为空，无法进行签名');
      return;
    }

    // 第二步：调用游客登录
    final loginResult = await guestLogin(client, signKey);

    if (loginResult != null) {
      // 保存登录请求日志
      if (client.lastRequest != null && client.lastResponse != null) {
        final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
        await saveToFile('api_debug_${ApiRoutes.guestLoginName}_$timestamp.txt', client.lastRequest!, client.lastResponse!);
      }

      // 打印登录结果
      print('\n登录结果:');
      print('  userId: ${loginResult['userId'] ?? '无'}');
      print('  username: ${loginResult['username'] ?? '无'}');
      print('  appChannel: ${loginResult['appChannel'] ?? '无'}');
      print('  deregisterFlag: ${loginResult['deregisterFlag'] ?? '无'}');
      print('  authorization: ${loginResult['authorization'] != null ? '${loginResult['authorization'].toString().substring(0, 50)}...' : '无'}');
    }
  } else {
    print('✗ 无法获取应用配置');

    // 保存错误请求日志
    if (client.lastRequest != null && client.lastResponse != null) {
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      await saveToFile('api_debug_${ApiRoutes.appConfigName}_error_$timestamp.txt', client.lastRequest!, client.lastResponse!);
    }
  }

  print('\n' + '=' * 50);
  print('测试完成');
  print('=' * 50);
}
