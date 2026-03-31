/// 结束直播响应
///
/// 结束直播后返回的统计数据
class AuvEndRoomResponse {
  /// 房间ID
  final int roomId;

  /// 房间状态（1.直播中，2.暂停，3.结束）
  final int roomStatus;

  /// 礼物收益
  final int? giftCoins;

  /// 礼物数
  final int? giftCount;

  /// 送礼人数
  final int? giftUserCount;

  /// 观看人数
  final int? watchCount;

  /// 新增粉丝数
  final int? followCount;

  /// 点赞数
  final int? likeCount;

  /// 贡献值
  final int? heatValue;

  /// 直播时长（毫秒数）
  final int? duration;

  AuvEndRoomResponse({
    required this.roomId,
    required this.roomStatus,
    this.giftCoins,
    this.giftCount,
    this.giftUserCount,
    this.watchCount,
    this.followCount,
    this.likeCount,
    this.heatValue,
    this.duration,
  });

  factory AuvEndRoomResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvEndRoomResponse(
        roomId: 0,
        roomStatus: 0,
      );
    }
    return AuvEndRoomResponse(
      roomId: json['roomId'] as int? ?? 0,
      roomStatus: json['roomStatus'] as int? ?? 0,
      giftCoins: json['giftCoins'] as int?,
      giftCount: json['giftCount'] as int?,
      giftUserCount: json['giftUserCount'] as int?,
      watchCount: json['watchCount'] as int?,
      followCount: json['followCount'] as int?,
      likeCount: json['likeCount'] as int?,
      heatValue: json['heatValue'] as int?,
      duration: json['duration'] as int?,
    );
  }
}
