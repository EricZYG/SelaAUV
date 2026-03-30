/// 直播间分页列表响应模型
library;

import 'auv_live_room_response.dart';

/// 直播间列表接口返回的分页数据
/// 
/// 字段说明:
/// - list: 直播间列表
/// - total: 总记录数
/// - page: 当前页码
/// - pageSize: 每页条数
class AuvLiveRoomListDataResponse {
  /// 直播间列表
  final List<AuvLiveRoomResponse>? list;
  
  /// 总记录数
  final int? total;
  
  /// 当前页码
  final int? page;
  
  /// 每页条数
  final int? pageSize;

  AuvLiveRoomListDataResponse({
    this.list,
    this.total,
    this.page,
    this.pageSize,
  });

  factory AuvLiveRoomListDataResponse.fromJson(Map<String, dynamic> json) {
    return AuvLiveRoomListDataResponse(
      list: json['list'] != null
          ? (json['list'] as List)
              .map((e) => AuvLiveRoomResponse.fromJson(e))
              .toList()
          : null,
      total: json['total'],
      page: json['page'],
      pageSize: json['pageSize'],
    );
  }
}