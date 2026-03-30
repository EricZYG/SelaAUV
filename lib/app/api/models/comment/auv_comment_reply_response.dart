/// 评论回复模型
library;

import '../user/auv_level_config_response.dart';

class AuvCommentReplyResponse {
  /// 评论id
  final int? commentId;

  /// 回复评论id
  final int? replyCommentId;

  /// 用户id
  final int? userId;

  /// 认证状态 0.男用户 2.已认证主播
  final int? userAuth;

  /// 昵称
  final String? nickname;

  /// 头像
  final String? portrait;

  /// 是否vip
  final bool? vipFlag;

  /// 等级信息
  final AuvLevelConfigResponse? levelConfig;

  /// 回复用户id
  final int? replyUserId;

  /// 回复用户昵称
  final String? replyNickname;

  /// 评论内容
  final String? content;

  /// 点赞数
  final int? praiseCount;

  /// 是否点赞 0.否 1.是
  final int? praiseFlag;

  AuvCommentReplyResponse({
    this.commentId,
    this.replyCommentId,
    this.userId,
    this.userAuth,
    this.nickname,
    this.portrait,
    this.vipFlag,
    this.levelConfig,
    this.replyUserId,
    this.replyNickname,
    this.content,
    this.praiseCount,
    this.praiseFlag,
  });

  factory AuvCommentReplyResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCommentReplyResponse();
    return AuvCommentReplyResponse(
      commentId: json['commentId'],
      replyCommentId: json['replyCommentId'],
      userId: json['userId'],
      userAuth: json['userAuth'],
      nickname: json['nickname'],
      portrait: json['portrait'],
      vipFlag: json['vipFlag'],
      levelConfig: json['levelConfig'] != null
          ? AuvLevelConfigResponse.fromJson(json['levelConfig'])
          : null,
      replyUserId: json['replyUserId'],
      replyNickname: json['replyNickname'],
      content: json['content'],
      praiseCount: json['praiseCount'],
      praiseFlag: json['praiseFlag'],
    );
  }
}