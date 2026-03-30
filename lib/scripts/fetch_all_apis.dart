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
  // ========== 用户相关 ==========
  static const String userInfo = '/user/info';
  static const String userInfoName = '获取用户信息';

  static const String updateUserInfo = '/user/update';
  static const String updateUserInfoName = '更新用户信息';

  static const String uploadAvatar = '/user/avatar';
  static const String uploadAvatarName = '上传头像';

  // ========== 首页/发现 ==========
  static const String discover = '/discover';
  static const String discoverName = '获取发现页配置';

  static const String discoverList = '/discover/list';
  static const String discoverListName = '获取发现列表';

  // ========== 匹配相关 ==========
  static const String match = '/match';
  static const String matchName = '匹配配置';

  static const String matchStart = '/match/start';
  static const String matchStartName = '开始匹配';

  static const String matchCancel = '/match/cancel';
  static const String matchCancelName = '取消匹配';

  static const String matchHistory = '/match/history';
  static const String matchHistoryName = '匹配历史';

  // ========== 聊天相关 ==========
  static const String chatList = '/chat/list';
  static const String chatListName = '获取聊天列表';

  static const String chatHistory = '/chat/history';
  static const String chatHistoryName = '获取聊天历史';

  static const String sendMessage = '/chat/send';
  static const String sendMessageName = '发送消息';

  // ========== 通话相关 ==========
  static const String callStart = '/call/start';
  static const String callStartName = '发起通话';

  static const String callEnd = '/call/end';
  static const String callEndName = '结束通话';

  static const String callAccept = '/call/accept';
  static const String callAcceptName = '接听通话';

  static const String callReject = '/call/reject';
  static const String callRejectName = '拒绝通话';

  // ========== 充值相关 ==========
  static const String coinBalance = '/coin/balance';
  static const String coinBalanceName = '获取金币余额';

  static const String coinRecharge = '/coin/recharge';
  static const String coinRechargeName = '金币充值';

  static const String coinRecords = '/coin/records';
  static const String coinRecordsName = '金币记录';

  static const String products = '/products';
  static const String productsName = '商品列表';

  // ========== VIP 相关 ==========
  static const String vipInfo = '/vip/info';
  static const String vipInfoName = 'VIP信息';

  static const String vipPurchase = '/vip/purchase';
  static const String vipPurchaseName = '购买VIP';

  // ========== 系统相关 ==========
  static const String appConfig = '/system/app/getConfig';
  static const String appConfigName = '获取应用配置';

  static const String rtmToken = '/system/app/getRtmToken';
  static const String rtmTokenName = '获取声网RTMToken';

  static const String rtcToken = '/system/app/getRtcToken';
  static const String rtcTokenName = '获取声网RTCToken';

  static const String languageConfig = '/system/app/getLanguageConfig';
  static const String languageConfigName = '获取语言配置';

  static const String banners = '/system/banner/getBanners';
  static const String bannersName = '获取Banner列表';

  // ========== 金币商城相关 ==========
  static const String getStores = '/p/exchangeStore/getStores';
  static const String getStoresName = '获取金币商城';

  static const String exchangeDiamonds = '/p/exchangeStore/exchangeDiamonds';
  static const String exchangeDiamondsName = '兑换钻石';

  // ========== payerMax相关 ==========
  static const String createPayerMaxKey = '/p/order/createPayerMaxKey';
  static const String createPayerMaxKeyName = 'payerMax前置组件初始化';

  static const String createPayerMaxOrder = '/p/order/createPayerMaxOrder';
  static const String createPayerMaxOrderName = 'h5页面payerMax充值';

  // ========== 订单相关 ==========
  static const String getOrderSimpleList = '/p/order/getOrderSimpleList';
  static const String getOrderSimpleListName = '查询订单简要信息';
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
  }
}

