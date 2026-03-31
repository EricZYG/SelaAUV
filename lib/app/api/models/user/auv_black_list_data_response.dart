import 'auv_black_list_response.dart';

/// 黑名单分页数据响应模型
/// 
/// 包含分页信息和黑名单用户列表
class AuvBlackListDataResponse {
  /// 用户列表
  final List<AuvBlackListItemResponse>? list;

  /// 总记录数
  final int? total;

  /// 每页条数
  final int? pageSize;

  /// 当前页码
  final int? pageNum;

  /// 总页数
  final int? pages;

  /// 是否有下一页
  final bool? hasNextPage;

  /// 是否有上一页
  final bool? hasPreviousPage;

  /// 是否第一页
  final bool? isFirstPage;

  /// 是否最后一页
  final bool? isLastPage;

  AuvBlackListDataResponse({
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

  factory AuvBlackListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvBlackListDataResponse();
    return AuvBlackListDataResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvBlackListItemResponse.fromJson(e))
          .toList(),
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
