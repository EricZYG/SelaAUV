#!/usr/bin/env dart
/// 获取主播列表 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取主播列表';
const String API_PATH = '/anchor/list';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

Future<Map<String, dynamic>> getAnchorList({
  int? categoryId,
  int page = 1,
  int pageSize = 20,
}) async {
  final dio = createDioClient();
  final queryParams = <String, dynamic>{
    'page': page,
    'page_size': pageSize,
    if (categoryId != null) 'category_id': categoryId,
  };
  final response = await dio.get(API_PATH, queryParameters: queryParams);
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

    final result = await getAnchorList(page: 1, pageSize: 10);

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
