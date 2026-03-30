#!/usr/bin/env dart
/// 发送消息 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '发送消息';
const String API_PATH = '/user/msg/sendMsg';
const String API_METHOD = 'POST';
const bool NEED_SIGN = false;

Future<Map<String, dynamic>> sendMsg({
  required int recipientId,
  required int type,
  required String urlOrContent,
  String? jsonData,
}) async {
  final dio = createDioClient();

  final params = <String, dynamic>{
    'recipientId': recipientId,
    'type': type,
    'urlOrContent': urlOrContent,
    if (jsonData != null) 'jsonData': jsonData,
  };

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

    final result = await sendMsg(
      recipientId: 12345,
      type: 11, // 11.文字
      urlOrContent: '你好，这是一条测试消息',
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
