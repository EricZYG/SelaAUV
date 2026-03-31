/// 分页查询直播间列表请求模型
library;

/// 查询直播间请求参数
class GetLiveRoomRequest {
  /// 房间类型
  /// 1.普通直播间，2.游戏直播间，3.私密直播间
  final int? roomType;

  /// 用户首页地区编码
  final int? areaCode;

  GetLiveRoomRequest({
    this.roomType,
    this.areaCode,
  });

  Map<String, dynamic> toJson() {
    return {
      if (roomType != null) 'roomType': roomType,
      if (areaCode != null) 'areaCode': areaCode,
    };
  }
}
