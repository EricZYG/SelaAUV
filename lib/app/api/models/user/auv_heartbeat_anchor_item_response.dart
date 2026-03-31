/// 批量查询主播心动信息响应项
class AuvHeartbeatAnchorItemResponse {
  /// 主播ID
  final int anchorId;

  /// 在线状态
  final int isOnline;

  /// 心动值
  final int score;

  /// 心动等级
  final int level;

  /// 是否在直播中（0否，1是）
  final int inLiveRoom;

  /// 房间ID
  final int roomId;

  AuvHeartbeatAnchorItemResponse({
    required this.anchorId,
    required this.isOnline,
    required this.score,
    required this.level,
    required this.inLiveRoom,
    required this.roomId,
  });

  factory AuvHeartbeatAnchorItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatAnchorItemResponse(
        anchorId: 0,
        isOnline: 0,
        score: 0,
        level: 0,
        inLiveRoom: 0,
        roomId: 0,
      );
    }
    return AuvHeartbeatAnchorItemResponse(
      anchorId: json['anchorId'] as int? ?? 0,
      isOnline: json['isOnline'] as int? ?? 0,
      score: json['score'] as int? ?? 0,
      level: json['level'] as int? ?? 0,
      inLiveRoom: json['inLiveRoom'] as int? ?? 0,
      roomId: json['roomId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anchorId': anchorId,
      'isOnline': isOnline,
      'score': score,
      'level': level,
      'inLiveRoom': inLiveRoom,
      'roomId': roomId,
    };
  }
}
