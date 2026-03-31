/// 话题分页查询条件
class AuvTopicCondition {
  /// 标签ID
  final int? tagId;

  /// 排序方式（0热门，1最新）
  final int order;

  AuvTopicCondition({
    this.tagId,
    required this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      if (tagId != null) 'tagId': tagId,
      'order': order,
    };
  }
}
