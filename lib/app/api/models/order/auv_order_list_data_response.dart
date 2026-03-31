/// 订单简要信息分页数据模型
import 'auv_order_simple_response.dart';

class AuvOrderSimpleListDataResponse {
  /// 订单列表
  final List<AuvOrderSimpleResponse>? list;

  /// 总条数
  final int? total;

  /// 当前第几页
  final int? pageNum;

  /// 每页条数
  final int? pageSize;

  /// 当前页条数
  final int? size;

  /// 当前页起始行
  final int? startRow;

  /// 当前页结束行
  final int? endRow;

  /// 总页数
  final int? pages;

  /// 上一页页码
  final int? prePage;

  /// 下一页页码
  final int? nextPage;

  /// 是否第一页
  final bool? isFirstPage;

  /// 是否最后一页
  final bool? isLastPage;

  /// 是否存在上一页
  final bool? hasPreviousPage;

  /// 是否存在下一页
  final bool? hasNextPage;

  /// 导航页码数
  final int? navigatePages;

  /// 导航页码数组
  final List<int>? navigatepageNums;

  /// 导航首页码
  final int? navigateFirstPage;

  /// 导航末页码
  final int? navigateLastPage;

  AuvOrderSimpleListDataResponse({
    this.list,
    this.total,
    this.pageNum,
    this.pageSize,
    this.size,
    this.startRow,
    this.endRow,
    this.pages,
    this.prePage,
    this.nextPage,
    this.isFirstPage,
    this.isLastPage,
    this.hasPreviousPage,
    this.hasNextPage,
    this.navigatePages,
    this.navigatepageNums,
    this.navigateFirstPage,
    this.navigateLastPage,
  });

  factory AuvOrderSimpleListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvOrderSimpleListDataResponse();
    return AuvOrderSimpleListDataResponse(
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvOrderSimpleResponse.fromJson(e))
          .toList(),
      total: json['total'],
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      size: json['size'],
      startRow: json['startRow'],
      endRow: json['endRow'],
      pages: json['pages'],
      prePage: json['prePage'],
      nextPage: json['nextPage'],
      isFirstPage: json['isFirstPage'],
      isLastPage: json['isLastPage'],
      hasPreviousPage: json['hasPreviousPage'],
      hasNextPage: json['hasNextPage'],
      navigatePages: json['navigatePages'],
      navigatepageNums: (json['navigatepageNums'] as List<dynamic>?)?.cast<int>(),
      navigateFirstPage: json['navigateFirstPage'],
      navigateLastPage: json['navigateLastPage'],
    );
  }
}