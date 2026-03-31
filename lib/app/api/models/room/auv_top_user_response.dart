/// Top用户信息
class AuvTopUserResponse {
  /// 用户ID
  final int userId;

  /// 昵称
  final String? nickname;

  /// 头像
  final String? portrait;

  /// 性别（1.男，2.女）
  final int? sex;

  /// 用户等级
  final int? userLevel;

  /// 贡献值
  final int? heatValue;

  /// 是否vip
  final bool? vipFlag;

  AuvTopUserResponse({
    required this.userId,
    this.nickname,
    this.portrait,
    this.sex,
    this.userLevel,
    this.heatValue,
    this.vipFlag,
  });

  factory AuvTopUserResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvTopUserResponse(userId: 0);
    }
    return AuvTopUserResponse(
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String?,
      portrait: json['portrait'] as String?,
      sex: json['sex'] as int?,
      userLevel: json['userLevel'] as int?,
      heatValue: json['heatValue'] as int?,
      vipFlag: json['vipFlag'] as bool?,
    );
  }
}
