#!/usr/bin/env dart
/// 获取高级用户弹窗接口 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取高级用户弹窗接口';
const String API_PATH = '/user/advance/getDialogDetail';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

Future<Map<String, dynamic>> getDialogDetail() async {
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

    final result = await getDialogDetail();

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};

      print('\n--- 高级用户状态 ---');
      final isAdvanceUser = data['isAdvanceUser'] ?? 0;
      print('是否高级用户: ${isAdvanceUser == 1 ? "是" : "否"}');

      final isReward = data['isReward'] ?? 0;
      print('是否已领取奖励: ${isReward == 1 ? "是" : "否"}');

      print('\nWhatsApp ID: ${data['whatsappId'] ?? "无"}');

      final rewardVo = data['rewardVo'];
      if (rewardVo != null) {
        print('\n--- 奖励信息 ---');
        print('钻石数量: ${rewardVo['diamondNum'] ?? 0}');
        print('通话卡数量: ${rewardVo['callCardNum'] ?? 0}');
        print('匹配卡数量: ${rewardVo['matchCardNum'] ?? 0}');
        print('聊天卡数量: ${rewardVo['chatCardNum'] ?? 0}');
        print('优惠券数量: ${rewardVo['couponNum'] ?? 0}');
        print('金币数量: ${rewardVo['goldNum'] ?? 0}');
        print('美元数量: ${rewardVo['dollarNum'] ?? 0}');
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
