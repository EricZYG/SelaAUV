import 'auv_advance_reward_vo_response.dart';

/// 高级用户弹窗详情响应数据模型
class AuvAdvanceDialogDataResponse {
  /// 奖励信息
  final AuvAdvanceRewardVoResponse? rewardVo;

  /// WhatsApp ID
  final String? whatsappId;

  /// 是否高级用户：0.不是，1.是
  final int? isAdvanceUser;

  /// 是否已领取奖励：0.未领取，1.已领取
  final int? isReward;

  AuvAdvanceDialogDataResponse({
    this.rewardVo,
    this.whatsappId,
    this.isAdvanceUser,
    this.isReward,
  });

  factory AuvAdvanceDialogDataResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAdvanceDialogDataResponse();
    return AuvAdvanceDialogDataResponse(
      rewardVo: json['rewardVo'] != null
          ? AuvAdvanceRewardVoResponse.fromJson(json['rewardVo'])
          : null,
      whatsappId: json['whatsappId'],
      isAdvanceUser: json['isAdvanceUser'],
      isReward: json['isReward'],
    );
  }

  /// 是否是高级用户
  bool get isAdvance => isAdvanceUser == 1;

  /// 是否已领取奖励
  bool get hasReward => isReward == 1;

  /// 是否需要显示弹窗
  bool get shouldShowDialog => isAdvance && !hasReward;
}
