#!/usr/bin/env dart
/// 获取单个礼物详情 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取单个礼物详情';
const String API_PATH = '/user/gift/getOne';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

/// 礼物ID (可通过命令行参数传入)
int giftId = 1001;

Future<Map<String, dynamic>> getOneGift(int gid) async {
  final dio = createDioClient();
  final response = await dio.get(
    API_PATH,
    queryParameters: {'gid': gid},
  );
  return response.data;
}

void main(List<String> args) async {
  // 支持通过命令行参数指定礼物ID
  if (args.isNotEmpty) {
    giftId = int.tryParse(args[0]) ?? 1001;
  }

  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('  签名: ${NEED_SIGN ? "是" : "否"}');
  print('  礼物ID: $giftId');
  print('========================================\n');

  try {
    print('正在调用 $API_NAME...\n');

    final result = await getOneGift(giftId);

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};

      print('\n--- 礼物详情 ---');
      print('礼物ID (gid): ${data['gid']}');
      print('名称: ${data['name']}');
      print('钻石价格: ${data['diamonds'] ?? 0}');
      print('金币价格: ${data['coins'] ?? 0}');
      print('国家代码: ${data['countryCode'] ?? '无'}');
      print('图标: ${data['icon'] ?? '无'}');
      print('特效: ${data['animEffectUrl'] ?? '无'}');
      print('MD5: ${data['md5'] ?? '无'}');
      print('在线状态: ${data['online'] == 1 ? "在线" : "离线"}');
      print('排序权重: ${data['rankBy'] ?? 0}');
      print('创建时间: ${data['createdAt'] ?? '无'}');
      print('更新时间: ${data['updatedAt'] ?? '无'}');
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
