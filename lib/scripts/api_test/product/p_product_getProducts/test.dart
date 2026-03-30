#!/usr/bin/env dart
/// 获取商品列表 API测试
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '获取商品列表';
const String API_PATH = '/p/product/getProducts';
const String API_METHOD = 'GET';
const bool NEED_SIGN = false;

enum ProductType {
  rechargeCenter(1, '充值中心'),
  quickPopup(2, '快捷弹窗'),
  rechargeVip(3, '充值VIP');

  final int value;
  final String label;
  const ProductType(this.value, this.label);
}

/// 获取商品列表
Future<Map<String, dynamic>> getProducts(int type) async {
  final dio = createDioClient();
  final response = await dio.get(API_PATH, queryParameters: {'type': type});
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
    case 4:
      return '分次领取';
    default:
      return '无折扣';
  }
}

String formatUploadUsd(int? flag) {
  return flag == 1 ? '上报美元价格' : '上报当地货币';
}

void main() async {
  final productType = ProductType.rechargeCenter;

  print('========================================');
  print('  $API_NAME');
  print('  路径: $API_PATH');
  print('  方法: $API_METHOD');
  print('  签名: ${NEED_SIGN ? "是" : "否"}');
  print('========================================\n');

  print('商品类型: ${productType.label} (${productType.value})\n');

  try {
    print('正在调用 $API_NAME...\n');

    final result = await getProducts(productType.value);

    print('\n响应结果:');
    print(const JsonEncoder.withIndent('  ').convert(result));

    if (result['code'] == 0) {
      print('\n结果: 成功');
      final data = result['data'] as List? ?? [];

      print('\n--- 商品列表 (共${data.length}个商品) ---\n');

      for (var i = 0; i < data.length; i++) {
        final product = data[i];
        print('[$i] 商品ID: ${product['productId']}');
        print('    商品编码: ${product['productCode']}');
        print('    商品类型: ${formatProductType(product['productType'])}');
        print('    折扣类型: ${formatDiscountType(product['discountType'])}');
        print('    美元价格: \$${(product['price'] ?? 0) / 100}');
        print('    当地价格: ${product['currencyPrice']} ${product['currencyCode']}');
        print('    钻石数: ${product['diamonds']}');
        print('    赠送钻石: ${product['bonus']}');
        print('    VIP天数: ${product['vipDays']}');
        print('    视频卡: ${product['callCardNum']}');
        print('    匹配卡: ${product['matchCardNum']}');
        print('    聊天卡: ${product['chatCardNum']}');
        print('    排序: ${product['productOrder']}');

        // 支付渠道
        final ppp = product['ppp'] as List? ?? [];
        if (ppp.isNotEmpty) {
          print('    --- 支付渠道 (${ppp.length}个) ---');
          for (var j = 0; j < ppp.length; j++) {
            final channel = ppp[j];
            print('      [$j] ${channel['ccName']}');
            print('          渠道ID: ${channel['ppId']}');
            print('          价格: ${channel['currencyPrice']} ${channel['currencyCode']}');
            print('          上报方式: ${formatUploadUsd(channel['uploadUsd'])}');
          }
        }

        // 分次信息
        final splits = product['splits'] as List? ?? [];
        if (splits.isNotEmpty) {
          print('    --- 分次列表 (${splits.length}次) ---');
          for (var j = 0; j < splits.length; j++) {
            final split = splits[j];
            print('      第${split['splitDay']}天: ${split['diamonds']}钻石 + ${split['bonus']}赠送');
          }
        }

        print('');
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
