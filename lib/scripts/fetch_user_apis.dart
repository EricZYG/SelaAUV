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

  static const String getUserPropVo = '/user/prop/getUserPropVo';
  static const String getUserPropVoName = '获取用户背包道具列表';

  static const String getUserBalanceRecords = '/user/balance/getUserBalanceRecords';
  static const String getUserBalanceRecordsName = '获取用户钻石/金币明细';

  static const String updateFirebaseToken = '/user/user/updateFirebaseToken';
  static const String updateFirebaseTokenName = '更新Firebase推送Token';

  static const String updateAdFlag = '/user/user/updateAdFlag';
  static const String updateAdFlagName = '更新广告归因信息';

  static const String deleteUser = '/user/user/deleteUser';
  static const String deleteUserName = '注销账号';

  static const String getUserSimple = '/user/user/getUserSimple';
  static const String getUserSimpleName = '获取对方简要信息';

  static const String getUserExpand = '/user/user/getUserExpand';
  static const String getUserExpandName = '获取对方详情（需登录）';

  static const String getUserExpandNoLogin = '/user/user/getUserExpandNoLogin';
  static const String getUserExpandNoLoginName = '获取对方详情（无需登录）';

  static const String getUserExpandV2 = '/user/user/getUserExpandV2';
  static const String getUserExpandV2Name = '获取男用户详情V2';

  static const String getAnchorExpandV2 = '/user/user/getAnchorExpandV2';
  static const String getAnchorExpandV2Name = '获取主播详情V2';

  static const String getUsers = '/user/user/getUsers';
  static const String getUsersName = '获取主播首页用户列表';

  static const String feedbackSave = '/user/feedback/save';
  static const String feedbackSaveName = '举报/反馈';

  static const String changePassword = '/user/user/changePassword';
  static const String changePasswordName = '修改密码';

  static const String setPassword = '/user/user/setPassword';
  static const String setPasswordName = '设置密码';

  static const String getIsOnlines = '/user/user/getIsOnlines';
  static const String getIsOnlinesName = '批量获取用户是否在线';

  static const String getPortraits = '/user/user/getPortraits';
  static const String getPortraitsName = '随机获取头像';

  static const String logoffDeleteUserByPassword = '/user/logoff/deleteUserByPassword';
  static const String logoffDeleteUserByPasswordName = '根据账号密码注销账号';

  static const String updateAppRateScore = '/user/user/updateAppRateScore';
  static const String updateAppRateScoreName = '更新App评分';

  static const String isHasInviteRecord = '/user/user/IsHasInviteRecord';
  static const String isHasInviteRecordName = '检查是否有填写邀请码记录';

  static const String getInviteUserVoList = '/user/user/getInviteUserVoList';
  static const String getInviteUserVoListName = '获取邀请奖励记录列表';

  static const String getInviteInfo = '/user/user/getInviteInfo';
  static const String getInviteInfoName = '获取邀请信息';

  static const String bindInviteCode = '/user/user/bindInviteCode';
  static const String bindInviteCodeName = '绑定邀请码';

  static const String getInviteRecord = '/user/user/getInviteRecord';
  static const String getInviteRecordName = '获取邀请绑定记录';

  static const String checkUserDetail = '/user/user/checkUserDetail';
  static const String checkUserDetailName = '检查用户资料完整度';

  static const String getDialogDetail = '/user/advance/getDialogDetail';
  static const String getDialogDetailName = '获取高级用户弹窗详情';

  static const String publishMoment = '/user/userMoment/publish';
  static const String publishMomentName = '发布动态';

  static const String setUserAlias = '/user/userAlias/setAlias';
  static const String setUserAliasName = '给对方设置别名';

  static const String updateSexDetail = '/user/user/updateSexDetail';
  static const String updateSexDetailName = '更新性别引导页信息';

  static const String getRewards = '/user/user/getRewards';
  static const String getRewardsName = '获取随机15条奖励飘屏';

  static const String getDiamondRanking = '/user/user/getDiamondRanking';
  static const String getDiamondRankingName = '获取用户钻石排行';

  static const String getFKUsers = '/user/anchor/getFKUsers';
  static const String getFKUsersName = '获取合规用户/主播列表';

  static const String updateSexMale = '/user/user/updateSexMale';
  static const String updateSexMaleName = '女用户更新为男用户';

  // ========== /user/user 遗漏接口 ==========
  static const String getUserDetail = '/user/user/getUserDetail';
  static const String getUserDetailName = '获取我的页面信息';

  static const String signIn = '/user/sign/signIn';
  static const String signInName = '签到领奖励';

  static const String heartbeat = '/user/user/heartbeat';
  static const String heartbeatName = '心跳请求';

  static const String getUserUpdateDetail = '/user/user/getUserUpdateDetailVo';
  static const String getUserUpdateDetailName = '用户端编辑资料获取信息';

  static const String updateAlbumUrlList = '/user/user/updateAlbumUrlList';
  static const String updateAlbumUrlListName = '用户端编辑相册';

  static const String updateUserDetail = '/user/user/updateUserDetail';
  static const String updateUserDetailName = '修改个人信息';
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

