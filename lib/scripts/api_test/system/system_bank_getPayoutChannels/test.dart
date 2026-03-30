#!/usr/bin/env dart
/// 按国家获取银行渠道列表 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '按国家获取银行渠道列表';
const String API_PATH = '/system/bank/getPayoutChannels';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

Future<Map<String, dynamic>> getPayoutChannels({required int countryCode}) async {
  final dio = createDioClient();
  final response = await dio.get(API_PATH, queryParameters: {'countryCode': countryCode});
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

    // 示例：countryCode=123
    final result = await getPayoutChannels(countryCode: 840);

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
