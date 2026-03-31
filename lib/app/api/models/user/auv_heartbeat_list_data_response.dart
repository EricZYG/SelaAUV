import 'auv_heartbeat_list_item_response.dart';

/// 心动主播列表分页数据
class AuvHeartbeatListDataResponse {
  /// 总记录数
  final int total;

  /// 主播列表
  final List<AuvHeartbeatListItemResponse> list;

  /// 当前页码
  final int pageNum;

  /// 每页条数
  final int pageSize;

  /// 实际条数
  final int size;

  /// 开始行号
  final int startRow;

  /// 结束行号
  final int endRow;

  /// 总页数
  final int pages;

  /// 上一页页码
  final int prePage;

  /// 下一页页码
  final int nextPage;

  /// 是否第一页
  final bool isFirstPage;

  /// 是否最后一页
  final bool isLastPage;

  /// 是否有上一页
  final bool hasPreviousPage;

  /// 是否有下一页
  final bool hasNextPage;

  /// 导航页码数
  final int navigatePages;

  /// 导航页码列表
  final List<int> navigatepageNums;

  /// 导航首页码
  final int navigateFirstPage;

  /// 导航末页码
  final int navigateLastPage;

  AuvHeartbeatListDataResponse({
    required this.total,
    required this.list,
    required this.pageNum,
    required this.pageSize,
    required this.size,
    required this.startRow,
    required this.endRow,
    required this.pages,
    required this.prePage,
    required this.nextPage,
    required this.isFirstPage,
    required this.isLastPage,
    required this.hasPreviousPage,
    required this.hasNextPage,
    required this.navigatePages,
    required this.navigatepageNums,
    required this.navigateFirstPage,
    required this.navigateLastPage,
  });

  factory AuvHeartbeatListDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatListDataResponse(
        total: 0,
        list: [],
        pageNum: 0,
        pageSize: 0,
        size: 0,
        startRow: 0,
        endRow: 0,
        pages: 0,
        prePage: 0,
        nextPage: 0,
        isFirstPage: false,
        isLastPage: false,
        hasPreviousPage: false,
        hasNextPage: false,
        navigatePages: 0,
        navigatepageNums: [],
        navigateFirstPage: 0,
        navigateLastPage: 0,
      );
    }
    return AuvHeartbeatListDataResponse(
      total: json['total'] as int? ?? 0,
      list: (json['list'] as List<dynamic>?)
              ?.map((e) => AuvHeartbeatListItemResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pageNum: json['pageNum'] as int? ?? 0,
      pageSize: json['pageSize'] as int? ?? 0,
      size: json['size'] as int? ?? 0,
      startRow: json['startRow'] as int? ?? 0,
      endRow: json['endRow'] as int? ?? 0,
      pages: json['pages'] as int? ?? 0,
      prePage: json['prePage'] as int? ?? 0,
      nextPage: json['nextPage'] as int? ?? 0,
      isFirstPage: json['isFirstPage'] as bool? ?? false,
      isLastPage: json['isLastPage'] as bool? ?? false,
      hasPreviousPage: json['hasPreviousPage'] as bool? ?? false,
      hasNextPage: json['hasNextPage'] as bool? ?? false,
      navigatePages: json['navigatePages'] as int? ?? 0,
      navigatepageNums: (json['navigatepageNums'] as List<dynamic>?)?.cast<int>() ?? [],
      navigateFirstPage: json['navigateFirstPage'] as int? ?? 0,
      navigateLastPage: json['navigateLastPage'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'list': list.map((e) => e.toJson()).toList(),
      'pageNum': pageNum,
      'pageSize': pageSize,
      'size': size,
      'startRow': startRow,
      'endRow': endRow,
      'pages': pages,
      'prePage': prePage,
      'nextPage': nextPage,
      'isFirstPage': isFirstPage,
      'isLastPage': isLastPage,
      'hasPreviousPage': hasPreviousPage,
      'hasNextPage': hasNextPage,
      'navigatePages': navigatePages,
      'navigatepageNums': navigatepageNums,
      'navigateFirstPage': navigateFirstPage,
      'navigateLastPage': navigateLastPage,
    };
  }
}
