#!/usr/bin/env dart
/// 获取翻译文案 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取翻译文案';
const String API_PATH = '/system/app/getTranslates';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

/// 获取翻译文案
Future<Map<String, dynamic>> getTranslates() async {
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

    final result = await getTranslates();

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'];
      print('\n--- 翻译文案信息 ---');
      print('翻译URL: $data');
      print('时间戳: ${result['timestamp']}');

      // 解析语言代码
      if (data is String && data.isNotEmpty) {
        final match = RegExp(r'/([a-z]{2})\d+\.json$').firstMatch(data);
        if (match != null) {
          print('语言代码: ${match.group(1)}');
        }
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
