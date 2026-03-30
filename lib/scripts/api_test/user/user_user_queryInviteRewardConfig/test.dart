#!/usr/bin/env dart
/// 获取邀请奖励配置列表 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取邀请奖励配置列表';
const String API_PATH = '/user/user/queryInviteRewardConfig';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

/// 获取邀请奖励配置列表
Future<Map<String, dynamic>> queryInviteRewardConfig() async {
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

    final result = await queryInviteRewardConfig();

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final dataList = result['data'] as List? ?? [];
      print('奖励配置数量: ${dataList.length}');
      if (dataList.isNotEmpty) {
        print('\n--- 配置列表 ---');
        for (var i = 0; i < dataList.length; i++) {
          final item = dataList[i];
          print('\n[${i + 1}] ${item['countryName'] ?? '未知'}');
          print('    国家编码: ${item['countryCode']}');
          print('    国旗地址: ${item['countryPath']}');
          print('    女用户认证奖励: ${item['femaleAuthCoins']} 金币');
          print('    女用户收入达标奖励: ${item['femaleIncomeCoins']} 金币');
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
