/// API测试脚本 - 公共配置
library;

import 'package:dio/dio.dart';

/// API配置
class ApiConfig {
  /// API基础URL
  static const String baseUrl = 'https://testapi.selalive.com';

  /// 连接超时时间(ms)
  static const int connectTimeout = 30000;

  /// 接收超时时间(ms)
  static const int receiveTimeout = 30000;

  /// 请求头内容类型
  static const String contentType = 'application/json; charset=utf-8';
}

/// 调试模式配置
class DebugConfig {
  /// 是否启用调试模式
  static const bool debugMode = true;

  /// 设备ID
  static const String deviceId = 'd89793035d98c48f-Xiaomi';

  /// UserAgent
  static const String userAgent = 'sela,3.0.8,android Mi Note 3,9,sela100,40';

  /// 认证Token
  static const String auth = 'DSTEST-eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxMDIwODk4MiIsInN1YiI6IjEwMjA4OTgyIiwiaWF0IjoxNzc0NTEwMDcxLCJpc3MiOiJzZWxhIiwidXNlciI6IntcImFwcENoYW5uZWxcIjpcInNlbGExMDBcIixcImFwcE5hbWVcIjpcInNlbGFcIixcImNvdW50cnlDb2RlXCI6ODQwLFwiY3JlYXRlZEF0XCI6MTc3NDUxMDA3MTcyMCxcImRldmljZUlkXCI6XCJkODk3OTMwMzVkOThjNDhmLVhpYW9taVwiLFwibG9naW5UaW1lXCI6MTc3NDUxMDA3MTgwOCxcIm9wZW5JZFwiOlwiejc0NDQ0ODc1NVwiLFwicmVnaXN0ZXJGbGFnXCI6dHJ1ZSxcInR5cGVcIjowLFwidXNlcklkXCI6MTAyMDg5ODIsXCJ1c2VybmFtZVwiOlwiMTAyMDg5ODJcIn0ifQ.zf-DGsTg29bgvszLM62ZdndTXIDA3Q5CHiRij41lYKw0dovjurKc82seI2KML_0Nhp_6ehoxj11ePsxgXbBx2Q';
}

/// 获取调试模式下的公共请求头
Map<String, String> getDebugHeaders() {
  if (!DebugConfig.debugMode) {
    return {};
  }
  return {
    'Accept': '*/*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Connection': 'keep-alive',
    'authorization': DebugConfig.auth,
    'content-type': ApiConfig.contentType,
    'device-id': DebugConfig.deviceId,
    'user-agent': DebugConfig.userAgent,
    'user-language': 'zh',
  };
}

/// 创建Dio客户端
Dio createDioClient() {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: ApiConfig.connectTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    validateStatus: (status) => true,
  ));

  dio.options.headers.addAll(getDebugHeaders());

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));

  return dio;
}
