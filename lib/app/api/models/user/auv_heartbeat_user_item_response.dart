/// 主播获取心动用户列表响应模型
class AuvHeartbeatUserItemResponse {
  /// 用户ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String portrait;

  /// 在线状态
  final int isOnline;

  /// 心动值
  final double score;

  /// 心动值进度（0-100）
  final int progress;

  /// 心动等级
  final int level;

  /// 用户等级
  final int userLevel;

  /// 是否VIP
  final bool vipFlag;

  /// 是否是高级用户（0否，1是）
  final int isAdvanceUser;

  AuvHeartbeatUserItemResponse({
    required this.userId,
    required this.nickname,
    required this.portrait,
    required this.isOnline,
    required this.score,
    required this.progress,
    required this.level,
    required this.userLevel,
    required this.vipFlag,
    required this.isAdvanceUser,
  });

  factory AuvHeartbeatUserItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatUserItemResponse(
        userId: 0,
        nickname: '',
        portrait: '',
        isOnline: 0,
        score: 0,
        progress: 0,
        level: 0,
        userLevel: 0,
        vipFlag: false,
        isAdvanceUser: 0,
      );
    }
    return AuvHeartbeatUserItemResponse(
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String? ?? '',
      isOnline: json['isOnline'] as int? ?? 0,
      score: (json['score'] as num?)?.toDouble() ?? 0,
      progress: json['progress'] as int? ?? 0,
      level: json['level'] as int? ?? 0,
      userLevel: json['userLevel'] as int? ?? 0,
      vipFlag: json['vipFlag'] as bool? ?? false,
      isAdvanceUser: json['isAdvanceUser'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'portrait': portrait,
      'isOnline': isOnline,
      'score': score,
      'progress': progress,
      'level': level,
      'userLevel': userLevel,
      'vipFlag': vipFlag,
      'isAdvanceUser': isAdvanceUser,
    };
  }
}
