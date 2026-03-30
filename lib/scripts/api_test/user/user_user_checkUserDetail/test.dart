#!/usr/bin/env dart
/// 检查用户数据完整性 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '检查用户数据完整性';
const String API_PATH = '/user/user/checkUserDetail';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

/// 检查用户是否缺少某些数据
Future<Map<String, dynamic>> checkUserDetail() async {
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

    final result = await checkUserDetail();

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};

      print('\n--- 用户数据检查 ---');
      print('用户ID: ${data['userId']}');
      print('个性签名: ${data['hasSignature'] == 1 ? "有" : "无"}');
      print('标签: ${data['hasTag'] == 1 ? "有" : "无"}');

      final missing = <String>[];
      if (data['hasSignature'] == 0) missing.add('个性签名');
      if (data['hasTag'] == 0) missing.add('标签');

      if (missing.isEmpty) {
        print('\n数据完整性: 完整');
      } else {
        print('\n缺少数据: ${missing.join("、")}');
      }
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
