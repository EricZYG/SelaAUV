/// 创建直播间响应
///
/// 创建直播间成功后返回的数据
///
/// 字段说明:
/// - roomId: 房间ID
/// - channelName: 房间频道号，用于连声网rtc
/// - roomStatus: 房间状态（1.直播中，2.暂停，3.结束）
class AuvCreateRoomResponse {
  /// 房间ID
  final int roomId;

  /// 房间频道号，用于连声网rtc
  final String? channelName;

  /// 房间状态（1.直播中，2.暂停，3.结束）
  final int roomStatus;

  AuvCreateRoomResponse({
    required this.roomId,
    this.channelName,
    required this.roomStatus,
  });

  factory AuvCreateRoomResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvCreateRoomResponse(
        roomId: 0,
        roomStatus: 0,
      );
    }
    return AuvCreateRoomResponse(
      roomId: json['roomId'] as int? ?? 0,
      channelName: json['channelName'] as String?,
      roomStatus: json['roomStatus'] as int? ?? 0,
    );
  }
}
