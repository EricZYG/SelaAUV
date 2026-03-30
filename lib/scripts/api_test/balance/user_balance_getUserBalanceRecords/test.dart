#!/usr/bin/env dart
/// 用户钻石明细 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '用户钻石明细';
const String API_PATH = '/user/balance/getUserBalanceRecords';
const String API_METHOD = 'POST';
const bool NEED_SIGN = false;

/// 查询条件
class BalanceCondition {
  final int? action; // 1.收入，2.支出
  final int? startTimes; // 开始时间毫秒时间戳
  final int? endTimes; // 结束时间毫秒时间戳
  final bool? isGame; // 是否查看游戏明细

  BalanceCondition({
    this.action,
    this.startTimes,
    this.endTimes,
    this.isGame,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (action != null) json['action'] = action;
    if (startTimes != null) json['startTimes'] = startTimes;
    if (endTimes != null) json['endTimes'] = endTimes;
    if (isGame != null) json['isGame'] = isGame;
    return json;
  }
}

/// 请求参数
class BalanceRequest {
  final BalanceCondition condition;
  final int pageNum;
  final int pageSize;

  BalanceRequest({
    required this.condition,
    required this.pageNum,
    required this.pageSize,
  });

  Map<String, dynamic> toJson() {
    return {
      'condition': condition.toJson(),
      'pageNum': pageNum,
      'pageSize': pageSize,
    };
  }
}

/// 获取用户钻石明细
Future<Map<String, dynamic>> getUserBalanceRecords(BalanceRequest request) async {
  final dio = createDioClient();
  final response = await dio.post(API_PATH, data: request.toJson());
  return response.data;
}

String formatAction(int? action) {
  switch (action) {
    case 1:
      return '收入';
    case 2:
      return '支出';
    default:
      return '未知';
  }
}

String formatRecordType(int? type) {
  final types = {
    301: '视频通话',
    302: '语音通话',
    303: '私信消息',
    304: '礼物',
    305: '游戏',
    306: '充值',
    307: '任务奖励',
    308: '签到奖励',
  };
  return types[type] ?? '其他($type)';
}

void main() async {
  // 示例：查询支出明细
  final now = DateTime.now().millisecondsSinceEpoch;
  final thirtyDaysAgo = now - (30 * 24 * 60 * 60 * 1000);

  final request = BalanceRequest(
    condition: BalanceCondition(
      action: 2, // 支出
      startTimes: thirtyDaysAgo,
      endTimes: now,
    ),
    pageNum: 1,
    pageSize: 10,
  );

  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('  签名: ${NEED_SIGN ? "是" : "否"}');
  print('========================================\n');

  print('查询条件:');
  print('  变动类型: ${request.condition.action == 1 ? "收入" : "支出"}');
  print('  开始时间: ${DateTime.fromMillisecondsSinceEpoch(request.condition.startTimes!)}');
  print('  结束时间: ${DateTime.fromMillisecondsSinceEpoch(request.condition.endTimes!)}');
  print('  页码: ${request.pageNum}');
  print('  每页数量: ${request.pageSize}\n');

  try {
    print('正在调用 $API_NAME...\n');

    final result = await getUserBalanceRecords(request);

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};
      final list = data['list'] as List? ?? [];

      print('\n--- 分页信息 ---');
      print('总记录数: ${data['total']}');
      print('总页数: ${data['pages']}');
      print('当前页: ${data['pageNum']}/${data['pages']}');
      print('当前页记录数: ${list.length}');

      if (list.isNotEmpty) {
        print('\n--- 明细记录 ---');
        for (var i = 0; i < list.length; i++) {
          final item = list[i];
          final time = DateTime.fromMillisecondsSinceEpoch(item['createTimes'] ?? 0);
          print('\n[${i + 1}] ${formatRecordType(item['recordType'])}');
          print('    用户ID: ${item['userId']}');
          print('    类型: ${formatAction(item['action'])}');
          print('    变动值: ${item['value']}');
          print('    时间: $time');
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
