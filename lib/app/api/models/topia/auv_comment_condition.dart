/// 评论分页查询条件
class AuvCommentCondition {
  /// 动态ID（必填）
  final int momentId;

  AuvCommentCondition({
    required this.momentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'momentId': momentId,
    };
  }
}
