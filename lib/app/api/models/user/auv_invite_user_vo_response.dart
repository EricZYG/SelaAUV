/// 邀请用户VO模型
///
/// 获取邀请奖励记录列表接口返回的被邀请用户信息
library;

/// 字段说明:
/// - inviteeUserId: 被邀请用户ID
/// - nickname: 昵称
/// - portrait: 头像
/// - createdAt: 创建时间
/// - type: 类型（1注册奖励 2充值奖励）
/// - reward: 奖励钻石数（×100）
class AuvInviteUserVoResponse {
  /// 被邀请用户ID
  final int? inviteeUserId;

  /// 昵称
  final String? nickname;

  /// 头像
  final String? portrait;

  /// 创建时间
  final int? createdAt;

  /// 类型（1注册奖励 2充值奖励）
  final int? type;

  /// 奖励钻石数（×100）
  final int? reward;

  AuvInviteUserVoResponse({
    this.inviteeUserId,
    this.nickname,
    this.portrait,
    this.createdAt,
    this.type,
    this.reward,
  });

  factory AuvInviteUserVoResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvInviteUserVoResponse();
    return AuvInviteUserVoResponse(
      inviteeUserId: json['inviteeUserId'],
      nickname: json['nickname'],
      portrait: json['portrait'],
      createdAt: json['createdAt'],
      type: json['type'],
      reward: json['reward'],
    );
  }

  /// 获取奖励类型的字符串描述
  String? get rewardTypeStr {
    switch (type) {
      case 1:
        return '注册奖励';
      case 2:
        return '充值奖励';
      default:
        return null;
    }
  }
}
