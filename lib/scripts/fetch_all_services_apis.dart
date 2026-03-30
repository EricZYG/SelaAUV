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

/// API 路由
class ApiRoutes {
  // UserService
  static const String userInfo = '/user/info';
  static const String getUserPropVo = '/user/prop/getUserPropVo';
  static const String getPortraits = '/user/user/getPortraits';
  static const String isHasInviteRecord = '/user/user/IsHasInviteRecord';
  static const String getInviteUserVoList = '/user/user/getInviteUserVoList';
  static const String getInviteInfo = '/user/user/getInviteInfo';
  static const String getInviteRecord = '/user/user/getInviteRecord';
  static const String checkUserDetail = '/user/user/checkUserDetail';
  static const String getDialogDetail = '/user/advance/getDialogDetail';
  static const String getRewards = '/user/user/getRewards';
  static const String getDiamondRanking = '/user/user/getDiamondRanking';
  static const String updateSexMale = '/user/user/updateSexMale';
  static const String getAnchorVideoPriceConfig = '/user/anchor/getAnchorVideoPriceConfig';
  static const String getMomentReward = '/user/task/getMomentReward';

  // TaskService
  static const String getUserTaskList = '/user/task/getUserTaskList';

  // MatchService
  static const String matchHistory = '/match/history';

  // ChatService
  static const String chatList = '/chat/list';

  // ChargeService
  static const String coinBalance = '/coin/balance';
  static const String products = '/products';
  static const String coinRecords = '/coin/records';
  static const String vipInfo = '/vip/info';

  // AnchorService
  static const String getAivAnchor = '/user/anchor/getAivAnchor';
  static const String getAnchorVideoConfig = '/user/anchor/getAnchorVideoConfig';
  static const String closeMatching = '/user/anchor/closeMatching';
  static const String getAnchorAlbumVideoVo = '/user/anchor/getAnchorAlbumVideoVo';
  static const String callbackByTrialVideo = '/user/anchor/callbackByTrialVideo';
  static const String getMatchBusyLevel = '/user/anchor/getMatchBusyLevel';
  static const String getMatchRanking = '/user/anchor/getMatchRanking';
  static const String getCoinRanking = '/user/anchor/getCoinRanking';
  static const String tryGetMatchAnchor = '/user/anchor/tryGetMatchAnchor';
  static const String getAnchorChatImgVo = '/user/anchor/getAnchorChatImgVo';
  static const String setActive = '/user/anchor/setActive';
  static const String getAnchorRadarChart = '/user/anchor/getAnchorRadarChart';
  static const String getMatchLimit = '/user/anchor/getMatchLimit';
  static const String getQuickGreetAnchors = '/user/anchor/getQuickGreetAnchors';
  static const String getAnchorPrivacyChatImg = '/user/anchor/getAnchorPrivacyChatImg';
  static const String getAnchorAuthV2 = '/user/anchor/getAnchorAuthV2';
  static const String getAnchorLevelV2 = '/user/anchor/getAnchorLevelV2';
  static const String getMultiAnchor = '/user/anchor/getMultiAnchor';
  static const String getGuildLoginInfo = '/user/anchor/getGuildLoginInfo';
  static const String getAnchorExposure = '/user/anchor/getAnchorExposure';
  static const String callbackByTrialExam = '/user/anchor/callbackByTrialExam';
  static const String getFreeMatchAnchors = '/user/anchor/getFreeMatchAnchors';
  static const String getAnchorTrialProgress = '/user/anchor/getAnchorTrialProgress';
  static const String setInScreen = '/user/anchor/setInScreen';
  static const String setOutScreen = '/user/anchor/setOutScreen';
  static const String tryGetScreenMatchAnchor = '/user/anchor/tryGetScreenMatchAnchor';

