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
  static const bool debugMode = true;
  static const String debugDeviceId = 'd89793035d98c48f-Xiaomi';
  static const String debugUserAgent = 'sela,3.0.8,android Mi Note 3,9,sela100,40';
  static const String debugAuth = 'DSTEST-eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxMDIwNzMwNCIsInN1YiI6IjEwMjA3MzA0IiwiaWF0IjoxNzc0MjQ5ODUwLCJpc3MiOiJzZWxhIiwidXNlciI6IntcImFwcENoYW5uZWxcIjpcInNlbGExMDBcIixcImFwcE5hbWVcIjpcInNlbGFcIixcImNvdW50cnlDb2RlXCI6ODQwLFwiY3JlYXRlZEF0XCI6MTc3NDI0OTQ3NjkwMSxcImRldmljZUlkXCI6XCJkODk3OTMwMzVkOThjNDhmLVhpYW9taVwiLFwibG9naW5UaW1lXCI6MTc3NDI0OTg1MDE5MyxcIm9wZW5JZFwiOlwiejc0NDQ0ODc1NVwiLFwicmVnaXN0ZXJGbGFnXCI6ZmFsc2UsXCJ0eXBlXCI6MCxcInVzZXJJZFwiOjEwMjA3MzA0LFwidXNlcm5hbWVcIjpcIjEwMjA3MzA0XCJ9In0.TF95-6F_sXXNyOlUAAz4ckg0EKgB7Z_xeI6CGr1A2xjn-_37o-mNJ_3rcy0bLA6yI64sSqN7j46vTOBQSLKrdg';
}

/// API 路由及名称
class ApiRoutes {
  // ========== 主播相关 ==========
  static const String getAnchorExposure = '/user/anchor/getAnchorExposure';
  static const String getAnchorExposureName = '获取主播曝光度相关数据';

  static const String callbackByTrialExam = '/user/anchor/callbackByTrialExam';
  static const String callbackByTrialExamName = '试播答题完成';

  static const String getFreeMatchAnchors = '/user/anchor/getFreeMatchAnchors';
  static const String getFreeMatchAnchorsName = '用户随机获取免费匹配主播';

  static const String getAnchorTrialProgress = '/user/anchor/getAnchorTrialProgress';
  static const String getAnchorTrialProgressName = '获取主播试播进度';

  static const String reportAnchorOutScreen = '/user/anchor/reportAnchorOutScreen';
  static const String reportAnchorOutScreenName = '上报主播在通话过程中未露脸';
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

    if (AppConfig.debugMode) {
      _dio.options.headers = {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'authorization': AppConfig.debugAuth,
        'content-type': 'application/json; charset=utf-8',
        'device-id': AppConfig.debugDeviceId,
        'user-agent': AppConfig.debugUserAgent,
        'user-language': 'zh',
      };
    }

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

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }
}

/// API 接口定义
class ApiEndpoint {
  final String path;
  final String name;
  final String method;
  final dynamic data;
  final Map<String, dynamic>? queryParameters;

  const ApiEndpoint({
    required this.path,
    required this.name,
    this.method = 'GET',
    this.data,
    this.queryParameters,
  });
}

/// 获取所有主播相关 API 端点列表
List<ApiEndpoint> getAllEndpoints() {
  return [
    // 主播相关
    const ApiEndpoint(path: ApiRoutes.getAnchorExposure, name: ApiRoutes.getAnchorExposureName),
    const ApiEndpoint(path: ApiRoutes.callbackByTrialExam, name: ApiRoutes.callbackByTrialExamName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.getFreeMatchAnchors, name: ApiRoutes.getFreeMatchAnchorsName, queryParameters: {'size': 10}),
    const ApiEndpoint(path: ApiRoutes.getAnchorTrialProgress, name: ApiRoutes.getAnchorTrialProgressName),
    const ApiEndpoint(path: ApiRoutes.reportAnchorOutScreen, name: ApiRoutes.reportAnchorOutScreenName, method: 'POST', data: {'anchorUserId': 10000389}),
  ];
}

/// 调用 API
Future<bool> callApi(HttpClient client, ApiEndpoint endpoint, String timestamp) async {
  try {
    Response response;
    if (endpoint.method == 'POST') {
      response = await client.post(endpoint.path, data: endpoint.data);
    } else {
      response = await client.get(endpoint.path, queryParameters: endpoint.queryParameters);
    }

    // 保存成功请求的数据
    if (response.statusCode == 200 &&
        response.data is Map &&
        (response.data)['code'] == 0 &&
        client.lastRequest != null &&
        client.lastResponse != null) {
      final outputFile = 'api_debug_${endpoint.name}_$timestamp.txt';
      await saveToFile(outputFile, client.lastRequest!, client.lastResponse!);
      return true;
    }

    return false;
  } catch (e) {
    return false;
  }
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
  print('    📁 已保存到: $filename');
}

void main() async {
  print('===========================================');
  print('    SleaAUV 主播相关 API Debug');
  print('===========================================\n');

  final client = HttpClient();
  final endpoints = getAllEndpoints();
  final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;

  int successCount = 0;
  int failCount = 0;

  for (int i = 0; i < endpoints.length; i++) {
    final endpoint = endpoints[i];
    print('[${i + 1}/${endpoints.length}] 调用: ${endpoint.name}...');

    final success = await callApi(client, endpoint, timestamp);
    if (success) {
      successCount++;
      print('    ✅ 成功\n');
    } else {
      failCount++;
      print('    ❌ 失败\n');
    }
  }

  print('===========================================');
  print('    测试完成: 成功 $successCount, 失败 $failCount');
  print('===========================================');
}
