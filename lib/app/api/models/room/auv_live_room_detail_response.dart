/// 直播间详情模型
library;

import 'auv_audience_response.dart';

/// 获取直播间详情接口返回的完整数据
/// 
/// 字段说明:
/// - roomId: 直播间ID
/// - roomName: 直播间名称
/// - coverUrl: 封面图URL
/// - categoryId: 所属分类ID
/// - categoryName: 所属分类名称
/// - anchorId: 主播ID
/// - anchorName: 主播名称
/// - anchorAvatar: 主播头像
/// - liveUrl: 直播流地址
/// - viewerCount: 当前观看人数
/// - audienceList: 观众列表
class AuvLiveRoomDetailResponse {
  /// 直播间ID
  final int? roomId;
  
  /// 直播间名称
  final String? roomName;
  
  /// 封面图URL
  final String? coverUrl;
  
  /// 所属分类ID
  final int? categoryId;
  
  /// 所属分类名称
  final String? categoryName;
  
  /// 主播ID
  final int? anchorId;
  
  /// 主播名称
  final String? anchorName;
  
  /// 主播头像
  final String? anchorAvatar;
  
  /// 直播流地址
  final String? liveUrl;
  
  /// 当前观看人数
  final int? viewerCount;
  
  /// 观众列表
  final List<AuvAudienceResponse>? audienceList;

  AuvLiveRoomDetailResponse({
    this.roomId,
    this.roomName,
    this.coverUrl,
    this.categoryId,
    this.categoryName,
    this.anchorId,
    this.anchorName,
    this.anchorAvatar,
    this.liveUrl,
    this.viewerCount,
    this.audienceList,
  });

  factory AuvLiveRoomDetailResponse.fromJson(Map<String, dynamic> json) {
    return AuvLiveRoomDetailResponse(
      roomId: json['roomId'],
      roomName: json['roomName'],
      coverUrl: json['coverUrl'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      anchorId: json['anchorId'],
      anchorName: json['anchorName'],
      anchorAvatar: json['anchorAvatar'],
      liveUrl: json['liveUrl'],
      viewerCount: json['viewerCount'],
      audienceList: json['audienceList'] != null
          ? (json['audienceList'] as List)
              .map((e) => AuvAudienceResponse.fromJson(e))
              .toList()
          : null,
    );
  }
}