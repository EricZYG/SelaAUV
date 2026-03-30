#!/usr/bin/env dart
/// 主播首页获取用户列表 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '主播首页获取用户列表';
const String API_PATH = '/user/user/getUsers';
const String API_METHOD = 'POST';
const bool NEED_SIGN = false;

/// 查询条件
class UsersCondition {
  final int? countryCode; // 国家编码

  UsersCondition({this.countryCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    if (countryCode != null) json['countryCode'] = countryCode;
    return json;
  }
}

/// 请求参数
class UsersRequest {
  final int pageNum;
  final int pageSize;
  final UsersCondition condition;

  UsersRequest({
    required this.pageNum,
    required this.pageSize,
    required this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      'condition': condition.toJson(),
    };
  }
}

/// 获取用户列表
Future<Map<String, dynamic>> getUsers(UsersRequest request) async {
  final dio = createDioClient();
  final response = await dio.post(API_PATH, data: request.toJson());
  return response.data;
}

String formatUserAuth(int? auth) {
  switch (auth) {
    case 0:
      return '男用户';
    case 1:
      return '待认证主播';
    case 2:
      return '已认证主播';
    case 3:
      return '认证失败主播';
    case 4:
      return '违规主播';
    default:
      return '未知';
  }
}

String formatOnlineStatus(int? status) {
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

String formatFollowStatus(int? flag) {
  switch (flag) {
    case 0:
      return '未知';
    case 1:
      return '未关注';
    case 2:
      return '已关注';
    case 3:
      return '好友';
    default:
      return '未知';
  }
}

String formatLikeStatus(int? flag) {
  switch (flag) {
    case 0:
      return '未知';
    case 1:
      return '未喜欢';
    case 2:
      return '已喜欢';
    default:
      return '未知';
  }
}

void main() async {
  final request = UsersRequest(
    pageNum: 1,
    pageSize: 10,
    condition: UsersCondition(countryCode: null), // 查询全部，可指定国家如 840
  );

  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('  签名: ${NEED_SIGN ? "是" : "否"}');
  print('========================================\n');

  print('查询条件:');
  if (request.condition.countryCode != null) {
    print('  国家编码: ${request.condition.countryCode}');
  } else {
    print('  国家编码: 全部');
  }
  print('  页码: ${request.pageNum}');
  print('  每页数量: ${request.pageSize}\n');

  try {
    print('正在调用 $API_NAME...\n');

    final result = await getUsers(request);

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};
      final list = data['list'] as List? ?? [];

      print('\n--- 分页信息 ---');
      print('总记录数: ${data['total']}');
      print('当前页: ${data['pageNum']}');
      print('每页数量: ${data['pageSize']}');
      print('有下一页: ${data['hasNextPage'] == true ? "是" : "否"}');

      if (list.isNotEmpty) {
        print('\n--- 用户列表 (共${list.length}条) ---');
        for (var i = 0; i < list.length; i++) {
          final user = list[i];
          print('\n[${i + 1}] ${user['nickname'] ?? '未知昵称'} (ID: ${user['userId']})');
          print('    用户名: ${user['username']}');
          print('    认证状态: ${formatUserAuth(user['userAuth'])}');
          print('    在线状态: ${formatOnlineStatus(user['isOnline'])}');
          print('    国家: ${user['countryTitle'] ?? '未知'} (${user['countrySubCode'] ?? ''})');
          print('    关注状态: ${formatFollowStatus(user['followFlag'])}');
          print('    喜欢状态: ${formatLikeStatus(user['likeFlag'])}');
          print('    剩余钻石: ${user['remainDiamonds']}');
          if (user['levelConfig'] != null) {
            print('    等级: ${user['levelConfig']['level']}');
          }
        }
      } else {
        print('\n--- 用户列表为空 ---');
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