/// 获取所有用户 API 端点列表
List<ApiEndpoint> getAllUserEndpoints() {
  return [
    // 用户信息相关
    const ApiEndpoint(path: ApiRoutes.userInfo, name: ApiRoutes.userInfoName),
    const ApiEndpoint(path: ApiRoutes.updateUserInfo, name: ApiRoutes.updateUserInfoName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.uploadAvatar, name: ApiRoutes.uploadAvatarName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.getUserPropVo, name: ApiRoutes.getUserPropVoName),
    const ApiEndpoint(path: ApiRoutes.getUserBalanceRecords, name: ApiRoutes.getUserBalanceRecordsName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.updateFirebaseToken, name: ApiRoutes.updateFirebaseTokenName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.updateAdFlag, name: ApiRoutes.updateAdFlagName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.deleteUser, name: ApiRoutes.deleteUserName, method: 'POST'),

    // 用户详情相关
    const ApiEndpoint(path: ApiRoutes.getUserSimple, name: ApiRoutes.getUserSimpleName, queryParameters: {'userId': 10207304}),
    const ApiEndpoint(path: ApiRoutes.getUserExpand, name: ApiRoutes.getUserExpandName, queryParameters: {'userId': 10207304}),
    const ApiEndpoint(path: ApiRoutes.getUserExpandNoLogin, name: ApiRoutes.getUserExpandNoLoginName, queryParameters: {'userId': 10207304}),
    const ApiEndpoint(path: ApiRoutes.getUserExpandV2, name: ApiRoutes.getUserExpandV2Name, queryParameters: {'userId': 10207304}),
    const ApiEndpoint(path: ApiRoutes.getAnchorExpandV2, name: ApiRoutes.getAnchorExpandV2Name, queryParameters: {'userId': 10207304}),
    const ApiEndpoint(path: ApiRoutes.getUsers, name: ApiRoutes.getUsersName, method: 'POST', data: {'pageNum': 1, 'pageSize': 10}),

    // 举报/反馈
    const ApiEndpoint(path: ApiRoutes.feedbackSave, name: ApiRoutes.feedbackSaveName, method: 'POST'),

    // 密码相关
    const ApiEndpoint(path: ApiRoutes.changePassword, name: ApiRoutes.changePasswordName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.setPassword, name: ApiRoutes.setPasswordName, method: 'POST'),

    // 用户状态相关
    const ApiEndpoint(path: ApiRoutes.getIsOnlines, name: ApiRoutes.getIsOnlinesName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.getPortraits, name: ApiRoutes.getPortraitsName, queryParameters: {'size': 10}),

    // 账号相关
    const ApiEndpoint(path: ApiRoutes.logoffDeleteUserByPassword, name: ApiRoutes.logoffDeleteUserByPasswordName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.updateAppRateScore, name: ApiRoutes.updateAppRateScoreName, method: 'POST'),

    // 邀请相关
    const ApiEndpoint(path: ApiRoutes.isHasInviteRecord, name: ApiRoutes.isHasInviteRecordName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.getInviteUserVoList, name: ApiRoutes.getInviteUserVoListName),
    const ApiEndpoint(path: ApiRoutes.getInviteInfo, name: ApiRoutes.getInviteInfoName),
    const ApiEndpoint(path: ApiRoutes.bindInviteCode, name: ApiRoutes.bindInviteCodeName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.getInviteRecord, name: ApiRoutes.getInviteRecordName, method: 'POST'),

    // 用户资料相关
    const ApiEndpoint(path: ApiRoutes.checkUserDetail, name: ApiRoutes.checkUserDetailName),
    const ApiEndpoint(path: ApiRoutes.getDialogDetail, name: ApiRoutes.getDialogDetailName),
    const ApiEndpoint(path: ApiRoutes.publishMoment, name: ApiRoutes.publishMomentName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.setUserAlias, name: ApiRoutes.setUserAliasName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.updateSexDetail, name: ApiRoutes.updateSexDetailName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.updateSexMale, name: ApiRoutes.updateSexMaleName, method: 'POST'),

    // 排行榜相关
    const ApiEndpoint(path: ApiRoutes.getRewards, name: ApiRoutes.getRewardsName),
    const ApiEndpoint(path: ApiRoutes.getDiamondRanking, name: ApiRoutes.getDiamondRankingName, queryParameters: {'timeLevel': 1}),
    const ApiEndpoint(path: ApiRoutes.getFKUsers, name: ApiRoutes.getFKUsersName, method: 'POST'),

    // /user/user 遗漏接口
    const ApiEndpoint(path: ApiRoutes.getUserDetail, name: ApiRoutes.getUserDetailName),
    const ApiEndpoint(path: ApiRoutes.signIn, name: ApiRoutes.signInName, method: 'POST', data: {'signDay': 1}),
    const ApiEndpoint(path: ApiRoutes.heartbeat, name: ApiRoutes.heartbeatName, method: 'POST', data: {'isScreenOff': false, 'rtmStatus': 1}),
    const ApiEndpoint(path: ApiRoutes.getUserUpdateDetail, name: ApiRoutes.getUserUpdateDetailName),
    const ApiEndpoint(path: ApiRoutes.updateAlbumUrlList, name: ApiRoutes.updateAlbumUrlListName, method: 'POST'),
    const ApiEndpoint(path: ApiRoutes.updateUserDetail, name: ApiRoutes.updateUserDetailName, method: 'POST'),
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
      final outputDir = Directory('api_logs');
      if (!await outputDir.exists()) {
        await outputDir.create(recursive: true);
      }
      // 文件名格式: 接口名_请求方法_时间戳.txt
      final safeName = endpoint.name.replaceAll(RegExp(r'[^\w\u4e00-\u9fa5]'), '_');
      final method = endpoint.method.toLowerCase();
      final outputFile = '${outputDir.path}/${safeName}_${endpoint.path.replaceAll('/', '_')}_$timestamp.txt';
      await saveToFile(outputFile, endpoint, client.lastRequest!, client.lastResponse!);
      return true;
    }

    // 即使失败也保存响应
    if (client.lastRequest != null && client.lastResponse != null) {
      final outputDir = Directory('api_logs');
      if (!await outputDir.exists()) {
        await outputDir.create(recursive: true);
      }
      final safeName = endpoint.name.replaceAll(RegExp(r'[^\w\u4e00-\u9fa5]'), '_');
      final outputFile = '${outputDir.path}/${safeName}_${endpoint.path.replaceAll('/', '_')}_fail_$timestamp.txt';
      await saveToFile(outputFile, endpoint, client.lastRequest!, client.lastResponse!);
    }
    return false;
  } catch (e) {
    return false;
  }
}

/// 保存数据到文件
Future<void> saveToFile(String filename, ApiEndpoint endpoint, RequestData request, ResponseData response) async {
  final content = '''
================================================================================
接口名称: ${endpoint.name}
接口路径: ${endpoint.path}
请求方法: ${endpoint.method}
================================================================================

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
================================================================================
''';

  final file = File(filename);
  await file.writeAsString(content);
}

void main() async {
  print('===========================================');
  print('    SleaAUV API Debug - 用户接口测试');
  print('===========================================\n');

  final client = HttpClient();
  final endpoints = getAllUserEndpoints();
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
