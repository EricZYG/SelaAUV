/// 常驻心动主播项
class AuvFixHeartbeatAnchorItemResponse {
  /// 主播ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String portrait;

  /// 在线状态
  final int isOnline;

  /// 心动值（小数点后两位）
  final double score;

  AuvFixHeartbeatAnchorItemResponse({
    required this.userId,
    required this.nickname,
    required this.portrait,
    required this.isOnline,
    required this.score,
  });

  factory AuvFixHeartbeatAnchorItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvFixHeartbeatAnchorItemResponse(
        userId: 0,
        nickname: '',
        portrait: '',
        isOnline: 0,
        score: 0,
      );
    }
    return AuvFixHeartbeatAnchorItemResponse(
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String? ?? '',
      isOnline: json['isOnline'] as int? ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'portrait': portrait,
      'isOnline': isOnline,
      'score': score,
    };
  }
}