/// 获取所有 API 端点列表
List<ApiEndpoint> getAllEndpoints() {
  return [
    // 用户相关
    const ApiEndpoint(path: ApiRoutes.userInfo, name: ApiRoutes.userInfoName),
    const ApiEndpoint(path: ApiRoutes.updateUserInfo, name: ApiRoutes.updateUserInfoName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.uploadAvatar, name: ApiRoutes.uploadAvatarName, method: 'POST'),

    // 首页/发现
    const ApiEndpoint(path: ApiRoutes.discover, name: ApiRoutes.discoverName),
    const ApiEndpoint(path: ApiRoutes.discoverList, name: ApiRoutes.discoverListName),

    // 匹配相关
    const ApiEndpoint(path: ApiRoutes.match, name: ApiRoutes.matchName),
    const ApiEndpoint(path: ApiRoutes.matchStart, name: ApiRoutes.matchStartName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.matchCancel, name: ApiRoutes.matchCancelName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.matchHistory, name: ApiRoutes.matchHistoryName),

    // 聊天相关
    const ApiEndpoint(path: ApiRoutes.chatList, name: ApiRoutes.chatListName),
    const ApiEndpoint(path: ApiRoutes.chatHistory, name: ApiRoutes.chatHistoryName),
    const ApiEndpoint(path: ApiRoutes.sendMessage, name: ApiRoutes.sendMessageName, method: 'POST'),

    // 通话相关
    const ApiEndpoint(path: ApiRoutes.callStart, name: ApiRoutes.callStartName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.callEnd, name: ApiRoutes.callEndName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.callAccept, name: ApiRoutes.callAcceptName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.callReject, name: ApiRoutes.callRejectName, method: 'POST'),

    // 充值相关
    const ApiEndpoint(path: ApiRoutes.coinBalance, name: ApiRoutes.coinBalanceName),
    const ApiEndpoint(path: ApiRoutes.coinRecharge, name: ApiRoutes.coinRechargeName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.coinRecords, name: ApiRoutes.coinRecordsName),
    const ApiEndpoint(path: ApiRoutes.products, name: ApiRoutes.productsName),

    // VIP 相关
    const ApiEndpoint(path: ApiRoutes.vipInfo, name: ApiRoutes.vipInfoName),
    const ApiEndpoint(path: ApiRoutes.vipPurchase, name: ApiRoutes.vipPurchaseName, method: 'POST'),

    // 系统相关
    const ApiEndpoint(path: ApiRoutes.appConfig, name: ApiRoutes.appConfigName),
    const ApiEndpoint(path: ApiRoutes.rtmToken, name: ApiRoutes.rtmTokenName),
    const ApiEndpoint(path: ApiRoutes.rtcToken, name: ApiRoutes.rtcTokenName),
    const ApiEndpoint(path: ApiRoutes.languageConfig, name: ApiRoutes.languageConfigName),
    const ApiEndpoint(path: ApiRoutes.banners, name: ApiRoutes.bannersName),

    // 金币商城相关
    const ApiEndpoint(path: ApiRoutes.getStores, name: ApiRoutes.getStoresName),
    const ApiEndpoint(
      path: ApiRoutes.exchangeDiamonds,
      name: ApiRoutes.exchangeDiamondsName,
      method: 'POST',
      data: {'storeId': 1},
    ),

    // payerMax相关
    const ApiEndpoint(
      path: ApiRoutes.createPayerMaxKey,
      name: ApiRoutes.createPayerMaxKeyName,
      method: 'POST',
      data: {'uid': 10207304, 'orderNo': 'TEST_ORDER_123'},
    ),
    const ApiEndpoint(
      path: ApiRoutes.createPayerMaxOrder,
      name: ApiRoutes.createPayerMaxOrderName,
      method: 'POST',
      data: {
        'uid': 10207304,
        'orderNo': 'TEST_ORDER_123',
        'paymentToken': 'test_token',
        'sessionKey': 'test_session',
      },
    ),

    // 订单相关
    const ApiEndpoint(
      path: ApiRoutes.getOrderSimpleList,
      name: ApiRoutes.getOrderSimpleListName,
      method: 'POST',
      data: {
        'pageNum': 1,
        'pageSize': 10,
        'condition': {'userId': 10207304},
      },
    ),
  ];
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
}

/// 保存Markdown文档
Future<void> saveMarkdown(String filename, String content) async {
  final file = File(filename);
  await file.writeAsString(content);
}

