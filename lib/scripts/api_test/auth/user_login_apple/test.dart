#!/usr/bin/env dart
/// 苹果登录 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';
import 'package:slea_auv/scripts/api_test/common/sign_util.dart';

const String API_NAME = '苹果登录';
const String API_PATH = '/user/login/apple';
const String API_METHOD = 'POST';
const bool NEED_SIGN = true;

Future<Map<String, dynamic>> appleLogin({
  required String identityToken,
  String? authorizationCode,
  String? name,
  String? signKey,
}) async {
  final dio = createDioClient();

  final params = <String, dynamic>{
    'identity_token': identityToken,
    if (authorizationCode != null) 'authorization_code': authorizationCode,
    if (name != null) 'name': name,
  };

  if (NEED_SIGN && signKey != null) {
    final signHeaders = SignUtil.getSignHeaders(params, signKey);
    dio.options.headers.addAll(signHeaders);
  }

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

    final result = await appleLogin(
      identityToken: 'your_apple_identity_token', // TODO: 从Apple Sign-In获取
      authorizationCode: 'your_auth_code',
      name: 'Test User',
      signKey: 'your_sign_key',
    );

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
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
