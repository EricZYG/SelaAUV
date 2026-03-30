import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart' as crypto_lib;

/// MD5 签名工具（复制自 sign_util.dart 的核心逻辑）
class SignUtil {
  /// 生成签名
  /// [params] 请求参数
  /// [time] 时间戳
  /// [key] 密钥（应用配置接口返回的 ok 参数）
  static String generateSign(Map<String, dynamic> params, String time, String key) {
    // 第一步：过滤空值，并按参数名ASCII码从小到大排序（字典序）
    final sortedKeys = params.keys
        .where((k) => params[k] != null && params[k].toString().isNotEmpty)
        .toList()
      ..sort();

    // 第二步：拼接成URL键值对格式
    final stringA = sortedKeys.map((k) => '$k=${params[k]}').join('&');

    // 第三步：在最后拼接 time 和 key
    final stringSignTemp = '$stringA&time=$time&key=$key';

    print('\n  ┌─ 签名计算步骤 ─────────────────────────────────');
    print('  │');
    print('  ├─ Step 1: 过滤空值后的参数名排序');
    print('  │   原始参数: $params');
    print('  │   排序后:   $sortedKeys');
    print('  │');
    print('  ├─ Step 2: 拼接成 URL 键值对 (stringA)');
    print("  │   stringA = \"$stringA\"");
    print('  │');
    print('  ├─ Step 3: 追加 time 和 key (stringSignTemp)');
    print("  │   stringSignTemp = \"$stringSignTemp\"");
    print('  │');
    print('  ├─ Step 4: MD5 运算');
    print('  │   md5(stringSignTemp)');

    // MD5 计算
    final md5Hash = crypto_lib.md5.convert(utf8.encode(stringSignTemp));
    print('  │   原始结果 = $md5Hash');
    print('  │');
    print('  ├─ Step 5: 转小写');
    print('  │   最终签名 = ${md5Hash.toString().toLowerCase()}');
    print('  │');
    print('  └─────────────────────────────────────────────');

    // 第六步：MD5运算并转小写
    return md5Hash.toString().toLowerCase();
  }
}

