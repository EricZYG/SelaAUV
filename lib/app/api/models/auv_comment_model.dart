import 'auv_user_model.dart';
import 'auv_moment_model.dart';

/// 单条动态附带评论响应 - 回复项
class AuvCommentReply {
  final int commentId;          // 评论id
  final int replyCommentId;     // 回复评论id
  final int userId;            // 用户id
  final int userAuth;          // 认证状态，0.男用户，2.已认证主播
  final String nickname;       // 昵称
  final String portrait;        // 头像
  final bool vipFlag;          // 是否vip
  final AuvUserLevelConfig? levelConfig; // 等级信息
  final int replyUserId;       // 回复用户id
  final String replyNickname;  // 回复用户昵称
  final String content;        // 评论内容
  final int praiseCount;       // 点赞数
  final int praiseFlag;        // 是否点赞，0.否，1.是

  AuvCommentReply({
    required this.commentId,
    required this.replyCommentId,
    required this.userId,
    required this.userAuth,
    required this.nickname,
    required this.portrait,
    required this.vipFlag,
    this.levelConfig,
    required this.replyUserId,
    required this.replyNickname,
    required this.content,
    required this.praiseCount,
    required this.praiseFlag,
  });

  factory AuvCommentReply.fromJson(Map<String, dynamic> json) {
    return AuvCommentReply(
      commentId: json['commentId'] ?? 0,
      replyCommentId: json['replyCommentId'] ?? 0,
      userId: json['userId'] ?? 0,
      userAuth: json['userAuth'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      vipFlag: json['vipFlag'] ?? false,
      levelConfig: json['levelConfig'] != null
          ? AuvUserLevelConfig.fromJson(json['levelConfig'])
          : null,
      replyUserId: json['replyUserId'] ?? 0,
      replyNickname: json['replyNickname'] ?? '',
      content: json['content'] ?? '',
      praiseCount: json['praiseCount'] ?? 0,
      praiseFlag: json['praiseFlag'] ?? 0,
    );
  }

  /// 是否已点赞
  bool get isPraised => praiseFlag == 1;
}

/// 单条动态附带评论响应 - 评论项
class AuvCommentItem {
  final int commentId;          // 评论id
  final int userId;            // 用户id
  final int userAuth;          // 认证状态，0.男用户，2.已认证主播
  final String nickname;       // 昵称
  final String portrait;        // 头像
  final bool vipFlag;          // 是否vip
  final AuvUserLevelConfig? levelConfig; // 等级信息
  final String content;        // 评论内容
  final int createdAt;         // 评论时间
  final List<AuvCommentReply>? replies; // 回复列表
  final int praiseCount;       // 点赞数
  final int praiseFlag;        // 是否点赞，0.否，1.是

  AuvCommentItem({
    required this.commentId,
    required this.userId,
    required this.userAuth,
    required this.nickname,
    required this.portrait,
    required this.vipFlag,
    this.levelConfig,
    required this.content,
    required this.createdAt,
    this.replies,
    required this.praiseCount,
    required this.praiseFlag,
  });

  factory AuvCommentItem.fromJson(Map<String, dynamic> json) {
    return AuvCommentItem(
      commentId: json['commentId'] ?? 0,
      userId: json['userId'] ?? 0,
      userAuth: json['userAuth'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      vipFlag: json['vipFlag'] ?? false,
      levelConfig: json['levelConfig'] != null
          ? AuvUserLevelConfig.fromJson(json['levelConfig'])
          : null,
      content: json['content'] ?? '',
      createdAt: json['createdAt'] ?? 0,
      replies: json['replies'] != null
          ? (json['replies'] as List).map((e) => AuvCommentReply.fromJson(e)).toList()
          : null,
      praiseCount: json['praiseCount'] ?? 0,
      praiseFlag: json['praiseFlag'] ?? 0,
    );
  }

  /// 是否已点赞
  bool get isPraised => praiseFlag == 1;

  /// 是否是认证主播
  bool get isVerifiedAnchor => userAuth == 2;

  /// 获取评论时间
  DateTime? get commentTime {
    if (createdAt <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt);
  }
}
