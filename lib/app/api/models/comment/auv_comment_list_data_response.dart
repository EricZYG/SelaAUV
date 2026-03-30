/// 动态评论列表响应数据模型
library;

import 'auv_comment_item_response.dart';

class AuvCommentListDataResponse {
  /// 总数
  final int? total;

  /// 列表
  final List<AuvCommentItemResponse>? list;

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

  AuvCommentListDataResponse({
    this.total,
    this.list,
    this.pageNum,
    this.pageSize,
    this.pages,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory AuvCommentListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCommentListDataResponse();
    return AuvCommentListDataResponse(
      total: json['total'],
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvCommentItemResponse.fromJson(e))
          .toList(),
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      pages: json['pages'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
    );
  }
}