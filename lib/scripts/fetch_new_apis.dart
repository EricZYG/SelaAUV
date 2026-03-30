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
  final String? description;

  const ApiEndpoint({
    required this.path,
    required this.name,
    this.method = 'GET',
    this.data,
    this.description,
  });
}

/// API 调用结果
class ApiCallResult {
  final bool success;
  final RequestData? request;
  final ResponseData? response;
  final String? error;

  ApiCallResult({
    required this.success,
    this.request,
    this.response,
    this.error,
  });
}

/// 调用 API
Future<ApiCallResult> callApi(HttpClient client, ApiEndpoint endpoint) async {
  try {
    Response response;
    if (endpoint.method == 'POST') {
      response = await client.post(endpoint.path, data: endpoint.data);
    } else {
      response = await client.get(endpoint.path);
    }

    // 保存成功请求的数据
    if (response.statusCode == 200 &&
        response.data is Map &&
        (response.data)['code'] == 0 &&
        client.lastRequest != null &&
        client.lastResponse != null) {
      return ApiCallResult(
        success: true,
        request: client.lastRequest,
        response: client.lastResponse,
      );
    }

    // 返回失败信息
    String? error;
    if (response.data is Map) {
      error = response.data['message'] ?? '未知错误';
    } else {
      error = 'HTTP ${response.statusCode}';
    }

    return ApiCallResult(
      success: false,
      error: error,
      request: client.lastRequest,
      response: client.lastResponse,
    );
  } catch (e) {
    return ApiCallResult(
      success: false,
      error: e.toString(),
    );
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
  print('  文件已保存: $filename');
}

/// 生成单个API的Markdown文档
String generateApiMarkdown(ApiEndpoint endpoint, RequestData request, ResponseData response) {
  final buffer = StringBuffer();

  buffer.writeln('## ${endpoint.name}');
  buffer.writeln();

  if (endpoint.description != null) {
    buffer.writeln('**简要描述**: ${endpoint.description}');
    buffer.writeln();
  }

  buffer.writeln('**请求URL**: `${request.url}`');
  buffer.writeln();
  buffer.writeln('**请求方式**: ${request.method}');
  buffer.writeln();

  // 请求参数
  if (endpoint.data != null) {
    buffer.writeln('### 请求参数');
    buffer.writeln();
    buffer.writeln('|参数名|必选|类型|说明|');
    buffer.writeln('|:----|:---|:---|:---|');

    final Map<String, dynamic> data = endpoint.data is Map ? Map<String, dynamic>.from(endpoint.data) : {};
    _parseParams(data, buffer);

    buffer.writeln();
  } else {
    buffer.writeln('### 请求参数');
    buffer.writeln();
    buffer.writeln('*无参数*');
    buffer.writeln();
  }

  // 返回示例
  buffer.writeln('### 返回示例');
  buffer.writeln();
  buffer.writeln('```json');
  buffer.writeln(const JsonEncoder.withIndent('  ').convert(response.body));
  buffer.writeln('```');
  buffer.writeln();

  // 返回字段说明
  if (response.body is Map && response.body['data'] != null) {
    buffer.writeln('### 返回字段说明');
    buffer.writeln();
    buffer.writeln('|参数名|类型|说明|');
    buffer.writeln('|:----|:---|:---|');
    _parseResponseFields(response.body['data'], buffer);
    buffer.writeln();
  }

  buffer.writeln('---');
  buffer.writeln();

  return buffer.toString();
}

/// 解析请求参数
void _parseParams(Map<String, dynamic> data, StringBuffer buffer, [String prefix = '']) {
  for (final entry in data.entries) {
    final key = entry.key;
    final value = entry.value;
    final fullKey = prefix.isEmpty ? key : '$prefix.$key';

    if (value is Map) {
      buffer.writeln('|$fullKey|是|Object|对象参数|');
      _parseParams(Map<String, dynamic>.from(value), buffer, fullKey);
    } else if (value is List) {
      final type = value.isNotEmpty ? _getType(value[0]) : 'Array';
      buffer.writeln('|$fullKey|是|$type|数组参数|');
    } else {
      final type = _getType(value);
      buffer.writeln('|$key|是|$type|$value|');
    }
  }
}

/// 获取值类型
String _getType(dynamic value) {
  if (value == null) return 'null';
  if (value is int) return 'Integer';
  if (value is double) return 'Double';
  if (value is bool) return 'Boolean';
  if (value is String) return 'String';
  if (value is Map) return 'Object';
  if (value is List) return 'Array';
  return 'Object';
}

/// 解析返回字段
void _parseResponseFields(dynamic data, StringBuffer buffer, [String prefix = '']) {
  if (data is Map) {
    for (final entry in data.entries) {
      final key = entry.key;
      final value = entry.value;
      final fullKey = prefix.isEmpty ? key : '$prefix.$key';

      if (value is Map) {
        buffer.writeln('|$fullKey|Object|对象|');
        _parseResponseFields(value, buffer, fullKey);
      } else if (value is List) {
        final type = value.isNotEmpty ? _getType(value[0]) : 'Array';
        final desc = value.isNotEmpty && value[0] is Map ? '数组对象' : '数组';
        buffer.writeln('|$fullKey|$type\[\]|${desc}|');
        if (value.isNotEmpty && value[0] is Map) {
          _parseResponseFields(value[0], buffer, '$fullKey[]');
        }
      } else {
        final type = _getType(value);
        buffer.writeln('|$key|$type|$value|');
      }
    }
  } else if (data is List && data.isNotEmpty) {
    _parseResponseFields(data[0], buffer, prefix);
  }
}

/// 保存Markdown文档
Future<void> saveMarkdown(String filename, String content) async {
  final file = File(filename);
  await file.writeAsString(content);
  print('  文件已保存: $filename');
}

/// 获取新增的三个API端点列表
List<ApiEndpoint> getNewEndpoints() {
  return [
    // 获取翻译文案
    const ApiEndpoint(
      path: '/system/app/getTranslates',
      name: '获取翻译文案',
      method: 'GET',
      description: '获取翻译文案，可登录可不登录',
    ),
    // 获取违规处罚配置
    const ApiEndpoint(
      path: '/call/violate/getConfig',
      name: '获取违规处罚配置',
      method: 'GET',
      description: '获取违规处罚配置',
    ),
    // 查询地区列表
    const ApiEndpoint(
      path: '/system/country/getAreas',
      name: '查询地区列表',
      method: 'GET',
      description: '查询地区列表',
    ),
  ];
}

void main() async {
  print('===========================================');
  print('    SleaAUV API Debug - 新增接口测试');
  print('===========================================\n');

  final client = HttpClient();
  final endpoints = getNewEndpoints();
  final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').replaceAll('.', '-');

  // 调用所有接口
  final results = <ApiCallResult>[];
  final successEndpoints = <_SuccessEndpoint>[];

  for (int i = 0; i < endpoints.length; i++) {
    final endpoint = endpoints[i];
    print('[${i + 1}/${endpoints.length}] 调用: ${endpoint.name}...');

    final result = await callApi(client, endpoint);
    results.add(result);

    if (result.success) {
      print('    ✅ 成功');
      // 保存单个接口文件
      final outputFile = 'api_debug_${endpoint.name}_$timestamp.txt';
      await saveToFile(outputFile, result.request!, result.response!);
      // 收集成功接口用于生成汇总文档
      successEndpoints.add(_SuccessEndpoint(endpoint, result.request!, result.response!));
    } else {
      print('    ❌ 失败: ${result.error}');
    }
    print('');
  }

  // 生成汇总文档
  print('正在生成文档...\n');
  
  final summaryBuffer = StringBuffer();
  summaryBuffer.writeln('# 新增API接口测试报告');
  summaryBuffer.writeln();
  summaryBuffer.writeln('## 基本信息');
  summaryBuffer.writeln();
  summaryBuffer.writeln('- **生成时间**: ${DateTime.now().toIso8601String()}');
  summaryBuffer.writeln('- **测试环境**: ${AppConfig.baseUrl}');
  summaryBuffer.writeln('- **测试用户**: ${AppConfig.debugAuth.substring(0, 20)}...');
  summaryBuffer.writeln();

  // 成功和失败统计
  final successCount = results.where((r) => r.success).length;
  final failCount = results.where((r) => !r.success).length;

  summaryBuffer.writeln('## 测试结果汇总');
  summaryBuffer.writeln();
  summaryBuffer.writeln('| 状态 | 数量 |');
  summaryBuffer.writeln('|:-----|-----:|');
  summaryBuffer.writeln('| 成功 | $successCount |');
  summaryBuffer.writeln('| 失败 | $failCount |');
  summaryBuffer.writeln('| 合计 | ${results.length} |');
  summaryBuffer.writeln();

  // 成功接口列表
  summaryBuffer.writeln('## 成功接口列表');
  summaryBuffer.writeln();
  summaryBuffer.writeln('| 序号 | 接口名称 | 请求方式 | 接口路径 |');
  summaryBuffer.writeln('|:----:|:--------|:--------:|:---------|');

  int successIndex = 1;
  for (int i = 0; i < results.length; i++) {
    if (results[i].success) {
      final endpoint = endpoints[i];
      summaryBuffer.writeln('| $successIndex | ${endpoint.name} | ${endpoint.method} | `${endpoint.path}` |');
      successIndex++;
    }
  }
  summaryBuffer.writeln();

  // 失败接口列表
  if (failCount > 0) {
    summaryBuffer.writeln('## 失败接口列表');
    summaryBuffer.writeln();
    summaryBuffer.writeln('| 序号 | 接口名称 | 请求方式 | 接口路径 | 错误原因 |');
    summaryBuffer.writeln('|:----:|:--------|:--------:|:---------|:---------|');

    int failIndex = 1;
    for (int i = 0; i < results.length; i++) {
      if (!results[i].success) {
        final endpoint = endpoints[i];
        final error = results[i].error ?? '未知错误';
        summaryBuffer.writeln('| $failIndex | ${endpoint.name} | ${endpoint.method} | `${endpoint.path}` | $error |');
        failIndex++;
      }
    }
    summaryBuffer.writeln();
  }

  await saveMarkdown('new_apis_summary_$timestamp.md', summaryBuffer.toString());

  // 生成成功接口的详细Markdown文档
  if (successEndpoints.isNotEmpty) {
    final docBuffer = StringBuffer();
    docBuffer.writeln('# 新增API接口详细文档');
    docBuffer.writeln();
    docBuffer.writeln('> 生成时间: ${DateTime.now().toIso8601String()}');
    docBuffer.writeln();
    docBuffer.writeln('---');
    docBuffer.writeln();

    for (final se in successEndpoints) {
      docBuffer.write(generateApiMarkdown(se.endpoint, se.request, se.response));
    }

    await saveMarkdown('new_apis_detail_$timestamp.md', docBuffer.toString());
  }

  // 统计
  print('===========================================');
  print('    测试完成: 成功 $successCount, 失败 $failCount');
  print('===========================================');
  print('\n生成文档:');
  print('  - new_apis_summary_$timestamp.md (汇总)');
  if (successEndpoints.isNotEmpty) {
    print('  - new_apis_detail_$timestamp.md (详细)');
  }
}

/// 成功接口数据
class _SuccessEndpoint {
  final ApiEndpoint endpoint;
  final RequestData request;
  final ResponseData response;

  _SuccessEndpoint(this.endpoint, this.request, this.response);
}
