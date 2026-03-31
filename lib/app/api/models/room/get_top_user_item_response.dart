/// 直播间Top用户模型
library;

/// 直播间Top用户信息
class GetTopUserItemResponse {
  /// 用户ID
  final int? userId;

  /// 昵称
  final String? nickname;

  /// 头像
  final String? portrait;

  /// 贡献值
  final int? heatValue;

  /// 性别
  /// 1.男，2.女
  final int? sex;

  /// 用户等级
  final int? userLevel;

  /// 是否vip
  final bool? vipFlag;

  GetTopUserItemResponse({
    this.userId,
    this.nickname,
    this.portrait,
    this.heatValue,
    this.sex,
    this.userLevel,
    this.vipFlag,
  });

  factory GetTopUserItemResponse.fromJson(Map<String, dynamic> json) {
    return GetTopUserItemResponse(
      userId: json['userId'],
      nickname: json['nickname'],
      portrait: json['portrait'],
      heatValue: json['heatValue'],
      sex: json['sex'],
      userLevel: json['userLevel'],
      vipFlag: json['vipFlag'],
    );
  }
}
