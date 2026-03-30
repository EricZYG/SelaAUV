/// 我的动态列表项模型
library;

import 'auv_moment_media_response.dart';

class AuvMyMomentItemResponse {
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

  AuvMyMomentItemResponse({
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

  factory AuvMyMomentItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvMyMomentItemResponse();
    return AuvMyMomentItemResponse(
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

/// 我的动态列表响应数据模型
class AuvMyMomentListDataResponse {
  /// 总数
  final int? total;

  /// 列表
  final List<AuvMyMomentItemResponse>? list;

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

  AuvMyMomentListDataResponse({
    this.total,
    this.list,
    this.pageNum,
    this.pageSize,
    this.pages,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory AuvMyMomentListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvMyMomentListDataResponse();
    return AuvMyMomentListDataResponse(
      total: json['total'],
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvMyMomentItemResponse.fromJson(e))
          .toList(),
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      pages: json['pages'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
    );
  }
}