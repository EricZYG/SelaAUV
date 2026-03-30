#!/usr/bin/env dart
/// 获取等级区间详情 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取等级区间详情';
const String API_PATH = '/user/level/getLevelInfoConfigs';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

Future<Map<String, dynamic>> getLevelInfoConfigs() async {
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

    final result = await getLevelInfoConfigs();

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};

      print('\n--- 当前总经验值 ---');
      print('总经验值: ${data['total'] ?? 0}');

      final configs = data['configs'] as List? ?? [];
      if (configs.isNotEmpty) {
        print('\n--- 等级配置列表 (共${configs.length}个等级) ---');
        for (final config in configs) {
          print('\n等级 ${config['level']} - ${config['title']}:');
          print('  等级值: ${config['level']}');
          print('  经验范围: ${config['begin']} ~ ${config['end']}');
          print('  头像框: ${config['avatarFrame'] ?? '无'}');
          print('  图标: ${config['icon'] ?? '无'}');
          print('  用户图标: ${config['userIcon'] ?? '无'}');
        }
      } else {
        print('\n  无等级配置数据');
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
