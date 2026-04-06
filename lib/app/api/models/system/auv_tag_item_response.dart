/// 标签项模型
///
/// 表示单个标签信息
class AuvTagItemResponse {
  /// 【遗漏】标签ID
  final String? id;

  /// 【遗漏】分类id
  final int? classifyId;

  /// 分类名
  final String? title;

  /// 标签值
  final String? tagValue;

  /// 【遗漏】标签类型，0表示普通标签
  final int? tagType;

  /// 【遗漏】标签图片
  final String? tagImg;

  AuvTagItemResponse({
    this.id,
    this.classifyId,
    this.title,
    this.tagValue,
    this.tagType,
    this.tagImg,
  });

  factory AuvTagItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvTagItemResponse();
    return AuvTagItemResponse(
      id: json['id']?.toString(),
      classifyId: json['classifyId'],
      title: json['title'],
      tagValue: json['tagValue'],
      tagType: json['tagType'],
      tagImg: json['tagImg'],
    );
  }
}
