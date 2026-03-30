#!/usr/bin/env dart
/// 签到领奖励 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';
import 'package:slea_auv/scripts/api_test/common/sign_util.dart';

const String API_NAME = '签到领奖励';
const String API_PATH = '/user/sign/signIn';
const String API_METHOD = 'POST';
const bool NEED_SIGN = true;

Future<Map<String, dynamic>> signIn({
  required int signDay,
  String? dateStr,
  String? signKey,
}) async {
  final dio = createDioClient();

  final params = <String, dynamic>{
    'signDay': signDay,
    if (dateStr != null) 'dateStr': dateStr,
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

    final result = await signIn(
      signDay: 1,
      dateStr: '2024-01-01',
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
