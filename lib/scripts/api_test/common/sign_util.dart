/// API测试脚本 - 签名工具
library;

import 'dart:convert';
import 'package:crypto/crypto.dart';

/// 签名工具类
class SignUtil {
  /// 生成签名
  ///
  /// [params] 请求参数Map
  /// [time] 时间戳字符串
  /// [key] 签名密钥（从应用配置接口获取的ok参数）
  static String generateSign(
    Map<String, dynamic> params,
    String time,
    String key,
  ) {
    final sortedKeys = params.keys
        .where((k) => params[k] != null && params[k].toString().isNotEmpty)
        .toList()
      ..sort();

    final stringA = sortedKeys.map((k) => '$k=${params[k]}').join('&');
    final stringSignTemp = '$stringA&time=$time&key=$key';
    final md5Hash = md5.convert(utf8.encode(stringSignTemp));

    return md5Hash.toString().toLowerCase();
  }

  /// 获取带签名的请求头
  static Map<String, String> getSignHeaders(
    Map<String, dynamic> params, [
    String? signKey,
  ]) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    String sign = '';

    if (signKey != null && signKey.isNotEmpty) {
      sign = generateSign(params, time, signKey);
    }

    return {
      's-time': time,
      's-sign': sign,
    };
  }
}

/// 需要签名的接口路径
class SignRequired {
  static const List<String> paths = [
    '/user/login/guest',
    '/user/login/phone',
    '/user/login/google',
    '/user/login/apple',
    '/user/sign/signIn',
    '/p/order/createOrder',
    '/user/gift/sendReal',
    '/user/gift/sendLucky',
  ];

  static bool isRequired(String path) => paths.contains(path);
}
