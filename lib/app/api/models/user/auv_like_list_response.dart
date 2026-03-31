import 'auv_like_list_item_response.dart';

/// 喜欢列表分页数据响应模型
class AuvLikeListDataResponse {
  final List<AuvLikeListItemResponse>? list;
  final int? total;
  final int? pageSize;
  final int? pageNum;
  final int? pages;
  final bool? hasNextPage;
  final bool? hasPreviousPage;
  final bool? isFirstPage;
  final bool? isLastPage;

  AuvLikeListDataResponse({
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

  factory AuvLikeListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvLikeListDataResponse();
    return AuvLikeListDataResponse(
      list: (json['list'] as List<dynamic>?)?.map((e) => AuvLikeListItemResponse.fromJson(e)).toList(),
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
