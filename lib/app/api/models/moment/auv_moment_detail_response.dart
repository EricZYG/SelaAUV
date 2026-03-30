/// 单条动态详情模型
library;

import '../user/auv_level_config_response.dart';
import 'auv_moment_media_response.dart';

class AuvMomentDetailResponse {
  /// 动态id
  final int? momentId;

  /// 主播id
  final int? userId;

  /// 审核状态 0.待审核 1.审核通过 2.审核失败
  final int? momentStatus;

  /// 昵称
  final String? nickname;

  /// 头像
  final String? portrait;

  /// 国家编码
  final int? countryCode;

  /// 国旗链接
  final String? countryPath;

  /// 国家名
  final String? countryTitle;

  /// 等级信息
  final AuvLevelConfigResponse? levelConfig;

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

  AuvMomentDetailResponse({
    this.momentId,
    this.userId,
    this.momentStatus,
    this.nickname,
    this.portrait,
    this.countryCode,
    this.countryPath,
    this.countryTitle,
    this.levelConfig,
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

  factory AuvMomentDetailResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvMomentDetailResponse();
    return AuvMomentDetailResponse(
      momentId: json['momentId'],
      userId: json['userId'],
      momentStatus: json['momentStatus'],
      nickname: json['nickname'],
      portrait: json['portrait'],
      countryCode: json['countryCode'],
      countryPath: json['countryPath'],
      countryTitle: json['countryTitle'],
      levelConfig: json['levelConfig'] != null
          ? AuvLevelConfigResponse.fromJson(json['levelConfig'])
          : null,
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