/// 模拟获取应用配置的请求
void main() async {
  print('=' * 65);
  print('📡 模拟获取应用配置接口请求（完整签名流程）');
  print('=' * 65);

  // ========================================
  // 场景1: GET 请求（无参数）
  // ========================================
  print('\n\n');
  print('🔷 场景1: GET 请求（无参数）');
  print('─' * 65);

  const baseUrl = 'https://testapi.selalive.com';
  const path = '/system/app/getConfig';
  const fullUrl = '$baseUrl$path';

  print('\n📌 请求信息:');
  print('-' * 40);
  print('URL: $fullUrl');
  print('Method: GET');
  print('Content-Type: application/json');

  // 生成时间戳
  final time = DateTime.now().millisecondsSinceEpoch.toString();
  final signKey = 'mock_sign_key_12345'; // 模拟从配置接口获取的 key

  // GET 请求无参数
  final queryParams = <String, dynamic>{};

  print('\n📋 请求 Headers:');
  print('-' * 40);
  print('  Content-Type: application/json');
  print('  Accept: application/json');
  print('  Authorization: Bearer mock_token_xxxxx');
  print('  s-time: $time');

  // 生成签名
  final sign = SignUtil.generateSign(queryParams, time, signKey);
  print('  s-sign: $sign');

  print('\n📦 完整请求报文:');
  print('-' * 40);
  final requestPacket = {
    'url': fullUrl,
    'method': 'GET',
    'headers': {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer mock_token_xxxxx',
      's-time': time,
      's-sign': sign,
    },
    'queryParams': queryParams,
  };
  print(jsonEncode(requestPacket));

  // ========================================
  // 场景2: POST 请求（有参数）
  // ========================================
  print('\n\n');
  print('🔷 场景2: POST 请求（有参数）');
  print('─' * 65);

  const postPath = '/user/login';
  const postUrl = '$baseUrl$postPath';

  print('\n📌 请求信息:');
  print('-' * 40);
  print('URL: $postUrl');
  print('Method: POST');
  print('Content-Type: application/json');

  // POST 请求参数
  final postData = {
    'username': 'testuser',
    'password': '123456',
    'deviceId': 'device_abc123',
  };

  // 生成新的时间戳和签名
  final postTime = DateTime.now().millisecondsSinceEpoch.toString();

  print('\n📋 请求 Headers:');
  print('-' * 40);
  print('  Content-Type: application/json');
  print('  Accept: application/json');
  print('  Authorization: Bearer mock_token_xxxxx');
  print('  s-time: $postTime');

  // 生成签名（使用 POST body 参数）
  final postSign = SignUtil.generateSign(postData, postTime, signKey);
  print('  s-sign: $postSign');

  print('\n📦 Body 参数:');
  print('-' * 40);
  print(jsonEncode(postData));

  print('\n📦 完整请求报文:');
  print('-' * 40);
  final postPacket = {
    'url': postUrl,
    'method': 'POST',
    'headers': {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer mock_token_xxxxx',
      's-time': postTime,
      's-sign': postSign,
    },
    'body': postData,
  };
  print(jsonEncode(postPacket));

  // ========================================
  // 场景3: POST 请求（混合参数 - query + body）
  // ========================================
  print('\n\n');
  print('🔷 场景3: POST 请求（混合参数: query + body）');
  print('─' * 65);

  const mixedPath = '/order/create';
  const mixedUrl = '$baseUrl$mixedPath';

  print('\n📌 请求信息:');
  print('-' * 40);
  print('URL: $mixedUrl');
  print('Method: POST');
  print('Content-Type: application/json');

  // Query 参数
  final mixedQueryParams = <String, dynamic>{
    'version': '1.0.0',
  };

  // Body 参数
  final mixedBodyParams = <String, dynamic>{
    'productId': 'prod_001',
    'quantity': 2,
    'couponCode': '',  // 空值，应该被过滤
  };

  // 合并参数用于签名（按规则）
  final mergedParams = <String, dynamic>{}..addAll(mixedQueryParams)..addAll(mixedBodyParams);

  final mixedTime = DateTime.now().millisecondsSinceEpoch.toString();

  print('\n📋 请求 Headers:');
  print('-' * 40);
  print('  Content-Type: application/json');
  print('  Accept: application/json');
  print('  Authorization: Bearer mock_token_xxxxx');
  print('  s-time: $mixedTime');

  // 生成签名（使用合并的参数）
  final mixedSign = SignUtil.generateSign(mergedParams, mixedTime, signKey);
  print('  s-sign: $mixedSign');

  print('\n📦 Query 参数:');
  print('-' * 40);
  print(jsonEncode(mixedQueryParams));

  print('\n📦 Body 参数:');
  print('-' * 40);
  print(jsonEncode(mixedBodyParams));

  print('\n📦 完整请求报文:');
  print('-' * 40);
  final mixedPacket = {
    'url': '$mixedUrl?${mixedQueryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}',
    'method': 'POST',
    'headers': {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer mock_token_xxxxx',
      's-time': mixedTime,
      's-sign': mixedSign,
    },
    'queryParams': mixedQueryParams,
    'body': mixedBodyParams,
  };
  print(jsonEncode(mixedPacket));

  // ========================================
  // 签名规则总结
  // ========================================
  print('\n\n');
  print('=' * 65);
  print('📋 签名规则总结');
  print('=' * 65);
  print('''
┌─────────────────────────────────────────────────────────────────┐
│                      签名规则说明                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  第一步: 将请求参数按照参数名 ASCII 码从小到大排序（字典序）      │
│                                                                 │
│  第二步: 使用 URL 键值对格式拼接成字符串                         │
│         key1=value1&key2=value2... → stringA                   │
│                                                                 │
│  第三步: 在 stringA 最后拼接 time 和 key                        │
│         stringSignTemp = stringA + "&time=" + 时间戳 + "&key=" + 密钥  │
│                                                                 │
│  第四步: 对 stringSignTemp 进行 MD5 运算                         │
│                                                                 │
│  第五步: 将结果所有字符转换为小写 → sign                          │
│                                                                 │
│  重要规则:                                                      │
│    ◆ 参数名 ASCII 码从小到大排序（字典序）                       │
│    ◆ 如果参数的值为空不参与签名                                  │
│    ◆ 参数名区分大小写                                           │
│    ◆ time 为请求头中的 s-time 值                                │
│    ◆ key 为应用配置接口返回的 ok 参数                            │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
''');

  print('✅ 模拟完成！');
}
