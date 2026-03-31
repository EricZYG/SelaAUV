/// 分页查询直播间列表响应模型
library;

import 'get_live_room_item_response.dart';

/// 直播间列表接口返回的分页数据
class GetLiveRoomListDataResponse {
  /// 总记录数
  final int? total;

  /// 直播间列表
  final List<GetLiveRoomItemResponse>? list;

  /// 当前页码
  final int? pageNum;

  /// 每页条数
  final int? pageSize;

  /// 当前页记录数
  final int? size;

  /// 起始行号
  final int? startRow;

  /// 结束行号
  final int? endRow;

  /// 总页数
  final int? pages;

  /// 上一页页码
  final int? prePage;

  /// 下一页页码
  final int? nextPage;

  /// 是否为第一页
  final bool? isFirstPage;

  /// 是否为最后一页
  final bool? isLastPage;

  /// 是否有上一页
  final bool? hasPreviousPage;

  /// 是否有下一页
  final bool? hasNextPage;

  /// 导航页码数
  final int? navigatePages;

  /// 导航页码数组
  final List<int>? navigatepageNums;

  /// 导航首页码
  final int? navigateFirstPage;

  /// 导航末页码
  final int? navigateLastPage;

  GetLiveRoomListDataResponse({
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

  factory GetLiveRoomListDataResponse.fromJson(Map<String, dynamic> json) {
    return GetLiveRoomListDataResponse(
      total: json['total'],
      list: json['list'] != null
          ? (json['list'] as List)
              .map((e) => GetLiveRoomItemResponse.fromJson(e))
              .toList()
          : null,
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
      navigatepageNums: json['navigatepageNums'] != null
          ? (json['navigatepageNums'] as List).cast<int>()
          : null,
      navigateFirstPage: json['navigateFirstPage'],
      navigateLastPage: json['navigateLastPage'],
    );
  }
}
