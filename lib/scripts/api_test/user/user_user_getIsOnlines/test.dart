#!/usr/bin/env dart
/// 获取用户是否在线 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取用户是否在线';
const String API_PATH = '/user/user/getIsOnlines';
const String API_METHOD = 'POST';
const bool NEED_SIGN = false;

/// 获取用户是否在线
/// [userIds] 用户ID列表
Future<Map<String, dynamic>> getIsOnlines(List<int> userIds) async {
  final dio = createDioClient();
  final data = {'userIds': userIds};
  final response = await dio.post(API_PATH, data: data);
  return response.data;
}

String formatOnlineStatus(int status) {
  switch (status) {
    case 0:
      return '离线';
    case 1:
      return '在线';
    case 2:
      return '忙线';
    default:
      return '未知';
  }
}

String formatInScreenStatus(int status) {
  switch (status) {
    case 0:
      return '否';
    case 1:
      return '是';
    default:
      return '未知';
  }
}

void main() async {
  // 示例：查询用户ID列表的在线状态
  const List<int> targetUserIds = [10160608, 10000389];

  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('  签名: ${NEED_SIGN ? "是" : "否"}');
  print('========================================\n');

  print('目标用户ID列表: $targetUserIds\n');

  try {
    print('正在调用 $API_NAME...\n');

    final result = await getIsOnlines(targetUserIds);

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] as List? ?? [];

      if (data.isNotEmpty) {
        print('\n--- 用户在线状态 ---');
        for (final item in data) {
          final userId = item['userId'];
          final isOnline = item['isOnline'] ?? 0;
          final inScreen = item['inScreen'] ?? 0;
          print('  用户ID $userId:');
          print('    在线状态: ${formatOnlineStatus(isOnline)}');
          print('    是否在屏幕中: ${formatInScreenStatus(inScreen)}');
        }
      } else {
        print('  无在线状态数据');
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
