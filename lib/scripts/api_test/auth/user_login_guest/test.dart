#!/usr/bin/env dart
/// 游客登录 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';
import 'package:slea_auv/scripts/api_test/common/sign_util.dart';

/// 接口配置
const String API_NAME = '游客登录';
const String API_PATH = '/user/login/guest';
const String API_METHOD = 'POST';
const bool NEED_SIGN = true;

/// 生成随机设备ID
String generateDeviceId() {
  const chars = '01234jhkklabcdef';
  final random = Random.secure();
  final randomPart = List.generate(12, (_) => chars[random.nextInt(chars.length)]).join();
  return '$randomPart-Xiaomi';
}

/// 创建游客登录专用的Dio客户端 (不使用authorization)
Dio createGuestLoginDioClient() {
  final dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: ApiConfig.connectTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    validateStatus: (status) => true,
  ));

  dio.options.headers.addAll({
    'Accept': '*/*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Connection': 'keep-alive',
    'content-type': ApiConfig.contentType,
    'device-id': "d89799810d98c48f-Xiaomi",
    'user-agent': DebugConfig.userAgent,
    'user-language': 'zh',
  });

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
  ));

  return dio;
}

/// 发送游客登录请求
Future<Map<String, dynamic>> guestLogin({
  required String password,
  int? aidLimit,
  String? aid,
  int? useVpn,
  String? signKey,
}) async {
  final dio = createGuestLoginDioClient();

  final params = <String, dynamic>{
    'password': password,
    if (aidLimit != null) 'aidLimit': aidLimit,
    if (aid != null) 'aid': aid,
    if (useVpn != null) 'useVpn': useVpn,
  };

  if (NEED_SIGN && signKey != null) {
    final signHeaders = SignUtil.getSignHeaders(params, signKey);
    dio.options.headers.addAll(signHeaders);
  }

  print('请求头: device-id: ${dio.options.headers['device-id']} (新生成)');
  print('请求头: authorization: ${dio.options.headers['authorization'] ?? "无"}');

  final response = await dio.post(API_PATH, data: params);
  return response.data;
}

void main() async {
  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('  签名: ${NEED_SIGN ? "是" : "否"}');
  print('========================================\n');

  try {
    print('正在调用 $API_NAME...\n');

    final result = await guestLogin(
      password: 'your_encrypted_password', // TODO: 替换为实际加密后的密码
      aidLimit: 0,
      aid: 'test_ad',
      useVpn: 0,
      signKey: 'your_sign_key', // TODO: 从getAppConfig接口获取
    );

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      print('用户ID: ${result['data']?['userId']}');
      print('Token: ${result['data']?['authorization']}');
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
