#!/usr/bin/env dart
/// 获取礼物动作列表 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取礼物动作列表';
const String API_PATH = '/user/gift/getActions';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

/// 动作类型 (可通过命令行参数传入)
/// 1: 1v1动作, 2: 直播间动作, 不传: 默认为1
int actionType = 1;

/// 动作类型映射
const Map<int, String> ACTION_TYPE_MAP = {
  1: '1v1动作',
  2: '直播间动作',
};

Future<Map<String, dynamic>> getActions({int? type}) async {
  final dio = createDioClient();
  final response = await dio.get(
    API_PATH,
    queryParameters: type != null ? {'type': type} : null,
  );
  return response.data;
}

void main(List<String> args) async {
  // 支持通过命令行参数指定动作类型
  if (args.isNotEmpty) {
    actionType = int.tryParse(args[0]) ?? 1;
  }

  final typeStr = ACTION_TYPE_MAP[actionType] ?? '默认(1v1动作)';

  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('  签名: ${NEED_SIGN ? "是" : "否"}');
  print('  动作类型: $typeStr (type=$actionType)');
  print('========================================\n');

  try {
    print('正在调用 $API_NAME...\n');

    final result = await getActions(type: actionType);

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] as List? ?? [];

      if (data.isNotEmpty) {
        print('\n--- 动作列表 (共${data.length}个) ---');
        for (final action in data) {
          print('  ${action['actionId']}: ${action['actionName']}');
        }
      } else {
        print('\n  无动作数据');
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
