/// 动态通知类型
enum AuvMomentNoticeType {
  momentLike(1),      // 动态点赞
  commentLike(2),     // 评论点赞
  momentComment(3),   // 动态评论
  replyComment(4);    // 回复评论

  final int value;
  const AuvMomentNoticeType(this.value);

  static AuvMomentNoticeType? fromValue(int value) {
    return AuvMomentNoticeType.values.where((e) => e.value == value).firstOrNull;
  }
}

/// 动态列表查询类型
enum AuvMomentQueryType {
  hot(1),    // 热门
  newMoment(2), // 最新
  follow(3); // 关注

  final int value;
  const AuvMomentQueryType(this.value);

  static AuvMomentQueryType? fromValue(int value) {
    return AuvMomentQueryType.values.where((e) => e.value == value).firstOrNull;
  }
}

/// 动态审核状态
enum AuvMomentStatus {
  pending(0),    // 待审核
  approved(1),    // 审核通过
  rejected(2);   // 审核失败

  final int value;
  const AuvMomentStatus(this.value);

  static AuvMomentStatus? fromValue(int value) {
    return AuvMomentStatus.values.where((e) => e.value == value).firstOrNull;
  }
}

/// 关注状态
enum AuvFollowFlag {
  notFollowed(1),   // 未关注
  followed(2),      // 已关注
  friend(3);       // 好友

  final int value;
  const AuvFollowFlag(this.value);

  static AuvFollowFlag? fromValue(int value) {
    return AuvFollowFlag.values.where((e) => e.value == value).firstOrNull;
  }
}
