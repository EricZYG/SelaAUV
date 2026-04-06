/// 获取翻译文案V2 - 响应模型
///
/// GET /system/app/getTranslatesV2
///
/// 可登录可不登录，返回翻译文案版本号和JSON文件URL
///
/// 字段说明:
/// - version: 翻译文案版本号（时间戳）
/// - url: 翻译JSON文件下载地址
class AuvTranslatesV2Response {
  /// 翻译文案版本号（时间戳）
  final int? version;

  /// 翻译JSON文件下载地址
  final String? url;

  AuvTranslatesV2Response({
    this.version,
    this.url,
  });

  factory AuvTranslatesV2Response.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvTranslatesV2Response();
    return AuvTranslatesV2Response(
      version: json['version'],
      url: json['url'],
    );
  }
}