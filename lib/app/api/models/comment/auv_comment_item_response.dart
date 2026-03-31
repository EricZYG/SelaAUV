/// 评论项模型

import '../user/auv_level_config_response.dart';
import 'auv_comment_reply_response.dart';

class AuvCommentItemResponse {
  /// 评论id
  final int? commentId;

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

  /// 评论内容
  final String? content;

  /// 评论时间
  final int? createdAt;

  /// 回复列表
  final AuvCommentReplyResponse? replies;

  /// 点赞数
  final int? praiseCount;

  /// 是否点赞 0.否 1.是
  final int? praiseFlag;

  AuvCommentItemResponse({
    this.commentId,
    this.userId,
    this.userAuth,
    this.nickname,
    this.portrait,
    this.vipFlag,
    this.levelConfig,
    this.content,
    this.createdAt,
    this.replies,
    this.praiseCount,
    this.praiseFlag,
  });

  factory AuvCommentItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCommentItemResponse();
    return AuvCommentItemResponse(
      commentId: json['commentId'],
      userId: json['userId'],
      userAuth: json['userAuth'],
      nickname: json['nickname'],
      portrait: json['portrait'],
      vipFlag: json['vipFlag'],
      levelConfig: json['levelConfig'] != null
          ? AuvLevelConfigResponse.fromJson(json['levelConfig'])
          : null,
      content: json['content'],
      createdAt: json['createdAt'],
      replies: json['replies'] != null
          ? AuvCommentReplyResponse.fromJson(json['replies'])
          : null,
      praiseCount: json['praiseCount'],
      praiseFlag: json['praiseFlag'],
    );
  }
}