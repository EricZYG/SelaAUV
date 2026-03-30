/// 签到奖励模型
/// 
/// 表示签到获得的奖励信息
/// 
/// 字段说明:
/// - id: 奖品ID
/// - name: 奖品名称
/// - icon: 奖品图标
/// - countryCode: 国家编码
/// - rewardType: 奖励类型
/// - rewardValue: 奖励数量
/// - signDay: 签到天数
class AuvSignRewardResponse {
  /// 奖品ID
  final int? id;
  
  /// 奖品名称
  final String name;
  
  /// 奖品图标
  final String? icon;
  
  /// 国家编码
  final int? countryCode;
  
  /// 签到奖励类型
  final int? rewardType;
  
  /// 奖励数量
  final int? rewardValue;
  
  /// 签到天数
  /// 例如: 1表示第一天签到, 7表示第七天签到
  final int? signDay;

  AuvSignRewardResponse({
    this.id,
    required this.name,
    this.icon,
    this.countryCode,
    this.rewardType,
    this.rewardValue,
    this.signDay,
  });

  factory AuvSignRewardResponse.fromJson(Map<String, dynamic> json) {
    return AuvSignRewardResponse(
      id: json['id'],
      name: json['name'] ?? '',
      icon: json['icon'],
      countryCode: json['countryCode'],
      rewardType: json['rewardType'],
      rewardValue: json['rewardValue'],
      signDay: json['signDay'],
    );
  }
}