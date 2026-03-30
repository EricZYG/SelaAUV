import 'dart:convert';
import 'package:crypto/crypto.dart';

/// 签名工具类
///
/// 签名规则：
/// 1. 将请求参数按照参数名ASCII码从小到大排序（字典序）
/// 2. 使用URL键值对格式拼接成字符串 stringA
/// 3. 在stringA最后拼接 time 和 key，得到 stringSignTemp
/// 4. 对stringSignTemp进行MD5运算，结果转小写得到sign值
class AuvSignUtil {
  /// 生成签名
  /// [params] 请求参数
  /// [time] 时间戳（请求头中的 s-time 值）
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

    // 第四步：MD5运算并转小写
    final md5Hash = md5.convert(utf8.encode(stringSignTemp));

    return md5Hash.toString().toLowerCase();
  }

  /// 验证签名
  static bool verifySign(Map<String, dynamic> params, String time, String key, String sign) {
    final generatedSign = generateSign(params, time, key);
    return generatedSign == sign.toLowerCase();
  }
}
