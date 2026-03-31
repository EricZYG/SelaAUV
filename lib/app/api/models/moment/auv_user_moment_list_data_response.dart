import '../user/auv_level_config_response.dart';
import 'auv_moment_media_response.dart';

/// 用户端主播动态列表响应数据模型
class AuvUserMomentListDataResponse {
  /// 总数
  final int? total;

  /// 列表
  final List<AuvUserMomentItemResponse>? list;

  /// 当前页码
  final int? pageNum;

  /// 每页条数
  final int? pageSize;

  /// 总页数
  final int? pages;

  /// 是否有上一页
  final bool? hasPreviousPage;

  /// 是否有下一页
  final bool? hasNextPage;

  AuvUserMomentListDataResponse({
    this.total,
    this.list,
    this.pageNum,
    this.pageSize,
    this.pages,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory AuvUserMomentListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvUserMomentListDataResponse();
    return AuvUserMomentListDataResponse(
      total: json['total'],
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvUserMomentItemResponse.fromJson(e))
          .toList(),
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      pages: json['pages'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
    );
  }
}

/// 用户端主播动态列表项模型
class AuvUserMomentItemResponse {
  /// 动态id
  final int? momentId;

  /// 主播id
  final int? userId;

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

  /// 发布时间
  final int? createdAt;

  /// 是否点赞 0.否 1.是
  final int? praiseFlag;

  /// 媒体信息
  final AuvMomentMediaResponse? medias;

  AuvUserMomentItemResponse({
    this.momentId,
    this.userId,
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
    this.createdAt,
    this.praiseFlag,
    this.medias,
  });

  factory AuvUserMomentItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvUserMomentItemResponse();
    return AuvUserMomentItemResponse(
      momentId: json['momentId'],
      userId: json['userId'],
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
      createdAt: json['createdAt'],
      praiseFlag: json['praiseFlag'],
      medias: json['medias'] != null
          ? AuvMomentMediaResponse.fromJson(json['medias'])
          : null,
    );
  }
}
