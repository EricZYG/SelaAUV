/// 查询动态评论条件模型
class AuvQueryCommentConditionRequest {
  final int momentId;
  final int? topCommentId;

  AuvQueryCommentConditionRequest({required this.momentId, this.topCommentId});

  Map<String, dynamic> toJson() => {
    'momentId': momentId,
    if (topCommentId != null) 'topCommentId': topCommentId,
  };
}
