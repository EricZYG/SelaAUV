/// 评论回复项
class AuvCommentReplyItem {
  /// 评论ID
  final int commentId;

  /// 用户ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String? portrait;

  /// 生日
  final int? birthday;

  /// 性别（1男，2女）
  final int? sex;

  /// 内容
  final String? content;

  /// 点赞数量
  final int praiseCount;

  /// 创建时间
  final int createdAt;

  /// 是否点赞（0否，1是）
  final int praiseFlag;

  /// 回复的评论ID
  final int? replyCommentId;

  AuvCommentReplyItem({
    required this.commentId,
    required this.userId,
    required this.nickname,
    this.portrait,
    this.birthday,
    this.sex,
    this.content,
    required this.praiseCount,
    required this.createdAt,
    required this.praiseFlag,
    this.replyCommentId,
  });

  factory AuvCommentReplyItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvCommentReplyItem(
        commentId: 0,
        userId: 0,
        nickname: '',
        praiseCount: 0,
        createdAt: 0,
        praiseFlag: 0,
      );
    }
    return AuvCommentReplyItem(
      commentId: json['commentId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String?,
      birthday: json['birthday'] as int?,
      sex: json['sex'] as int?,
      content: json['content'] as String?,
      praiseCount: json['praiseCount'] as int? ?? 0,
      createdAt: json['createdAt'] as int? ?? 0,
      praiseFlag: json['praiseFlag'] as int? ?? 0,
      replyCommentId: json['replyCommentId'] as int?,
    );
  }
}
