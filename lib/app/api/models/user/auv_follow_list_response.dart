import 'auv_follow_list_request.dart';
import 'auv_follow_list_item_response.dart';
import 'auv_follow_list_type.dart';

/// 关注列表等级配置响应模型
class AuvFollowLevelConfigResponse {
  final int? level;
  final int? begin;
  final int? end;
  final String? icon;
  final int? userId;

  AuvFollowLevelConfigResponse({
    this.level,
    this.begin,
    this.end,
    this.icon,
    this.userId,
  });

  factory AuvFollowLevelConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvFollowLevelConfigResponse();
    return AuvFollowLevelConfigResponse(
      level: json['level'],
      begin: json['begin'],
      end: json['end'],
      icon: json['icon'],
      userId: json['userID'],
    );
  }
}

/// 关注列表分页数据响应模型
class AuvFollowListDataResponse {
  final List<AuvFollowListItemResponse>? list;
  final int? total;
  final int? pageSize;
  final int? pageNum;
  final int? pages;
  final bool? hasNextPage;
  final bool? hasPreviousPage;
  final bool? isFirstPage;
  final bool? isLastPage;

  AuvFollowListDataResponse({
    this.list,
    this.total,
    this.pageSize,
    this.pageNum,
    this.pages,
    this.hasNextPage,
    this.hasPreviousPage,
    this.isFirstPage,
    this.isLastPage,
  });

  factory AuvFollowListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvFollowListDataResponse();
    return AuvFollowListDataResponse(
      list: (json['list'] as List<dynamic>?)?.map((e) => AuvFollowListItemResponse.fromJson(e)).toList(),
      total: json['total'],
      pageSize: json['pageSize'],
      pageNum: json['pageNum'],
      pages: json['pages'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
      isFirstPage: json['isFirstPage'],
      isLastPage: json['isLastPage'],
    );
  }
}
