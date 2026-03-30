#!/usr/bin/env dart
/// 获取多账号用户 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取多账号用户';
const String API_PATH = '/user/user/getMultiUser';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

/// 获取多账号用户
/// 存在多个账号时返回余额最多和最新登录的一个账号，与游客登录逻辑一致
Future<Map<String, dynamic>> getMultiUser() async {
  final dio = createDioClient();
  final response = await dio.get(API_PATH);
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

    final result = await getMultiUser();

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};
      print('用户ID: ${data['userId']}');
      print('用户名: ${data['username']}');
      print('昵称: ${data['nickname']}');
      print('头像: ${data['portrait']}');
      print('性别: ${data['sex'] == 1 ? "男" : "女"}');
      print('登录方式: ${data['oauthTypes']}');
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
