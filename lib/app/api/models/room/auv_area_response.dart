/// 地区模型
///
/// 表示地区信息
///
/// 字段说明:
/// - areaCode: 地区编码
/// - path: 图片链接
/// - title: 地区名
/// - anchorCount: 主播数
/// - portraits: 主播头像列表
class AuvAreaResponse {
  /// 地区编码
  final int? areaCode;

  /// 图片链接
  final String? path;

  /// 地区名
  final String? title;

  /// 主播数
  final int? anchorCount;

  /// 主播头像列表
  final List<String>? portraits;

  AuvAreaResponse({
    this.areaCode,
    this.path,
    this.title,
    this.anchorCount,
    this.portraits,
  });

  factory AuvAreaResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAreaResponse();
    return AuvAreaResponse(
      areaCode: json['areaCode'],
      path: json['path'],
      title: json['title'],
      anchorCount: json['anchorCount'],
      portraits: (json['portraits'] as List<dynamic>?)?.cast<String>(),
    );
  }
}