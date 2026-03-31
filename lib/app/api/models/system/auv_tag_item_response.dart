/// 标签项模型
///
/// 表示单个标签信息
///
/// 字段说明:
/// - classifyId: 分类id
/// - title: 分类名
/// - tagValue: 标签
class AuvTagItemResponse {
  /// 分类id
  final int? classifyId;

  /// 分类名
  final String? title;

  /// 标签
  final String? tagValue;

  AuvTagItemResponse({
    this.classifyId,
    this.title,
    this.tagValue,
  });

  factory AuvTagItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvTagItemResponse();
    return AuvTagItemResponse(
      classifyId: json['classifyId'],
      title: json['title'],
      tagValue: json['tagValue'],
    );
  }
}
