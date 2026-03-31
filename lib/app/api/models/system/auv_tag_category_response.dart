import 'auv_tag_item_response.dart';

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
