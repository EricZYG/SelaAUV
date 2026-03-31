/// 动态分页查询条件
class AuvMomentCondition {
  /// 主题ID（必填）
  final int topicId;

  /// 排序方式（0热门，1最新）
  final int order;

  AuvMomentCondition({
    required this.topicId,
    required this.order,
  });

  Map<String, dynamic> toJson() {
    return {
      'topicId': topicId,
      'order': order,
    };
  }
}
