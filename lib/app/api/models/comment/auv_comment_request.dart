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

/// 获取动态评论请求模型
class AuvGetCommentsRequest {
  /// 页码
  final int pageNum;

  /// 每页条数
  final int pageSize;

  /// 查询条件
  final AuvQueryCommentConditionRequest condition;

  AuvGetCommentsRequest({
    required this.pageNum,
    required this.pageSize,
    required this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      'condition': condition.toJson(),
    };
  }
}
