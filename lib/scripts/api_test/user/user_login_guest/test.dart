#!/usr/bin/env dart
/// 游客登录 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '游客登录';
const String API_PATH = '/user/login/guest';
const String API_METHOD = 'POST';
const bool NEED_SIGN = false;

/// 生成随机设备ID
String generateDeviceId() {
  const chars = '0123456789abcdef';
  final random = Random.secure();
  final randomPart = List.generate(12, (_) => chars[random.nextInt(chars.length)]).join();
  return '$randomPart-Xiaomi';
}

/// 创建游客登录专用的Dio客户端 (不使用debugAuth)
Dio createGuestLoginDioClient() {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: ApiConfig.connectTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    validateStatus: (status) => true,
  ));

  // 游客登录不需要authorization，使用新生成的device-id
  dio.options.headers.addAll({
    'Accept': '*/*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Connection': 'keep-alive',
    'content-type': ApiConfig.contentType,
    'device-id': generateDeviceId(),
    'user-agent': DebugConfig.userAgent,
    'user-language': 'zh',
  });

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));

  return dio;
}

/// 密码 (必填, 加密后的密码)
const String PASSWORD = '123456';

/// 请求参数
class GuestLoginParams {
  /// 加密后的密码 (必填)
  final String password;

  /// 是否限制广告id获取: 0.未限制, 1.限制获取 (可选)
  final int? aidLimit;

  /// 广告id (可选)
  final String? aid;

  /// 是否使用了vpn: 0.未使用, 1.使用了 (可选)
  final int? useVpn;

  GuestLoginParams({
    required this.password,
    this.aidLimit,
    this.aid,
    this.useVpn,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'password': password,
    };
    if (aidLimit != null) map['aidLimit'] = aidLimit;
    if (aid != null) map['aid'] = aid;
    if (useVpn != null) map['useVpn'] = useVpn;
    return map;
  }
}

Future<Map<String, dynamic>> guestLogin(GuestLoginParams params) async {
  final dio = createGuestLoginDioClient();
  final deviceId = dio.options.headers['device-id'];
  print('请求头: device-id: $deviceId (新生成)');
  final response = await dio.post(
    API_PATH,
    data: params.toJson(),
  );
  return response.data;
}

void main(List<String> args) async {
  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('  签名: ${NEED_SIGN ? "是" : "否"}');
  print('========================================\n');

  // 解析命令行参数
  int? aidLimit;
  String? aid;
  int? useVpn;

  if (args.isNotEmpty) aidLimit = int.tryParse(args[0]);
  if (args.length > 1) aid = args[1];
  if (args.length > 2) useVpn = int.tryParse(args[2]);

  final params = GuestLoginParams(
    password: PASSWORD,
    aidLimit: aidLimit,
    aid: aid,
    useVpn: useVpn,
  );

  print('请求参数:');
  print('  password: ${params.password}');
  if (params.aidLimit != null) print('  aidLimit: ${params.aidLimit}');
  if (params.aid != null) print('  aid: ${params.aid}');
  if (params.useVpn != null) print('  useVpn: ${params.useVpn}');
  print('');

  try {
    print('正在调用 $API_NAME...\n');

    final result = await guestLogin(params);

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};

      print('\n--- 用户信息 ---');
      print('用户ID: ${data['userId']}');
      print('用户名: ${data['username']}');
      print('App渠道: ${data['appChannel'] ?? '无'}');
      print('是否待注销: ${data['deregisterFlag'] == 1 ? "是" : "否"}');
      if (data['deregisterFlag'] == 1 && data['deregisterTime'] != null) {
        final deregisterTime = DateTime.fromMillisecondsSinceEpoch(data['deregisterTime']);
        print('注销时间: $deregisterTime');
      }
      print('Authorization: ${data['authorization']?.toString().substring(0, 50)}...');
    } else {
      print('\n结果: 失败');
      print('错误码: ${result['code']}');
      print('错误信息: ${result['message']}');
    }
  } catch (e) {
    print('\n请求异常: $e');
  }

  exit(0);
}
