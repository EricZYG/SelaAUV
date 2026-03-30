#!/usr/bin/env dart
/// 按国家获取单个商品 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '按国家获取单个商品';
const String API_PATH = '/p/product/getCountryProduct';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

/// 按国家获取单个商品
Future<Map<String, dynamic>> getCountryProduct(int productId, int countryCode) async {
  final dio = createDioClient();
  final response = await dio.get(
    API_PATH,
    queryParameters: {
      'productId': productId,
      'countryCode': countryCode,
    },
  );
  return response.data;
}

String formatProductType(int? type) {
  switch (type) {
    case 1:
      return '普通商品';
    case 2:
      return '折扣商品';
    case 3:
      return 'VIP商品';
    default:
      return '未知';
  }
}

String formatDiscountType(int? type) {
  switch (type) {
    case 1:
      return '首充折扣';
    case 2:
      return '单次折扣';
    case 3:
      return '限时折扣';
    default:
      return '无折扣';
  }
}

void main() async {
  const productId = 3;
  const countryCode = 840;

  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('  签名: ${NEED_SIGN ? "是" : "否"}');
  print('========================================\n');

  print('查询条件:');
  print('  商品ID: $productId');
  print('  国家编码: $countryCode\n');

  try {
    print('正在调用 $API_NAME...\n');

    final result = await getCountryProduct(productId, countryCode);

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] ?? {};

      print('\n--- 商品信息 ---');
      print('商品ID: ${data['productId']}');
      print('商品编码: ${data['productCode']}');
      print('商品类型: ${formatProductType(data['productType'])}');
      print('折扣类型: ${formatDiscountType(data['discountType'])}');
      print('美元价格: \$${(data['price'] ?? 0) / 100}');
      print('当地价格: ${data['currencyPrice']} ${data['currencyCode']}');
      print('钻石数: ${data['diamonds']}');
      print('赠送钻石: ${data['bonus']}');
      print('VIP天数: ${data['vipDays']}');
      print('视频卡: ${data['callCardNum']}');
      print('匹配卡: ${data['matchCardNum']}');
      print('聊天卡: ${data['chatCardNum']}');
      print('排序: ${data['productOrder']}');

      // 支付渠道
      final ppp = data['ppp'] as List? ?? [];
      if (ppp.isNotEmpty) {
        print('\n--- 支付渠道 (${ppp.length}个) ---');
        for (var i = 0; i < ppp.length; i++) {
          final channel = ppp[i];
          print('[$i] ${channel['ccName']}');
          print('    渠道ID: ${channel['ppId']}');
          print('    支付类型: ${channel['ppType']}');
          print('    价格: ${channel['currencyPrice']} ${channel['currencyCode']}');
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
