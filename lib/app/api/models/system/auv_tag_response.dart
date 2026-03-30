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

/// 标签分类模型
///
/// 表示标签分类信息
///
/// 字段说明:
/// - title: 分类名
/// - tags: 标签列表
class AuvTagCategoryResponse {
  /// 分类名
  final String? title;

  /// 标签列表
  final List<AuvTagItemResponse>? tags;

  AuvTagCategoryResponse({
    this.title,
    this.tags,
  });

  factory AuvTagCategoryResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvTagCategoryResponse();
    return AuvTagCategoryResponse(
      title: json['title'],
      tags: (json['tags'] as List<dynamic>?)
          ?.map((e) => AuvTagItemResponse.fromJson(e))
          .toList(),
    );
  }
}