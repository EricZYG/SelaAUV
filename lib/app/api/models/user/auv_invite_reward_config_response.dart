/// 邀请奖励配置响应模型
/// 
/// 对应接口: /user/user/queryInviteRewardConfig
/// 
/// 获取邀请奖励的配置列表
class AuvInviteRewardConfigResponse {
  /// 国家编码
  final int countryCode;

  /// 国家名称
  final String countryName;

  /// 国旗地址
  final String countryPath;

  /// 被邀请女用户认证奖励（金币）
  final int femaleAuthCoins;

  /// 被邀请女用户收入达标奖励（金币）
  final int femaleIncomeCoins;

  AuvInviteRewardConfigResponse({
    required this.countryCode,
    required this.countryName,
    required this.countryPath,
    required this.femaleAuthCoins,
    required this.femaleIncomeCoins,
  });

  factory AuvInviteRewardConfigResponse.fromJson(Map<String, dynamic> json) {
    return AuvInviteRewardConfigResponse(
      countryCode: json['countryCode'] ?? 0,
      countryName: json['countryName'] ?? '',
      countryPath: json['countryPath'] ?? '',
      femaleAuthCoins: json['femaleAuthCoins'] ?? 0,
      femaleIncomeCoins: json['femaleIncomeCoins'] ?? 0,
    );
  }
}
