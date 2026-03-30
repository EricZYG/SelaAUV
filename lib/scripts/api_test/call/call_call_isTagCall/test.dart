#!/usr/bin/env dart
/// 通话结束是否可打标签 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '通话结束是否可打标签';
const String API_PATH = '/call/call/isTagCall';
const String API_METHOD = 'POST';
const bool NEED_SIGN = false;

Future<Map<String, dynamic>> isTagCall({
  required int channelId,
}) async {
  final dio = createDioClient();
  final response = await dio.post(API_PATH, data: {
    'channelId': channelId,
  });
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

    final result = await isTagCall(channelId: 0);

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'];
      if (data != null) {
        final isTagCall = data['isTagCall'] ?? false;
        print('\n是否可打标签: ${isTagCall ? "是" : "否"}');
        final tags = data['tags'] as List? ?? [];
        if (tags.isNotEmpty) {
          print('\n标签列表 (共${tags.length}个):');
          for (final tag in tags) {
            print('  - ${tag['tagValue']} (${tag['title']})');
          }
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
