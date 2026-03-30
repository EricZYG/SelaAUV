/// 动态基础信息模型
library;

import 'auv_moment_media_response.dart';

class AuvMomentBaseResponse {
  /// 动态id
  final int? momentId;

  /// 审核状态 0.待审核 1.审核通过 2.审核失败
  final int? momentStatus;

  /// 可见范围 0.公开 1.仅付费用户
  final int? visibleType;

  /// 文字内容
  final String? content;

  /// 点赞数
  final int? praiseCount;

  /// 评论数
  final int? commentCount;

  /// 点击量
  final int? clickCount;

  /// 展示次数
  final int? showCount;

  /// 发布时间
  final int? createdAt;

  /// 是否点赞 0.否 1.是
  final int? praiseFlag;

  /// 媒体信息
  final AuvMomentMediaResponse? medias;

  AuvMomentBaseResponse({
    this.momentId,
    this.momentStatus,
    this.visibleType,
    this.content,
    this.praiseCount,
    this.commentCount,
    this.clickCount,
    this.showCount,
    this.createdAt,
    this.praiseFlag,
    this.medias,
  });

  factory AuvMomentBaseResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvMomentBaseResponse();
    return AuvMomentBaseResponse(
      momentId: json['momentId'],
      momentStatus: json['momentStatus'],
      visibleType: json['visibleType'],
      content: json['content'],
      praiseCount: json['praiseCount'],
      commentCount: json['commentCount'],
      clickCount: json['clickCount'],
      showCount: json['showCount'],
      createdAt: json['createdAt'],
      praiseFlag: json['praiseFlag'],
      medias: json['medias'] != null
          ? AuvMomentMediaResponse.fromJson(json['medias'])
          : null,
    );
  }
}