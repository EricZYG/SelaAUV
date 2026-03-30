#!/usr/bin/env dart
/// 发布动态 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '发布动态';
const String API_PATH = '/user/anchorMoment/publish';
const String API_METHOD = 'POST';
const bool NEED_SIGN = false;

Future<Map<String, dynamic>> publishMoment({
  String? content,
  List<String>? medias,
  int? visibleType,
  bool? autoSend,
}) async {
  final dio = createDioClient();

  final params = <String, dynamic>{
    if (content != null) 'content': content,
    if (medias != null) 'medias': medias,
    if (visibleType != null) 'visibleType': visibleType,
    if (autoSend != null) 'autoSend': autoSend,
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

    final result = await publishMoment(
      content: '这是一条测试动态',
      visibleType: 0,
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
