import 'auv_comment_reply_item.dart';

/// 话题评论项
class AuvTopiaCommentItemResponse {
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

  /// 回复列表
  final List<AuvCommentReplyItem>? replies;

  /// 是否点赞（0否，1是）
  final int praiseFlag;

  AuvTopiaCommentItemResponse({
    required this.commentId,
    required this.userId,
    required this.nickname,
    this.portrait,
    this.birthday,
    this.sex,
    this.content,
    required this.praiseCount,
    required this.createdAt,
    this.replies,
    required this.praiseFlag,
  });

  factory AuvTopiaCommentItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvTopiaCommentItemResponse(
        commentId: 0,
        userId: 0,
        nickname: '',
        praiseCount: 0,
        createdAt: 0,
        praiseFlag: 0,
      );
    }
    return AuvTopiaCommentItemResponse(
      commentId: json['commentId'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String?,
      birthday: json['birthday'] as int?,
      sex: json['sex'] as int?,
      content: json['content'] as String?,
      praiseCount: json['praiseCount'] as int? ?? 0,
      createdAt: json['createdAt'] as int? ?? 0,
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => AuvCommentReplyItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      praiseFlag: json['praiseFlag'] as int? ?? 0,
    );
  }
}