  // System
  static const String appConfig = '/system/app/getConfig';
  static const String banners = '/system/banner/getBanners';
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

/// 获取所有无参数 API 端点列表
List<ApiEndpoint> getAllEndpoints() {
  return [
    // ========== UserService ==========
    const ApiEndpoint(path: ApiRoutes.userInfo, name: '获取用户信息'),
    const ApiEndpoint(path: ApiRoutes.getUserPropVo, name: '获取用户背包道具列表'),
    const ApiEndpoint(path: ApiRoutes.getPortraits, name: '随机获取头像', queryParameters: {'size': 10}),
    const ApiEndpoint(path: ApiRoutes.getInviteUserVoList, name: '获取邀请奖励记录列表'),
    const ApiEndpoint(path: ApiRoutes.getInviteInfo, name: '获取邀请信息'),
    const ApiEndpoint(path: ApiRoutes.checkUserDetail, name: '检查用户资料完整度'),
    const ApiEndpoint(path: ApiRoutes.getDialogDetail, name: '获取高级用户弹窗详情'),
    const ApiEndpoint(path: ApiRoutes.getRewards, name: '获取随机15条奖励飘屏'),
    const ApiEndpoint(path: ApiRoutes.getDiamondRanking, name: '获取用户钻石排行', queryParameters: {'timeLevel': 1}),
    const ApiEndpoint(path: ApiRoutes.getAnchorVideoPriceConfig, name: '获取主播视频价格配置'),
    const ApiEndpoint(path: ApiRoutes.getMomentReward, name: '获取发布动态奖励的金币数'),

    // ========== TaskService ==========
    const ApiEndpoint(path: ApiRoutes.getUserTaskList, name: '获取我的任务列表'),

    // ========== MatchService ==========
    const ApiEndpoint(path: ApiRoutes.matchHistory, name: '获取匹配历史'),

    // ========== ChatService ==========
    const ApiEndpoint(path: ApiRoutes.chatList, name: '获取聊天列表'),

    // ========== ChargeService ==========
    const ApiEndpoint(path: ApiRoutes.coinBalance, name: '获取金币余额'),
    const ApiEndpoint(path: ApiRoutes.products, name: '获取商品列表'),
    const ApiEndpoint(path: ApiRoutes.vipInfo, name: '获取VIP信息'),

    // ========== AnchorService ==========
    const ApiEndpoint(path: ApiRoutes.getAivAnchor, name: '获取AIV主播'),
    const ApiEndpoint(path: ApiRoutes.getAnchorVideoConfig, name: '获取主播录制视频配置'),
    const ApiEndpoint(path: ApiRoutes.getAnchorAlbumVideoVo, name: '获取主播个人相册和视频'),
    const ApiEndpoint(path: ApiRoutes.getMatchBusyLevel, name: '查看匹配主播繁忙程度'),
    const ApiEndpoint(path: ApiRoutes.getMatchRanking, name: '获取匹配收益排行榜', queryParameters: {'timeLevel': 1}),
    const ApiEndpoint(path: ApiRoutes.getCoinRanking, name: '获取所有收益排行榜', queryParameters: {'timeLevel': 1}),
    const ApiEndpoint(path: ApiRoutes.tryGetMatchAnchor, name: '获取匹配主播（不扣款）'),
    const ApiEndpoint(path: ApiRoutes.getAnchorChatImgVo, name: '获取主播聊天图片'),
    const ApiEndpoint(path: ApiRoutes.getAnchorRadarChart, name: '获取我的雷达图相关数据'),
    const ApiEndpoint(path: ApiRoutes.getMatchLimit, name: '查询匹配限制信息'),
    const ApiEndpoint(path: ApiRoutes.getQuickGreetAnchors, name: '获取一键打招呼主播列表'),
    const ApiEndpoint(path: ApiRoutes.getAnchorPrivacyChatImg, name: '获取私密聊天图片'),
    const ApiEndpoint(path: ApiRoutes.getAnchorAuthV2, name: '获取主播认证流程信息V2'),
    const ApiEndpoint(path: ApiRoutes.getAnchorLevelV2, name: '获取我的星级相关数据V2'),
    const ApiEndpoint(path: ApiRoutes.getMultiAnchor, name: '获取多账号主播'),
    const ApiEndpoint(path: ApiRoutes.getGuildLoginInfo, name: '获取绑定公会登录信息'),
    const ApiEndpoint(path: ApiRoutes.getAnchorExposure, name: '获取主播曝光度相关数据'),
    const ApiEndpoint(path: ApiRoutes.getFreeMatchAnchors, name: '随机获取免费匹配主播', queryParameters: {'size': 10}),
    const ApiEndpoint(path: ApiRoutes.getAnchorTrialProgress, name: '获取主播试播进度'),
    const ApiEndpoint(path: ApiRoutes.tryGetScreenMatchAnchor, name: '获取匹配主播（屏幕筛选）'),

    // ========== System ==========
    const ApiEndpoint(path: ApiRoutes.appConfig, name: '获取应用配置'),
    const ApiEndpoint(path: ApiRoutes.banners, name: '获取Banner列表'),
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
      final safeName = endpoint.name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
      final outputFile = 'api_debug_${safeName}_$timestamp.txt';
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
  print('    SleaAUV 全量无参数 API Debug');
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
