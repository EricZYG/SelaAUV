#!/usr/bin/env dart
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

/// 全局静态配置
class AppConfig {
  static const String appName = 'SleaAUV';
  static const String appVersion = '1.0.0';
  static const String baseUrl = 'https://testapi.selalive.com';

  // Debug 模式配置
  static const String debugDeviceId = 'f47ac10b-58cc-4372-a567-0e02b2c3d479';
  static const String debugUserAgent = 'sela,3.0.8,android OnePlus 9 Pro,11,sela100,50';
}

/// API 路由
class ApiRoutes {
  static const String appConfig = '/system/app/getConfig';
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
}

/// 获取应用配置
Future<Map<String, dynamic>?> fetchAppConfig(HttpClient client) async {
  print('正在获取应用配置...');
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
  print('SleaAUV 应用配置接口测试');
  print('=' * 50);

  final client = HttpClient();
  final config = await fetchAppConfig(client);

  if (config != null && client.lastRequest != null && client.lastResponse != null) {
    // 保存请求日志
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
    await saveToFile('api_debug_app_config_$timestamp.txt', client.lastRequest!, client.lastResponse!);

    // 打印关键信息
    print('\n关键配置信息:');
    print('  ok (签名key): ${config['ok'] ?? '无'}');
    print('  liveUrl: ${config['liveUrl'] ?? '无'}');
    print('  agoraAppId: ${config['agoraAppId'] ?? '无'}');
    print('  versionUpdate: ${config['versionUpdate'] ?? '无'}');
  } else {
    print('✗ 请求失败');
    if (client.lastRequest != null && client.lastResponse != null) {
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
      await saveToFile('api_debug_app_config_error_$timestamp.txt', client.lastRequest!, client.lastResponse!);
    }
  }

  print('\n' + '=' * 50);
  print('测试完成');
  print('=' * 50);
}
