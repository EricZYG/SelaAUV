#!/usr/bin/env dart
/// 获取通话记录 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取通话记录';
const String API_PATH = '/call/call/getCallRecordVoList';
const String API_METHOD = 'POST';
const bool NEED_SIGN = false;

Future<Map<String, dynamic>> getCallRecordVoList({
  int? callType,
  int? callFlag,
  List<int>? callTypes,
  required int pageNum,
  required int pageSize,
}) async {
  final dio = createDioClient();
  final data = {
    if (callType != null || callFlag != null || callTypes != null)
      'condition': {
        if (callType != null) 'callType': callType,
        if (callFlag != null) 'callFlag': callFlag,
        if (callTypes != null) 'callTypes': callTypes,
      },
    'pageNum': pageNum,
    'pageSize': pageSize,
  };
  final response = await dio.post(API_PATH, data: data);
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

    final result = await getCallRecordVoList(
      pageNum: 1,
      pageSize: 10,
      callTypes: [0, 1, 3, 4],
    );

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'];
      if (data != null) {
        final total = data['total'] ?? 0;
        final list = data['list'] as List? ?? [];
        print('\n通话记录 (共${total}条, 当前页${list.length}条):');
        for (final item in list) {
          final callType = item['callType'] ?? 0;
          String callTypeDesc = '未知';
          switch (callType) {
            case 0:
              callTypeDesc = '正常拨打';
              break;
            case 1:
              callTypeDesc = 'AIB';
              break;
            case 2:
              callTypeDesc = '匹配';
              break;
            case 3:
              callTypeDesc = '主播邀请';
              break;
            case 4:
              callTypeDesc = '主播免费邀请';
              break;
            case 5:
              callTypeDesc = '免费匹配';
              break;
          }
          print('  - ${item['peerNickname'] ?? '未知'} (type: $callTypeDesc, status: ${item['channelStatus']})');
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
