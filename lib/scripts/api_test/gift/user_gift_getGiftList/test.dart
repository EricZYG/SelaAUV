#!/usr/bin/env dart
/// 获取普通礼物列表 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取普通礼物列表';
const String API_PATH = '/user/gift/getGiftList';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

Future<Map<String, dynamic>> getGiftList() async {
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

    final result = await getGiftList();

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};

      print('\n--- 分页信息 ---');
      print('总数: ${data['total'] ?? 0}');
      print('当前页: ${data['pageNum'] ?? 1}');
      print('每页数量: ${data['pageSize'] ?? 10}');
      print('总页数: ${data['pages'] ?? 1}');

      final list = data['list'] as List? ?? [];
      if (list.isNotEmpty) {
        print('\n--- 礼物列表 (共${list.length}个) ---');
        for (final gift in list) {
          print('\n礼物 ${gift['gid']} - ${gift['name']}:');
          print('  礼物ID: ${gift['gid']}');
          print('  名称: ${gift['name']}');
          print('  钻石价格: ${gift['diamonds'] ?? 0}');
          print('  金币价格: ${gift['coins'] ?? 0}');
          print('  礼物类型: ${gift['giftType'] == 1 ? "普通礼物" : gift['giftType'] == 2 ? "VIP礼物" : "未知"}');
          print('  图标: ${gift['icon'] ?? '无'}');
          print('  特效: ${gift['animEffectUrl'] ?? '无'}');
        }
      } else {
        print('\n  无礼物数据');
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
