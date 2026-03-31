/// 查询动态评论条件模型
class AuvQueryCommentConditionRequest {
  /// 动态id
  final int momentId;

  /// 要置顶的评论id
  final int? topCommentId;

  AuvQueryCommentConditionRequest({
    required this.momentId,
    this.topCommentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'momentId': momentId,
      if (topCommentId != null) 'topCommentId': topCommentId,
    };
  }
}
