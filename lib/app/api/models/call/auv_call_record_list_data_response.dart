/// 通话记录分页列表响应数据模型
library;

import 'auv_call_record_item_response.dart';

/// 通话记录分页列表响应数据模型
/// 
/// 包含分页信息和通话记录列表
class AuvCallRecordListDataResponse {
  /// 总条数
  /// 
  /// 符合条件的通话记录总数量
  final int? total;

  /// 通话记录列表
  /// 
  /// 当前页的通话记录数据
  final List<AuvCallRecordItemResponse>? list;

  /// 当前第几页
  /// 
  /// 分页中的当前页码
  final int? pageNum;

  /// 每页条数
  /// 
  /// 每页返回的记录数量
  final int? pageSize;

  /// 当前页条数
  /// 
  /// 当前页实际返回的记录数量
  final int? size;

  /// 当前页起始行
  /// 
  /// 当前页在总数据中的起始位置
  final int? startRow;

  /// 当前页结束行
  /// 
  /// 当前页在总数据中的结束位置
  final int? endRow;

  /// 总页数
  /// 
  /// 分页后的总页数
  final int? pages;

  /// 上一页页码
  /// 
  /// 上一页的页码（如果没有上一页则为0）
  final int? prePage;

  /// 下一页页码
  /// 
  /// 下一页的页码（如果没有下一页则为0）
  final int? nextPage;

  /// 是否第一页
  /// 
  /// true表示当前页是第一页
  final bool? isFirstPage;

  /// 是否最后一页
  /// 
  /// true表示当前页是最后一页
  final bool? isLastPage;

  /// 是否存在上一页
  /// 
  /// true表示还有上一页数据
  final bool? hasPreviousPage;

  /// 是否存在下一页
  /// 
  /// true表示还有下一页数据
  final bool? hasNextPage;

  /// 导航页码数
  /// 
  /// 导航栏显示的页码数量
  final int? navigatePages;

  /// 导航页码数组
  /// 
  /// 导航栏显示的页码列表
  final List<int>? navigatepageNums;

  /// 导航首页码
  /// 
  /// 导航栏第一个页码
  final int? navigateFirstPage;

  /// 导航末页码
  /// 
  /// 导航栏最后一个页码
  final int? navigateLastPage;

  AuvCallRecordListDataResponse({
    this.total,
    this.list,
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

  factory AuvCallRecordListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCallRecordListDataResponse();
    return AuvCallRecordListDataResponse(
      total: json['total'],
      list: (json['list'] as List<dynamic>?)
          ?.map((e) => AuvCallRecordItemResponse.fromJson(e))
          .toList(),
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