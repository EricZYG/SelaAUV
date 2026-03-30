#!/usr/bin/env dart
/// 兑换钻石 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '兑换钻石';
const String API_PATH = '/p/exchangeStore/exchangeDiamonds';
const String API_METHOD = 'POST';
const bool NEED_SIGN = false;

Future<Map<String, dynamic>> exchangeDiamonds({required int storeId}) async {
  final dio = createDioClient();
  final response = await dio.post(
    API_PATH,
    data: {'storeId': storeId},
  );
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

    final result = await exchangeDiamonds(storeId: 1);

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
