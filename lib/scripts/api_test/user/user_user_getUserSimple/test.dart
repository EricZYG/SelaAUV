#!/usr/bin/env dart
/// 获取对方简要信息 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取对方简要信息';
const String API_PATH = '/user/user/getUserSimple';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

/// 获取对方简要信息
/// [userId] 用户ID
Future<Map<String, dynamic>> getUserSimple(int userId) async {
  final dio = createDioClient();
  final response = await dio.get(API_PATH, queryParameters: {'userId': userId});
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

String formatFollowStatus(int flag) {
  switch (flag) {
    case 0:
      return '双方都未关注';
    case 1:
      return '我未关注&对方已回关';
    case 2:
      return '我已关注&对方未回关';
    case 3:
      return '好友';
    default:
      return '未知';
  }
}

void main() async {
  // 示例：获取用户ID为 10160608 的简要信息
  const int targetUserId = 10160608;

  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('  签名: ${NEED_SIGN ? "是" : "否"}');
  print('========================================\n');

  print('目标用户ID: $targetUserId\n');

  try {
    print('正在调用 $API_NAME...\n');

    final result = await getUserSimple(targetUserId);

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};

      print('\n--- 基础信息 ---');
      print('用户ID: ${data['userId']}');
      print('用户名: ${data['username']}');
      print('昵称: ${data['nickname']}');
      print('头像: ${data['portrait']}');
      print('在线状态: ${formatOnlineStatus(data['isOnline'] ?? 0)}');

      if (data['levelConfig'] != null) {
        final level = data['levelConfig'];
        print('\n--- 等级信息 ---');
        print('等级: ${level['level']} - ${level['title']}');
        print('等级范围: ${level['begin']} ~ ${level['end']}');
      }

      print('\n--- 其他信息 ---');
      print('总充值额: ${data['totalRecharge']} (分)');
      print('高级用户: ${data['isAdvanceUser'] == 1 ? "是" : "否"}');
      print('发消息价格: ${data['sendMsgPrice']} 钻石');
      print('免费聊天: ${data['sendMsgFlag'] == true ? "是" : "否"}');
      print('关注状态: ${formatFollowStatus(data['followFlag'] ?? 0)}');
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
