import 'auv_order_list_item_response.dart';

/// 获取订单列表响应模型
class AuvOrderListResponse {
  /// 订单列表
  final List<AuvOrderListItemResponse>? list;

  /// 总条数
  final int? total;

  /// 当前第几页
  final int? pageNum;

  /// 每页条数
  final int? size;

  /// 总页数
  final int? pages;

  /// 是否第一页
  final bool? isFirstPage;

  /// 是否最后一页
  final bool? isLastPage;

  /// 是否存在上一页
  final bool? hasPreviousPage;

  /// 是否存在下一页
  final bool? hasNextPage;

  AuvOrderListResponse({
    this.list,
    this.total,
    this.pageNum,
    this.size,
    this.pages,
    this.isFirstPage,
    this.isLastPage,
    this.hasPreviousPage,
    this.hasNextPage,
  });

  factory AuvOrderListResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvOrderListResponse();
    return AuvOrderListResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvOrderListItemResponse.fromJson(e))
          .toList(),
      total: json['total'],
      pageNum: json['pageNum'],
      size: json['size'],
      pages: json['pages'],
      isFirstPage: json['isFirstPage'],
      isLastPage: json['isLastPage'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
    );
  }
}
