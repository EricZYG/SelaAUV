/// 根据邀请码查询用户ID响应模型
/// 
/// 对应接口: /user/user/getUserIdByInviteCode
/// 
/// 根据邀请码查询对应的用户ID
class AuvUserIdByInviteCodeResponse {
  /// 邀请人用户id
  final int userId;

  /// 邀请码
  final String inviteCode;

  AuvUserIdByInviteCodeResponse({
    required this.userId,
    required this.inviteCode,
  });

  factory AuvUserIdByInviteCodeResponse.fromJson(Map<String, dynamic> json) {
    return AuvUserIdByInviteCodeResponse(
      userId: json['userId'] ?? 0,
      inviteCode: json['inviteCode'] ?? '',
    );
  }
}
