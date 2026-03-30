/// 道具类型枚举
enum AuvPropType {
  videoCard(1, '视频卡'),
  diamondBoost(2, '钻石加成卡'),
  giftCard(3, '礼物卡'),
  chatCard(4, '聊天卡'),
  matchCard(5, '匹配卡'),
  avatarFrame(6, '头像框');

  final int value;
  final String label;

  const AuvPropType(this.value, this.label);

  static AuvPropType? fromValue(int value) {
    return AuvPropType.values.where((e) => e.value == value).firstOrNull;
  }
}

/// 用户道具模型（我的背包）
class AuvUserPropModel {
  final int userId;
  final AuvPropType propType;
  final int propValue;
  final int propNum;
  final String? name;
  final String? icon;
  final String? animEffectUrl;

  AuvUserPropModel({
    required this.userId,
    required this.propType,
    required this.propValue,
    required this.propNum,
    this.name,
    this.icon,
    this.animEffectUrl,
  });

  factory AuvUserPropModel.fromJson(Map<String, dynamic> json) {
    return AuvUserPropModel(
      userId: json['userId'] ?? 0,
      propType: AuvPropType.fromValue(json['propType'] ?? 0) ?? AuvPropType.videoCard,
      propValue: json['propValue'] ?? 0,
      propNum: json['propNum'] ?? 0,
      name: json['name'],
      icon: json['icon'],
      animEffectUrl: json['animEffectUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'propType': propType.value,
      'propValue': propValue,
      'propNum': propNum,
      'name': name,
      'icon': icon,
      'animEffectUrl': animEffectUrl,
    };
  }

  /// 获取道具类型的显示名称
  String get propTypeLabel => propType.label;

  /// 获取视频卡时长（转换为秒）
  int get videoCardSeconds => propValue ~/ 1000;

  /// 获取视频卡时长（转换为分钟）
  int get videoCardMinutes => propValue ~/ 60000;
}