/// 生成汇总Markdown文档
String generateSummaryMarkdown(List<ApiCallResult> results, String timestamp) {
  final buffer = StringBuffer();

  buffer.writeln('# API接口文档汇总');
  buffer.writeln();
  buffer.writeln('## 基本信息');
  buffer.writeln();
  buffer.writeln('- **生成时间**: ${DateTime.now().toIso8601String()}');
  buffer.writeln('- **测试环境**: ${AppConfig.baseUrl}');
  buffer.writeln('- **测试用户**: ${AppConfig.debugAuth.substring(0, 20)}...');
  buffer.writeln();

  // 成功和失败统计
  final successCount = results.where((r) => r.success).length;
  final failCount = results.where((r) => !r.success).length;

  buffer.writeln('## 测试结果汇总');
  buffer.writeln();
  buffer.writeln('| 状态 | 数量 |');
  buffer.writeln('|:-----|-----:|');
  buffer.writeln('| 成功 | $successCount |');
  buffer.writeln('| 失败 | $failCount |');
  buffer.writeln('| 合计 | ${results.length} |');
  buffer.writeln();

  // 成功接口列表
  buffer.writeln('## 成功接口列表');
  buffer.writeln();
  buffer.writeln('| 序号 | 接口名称 | 请求方式 | 接口路径 |');
  buffer.writeln('|:----:|:--------|:--------:|:---------|');

  int successIndex = 1;
  final endpoints = getAllEndpoints();
  for (int i = 0; i < results.length; i++) {
    if (results[i].success) {
      final endpoint = endpoints[i];
      buffer.writeln('| $successIndex | ${endpoint.name} | ${endpoint.method} | `${endpoint.path}` |');
      successIndex++;
    }
  }
  buffer.writeln();

  // 失败接口列表
  if (failCount > 0) {
    buffer.writeln('## 失败接口列表');
    buffer.writeln();
    buffer.writeln('| 序号 | 接口名称 | 请求方式 | 接口路径 | 错误原因 |');
    buffer.writeln('|:----:|:--------|:--------:|:---------|:---------|');

    int failIndex = 1;
    for (int i = 0; i < results.length; i++) {
      if (!results[i].success) {
        final endpoint = endpoints[i];
        final error = results[i].error ?? '未知错误';
        buffer.writeln('| $failIndex | ${endpoint.name} | ${endpoint.method} | `${endpoint.path}` | $error |');
        failIndex++;
      }
    }
    buffer.writeln();
  }

  return buffer.toString();
}

void main() async {
  print('===========================================');
  print('    SleaAUV API Debug - 全量接口测试');
  print('===========================================\n');

  final client = HttpClient();
  final endpoints = getAllEndpoints();
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
  final summaryContent = generateSummaryMarkdown(results, timestamp);
  await saveMarkdown('api_docs_summary_$timestamp.md', summaryContent);

  // 生成成功接口的详细Markdown文档
  if (successEndpoints.isNotEmpty) {
    final docBuffer = StringBuffer();
    docBuffer.writeln('# API接口详细文档');
    docBuffer.writeln();
    docBuffer.writeln('> 生成时间: ${DateTime.now().toIso8601String()}');
    docBuffer.writeln();
    docBuffer.writeln('---');
    docBuffer.writeln();

    for (final se in successEndpoints) {
      docBuffer.write(generateApiMarkdown(se.endpoint, se.request, se.response));
    }

    await saveMarkdown('api_docs_detail_$timestamp.md', docBuffer.toString());
  }

  // 统计
  final successCount = results.where((r) => r.success).length;
  final failCount = results.where((r) => !r.success).length;

  print('===========================================');
  print('    测试完成: 成功 $successCount, 失败 $failCount');
  print('===========================================');
  print('\n生成文档:');
  print('  - api_docs_summary_$timestamp.md (汇总)');
  if (successEndpoints.isNotEmpty) {
    print('  - api_docs_detail_$timestamp.md (详细)');
  }
}

/// 成功接口数据
class _SuccessEndpoint {
  final ApiEndpoint endpoint;
  final RequestData request;
  final ResponseData response;

  _SuccessEndpoint(this.endpoint, this.request, this.response);
}
