/// 批量获取主播心动值响应项
class AuvHeartbeatValueItemResponse {
  /// 心动值
  final int score;

  /// 心动等级
  final int level;

  /// 用户ID
  final int userId;

  /// 主播ID
  final int anchorId;

  AuvHeartbeatValueItemResponse({
    required this.score,
    required this.level,
    required this.userId,
    required this.anchorId,
  });

  factory AuvHeartbeatValueItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatValueItemResponse(
        score: 0,
        level: 0,
        userId: 0,
        anchorId: 0,
      );
    }
    return AuvHeartbeatValueItemResponse(
      score: json['score'] as int? ?? 0,
      level: json['level'] as int? ?? 0,
      userId: json['userId'] as int? ?? 0,
      anchorId: json['anchorId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'level': level,
      'userId': userId,
      'anchorId': anchorId,
    };
  }
}
