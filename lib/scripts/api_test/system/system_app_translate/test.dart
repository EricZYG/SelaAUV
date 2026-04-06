#!/usr/bin/env dart
/// 翻译服务完整链路测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取翻译文案V2';
const String API_PATH = '/system/app/getTranslatesV2';
const String API_METHOD = 'GET';

Future<void> main() async {
  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('========================================\n');

  try {
    // Step 1: 获取翻译配置（版本号 + URL）
    print('Step 1: 调用 $API_NAME...\n');
    final dio = createDioClient();
    final configResponse = await dio.get(API_PATH);

    print('API响应:');
    print(const JsonEncoder.withIndent('  ').convert(configResponse.data));
    print('');

    if (configResponse.data['code'] != 0) {
      print('结果: 失败');
      print('错误码: ${configResponse.data['code']}');
      print('错误信息: ${configResponse.data['message']}');
      exit(1);
    }

    final data = configResponse.data['data'] ?? {};
    final version = data['version'];
    final url = data['url'] as String?;

    print('Step 1 结果: 成功');
    print('版本号 (version): $version');
    print('翻译文件地址 (url): $url');
    print('');

    if (url == null || url.isEmpty) {
      print('错误: URL为空');
      exit(1);
    }

    // Step 2: 下载翻译JSON文件
    print('Step 2: 下载翻译JSON文件...');
    print('下载地址: $url\n');

    final downloadDio = Dio(BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 30000,
      responseType: ResponseType.plain,
      validateStatus: (status) => true,
    ));

    print('开始下载翻译文件...\n');
    final translateResponse = await downloadDio.get<String>(url);
    print('HTTP状态码: ${translateResponse.statusCode}');
    print('响应数据类型: ${translateResponse.data.runtimeType}');
    print('响应内容前200字符: ${translateResponse.data?.toString().substring(0, translateResponse.data.toString().length.clamp(0, 200))}');

    if (translateResponse.statusCode != 200) {
      print('下载失败: HTTP ${translateResponse.statusCode}');
      exit(1);
    }

    print('下载成功!\n');
    print('Step 3: 解析翻译JSON...\n');

    final rawData = translateResponse.data;
    if (rawData == null || rawData.isEmpty) {
      print('错误: 翻译JSON内容为空');
      exit(1);
    }

    final translateData = jsonDecode(rawData as String);

    // 解析并打印
    final Map<String, String> translations = {};
    int parseCount = 0;

    void parseJson(dynamic data, [String prefix = '']) {
      if (data is List) {
        // 数组格式: [{configKey: "...", configValue: "..."}, ...]
        for (final item in data) {
          if (item is Map) {
            final key = item['configKey'] as String?;
            final value = item['configValue'] as String?;
            if (key != null && value != null) {
              translations[key] = value;
              parseCount++;
            }
          }
        }
      } else if (data is Map) {
        (data as Map).forEach((key, value) {
          final fullKey = prefix.isEmpty ? key : '$prefix.$key';
          if (value is String) {
            translations[fullKey] = value;
            translations[key] = value;
            parseCount++;
          } else if (value is Map) {
            parseJson(value, fullKey);
          }
        });
      }
    }

    parseJson(translateData as dynamic);

    print('解析完成! 共 ${translations.length} 条翻译记录\n');
    print('========================================');
    print('  翻译内容预览 (前20条)');
    print('========================================\n');

    int shown = 0;
    for (final entry in translations.entries) {
      if (shown >= 20) break;
      print('  "${entry.key}" => "${entry.value}"');
      shown++;
    }

    if (translations.length > 20) {
      print('  ... (还有 ${translations.length - 20} 条)');
    }

    print('\n========================================');
    print('  测试翻译查询');
    print('========================================\n');

    // 测试几个常见的key
    final testKeys = ['hello', 'welcome', 'login', 'home', 'settings', 'profile', 'message', 'call'];
    for (final key in testKeys) {
      if (translations.containsKey(key)) {
        print('  "$key" => "${translations[key]}"');
      }
    }

    print('\n翻译服务链路测试完成!');
  } catch (e) {
    print('\n请求异常: $e');
  }

  exit(0);
}
