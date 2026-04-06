import '../enums/auv_prop.dart';

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
///
/// 对应接口: /user/prop/getUserPropVo
///
/// 实际API返回示例:
/// ```json
/// {
///   "userId": 10000389,
///   "propType": 1,
///   "propValue": 500000,
///   "propNum": 1,
///   "name": null,
///   "icon": null,
///   "animEffectUrl": null
/// }
/// ```
///
/// 字段说明:
/// - userId: 用户id
/// - propType: 道具类型，1.视频卡，2.钻石加成卡，3.礼物卡，4.聊天卡，5.匹配卡，6.头像框
/// - propValue: 视频卡时长（毫秒数）/钻石加成/礼物id
/// - propNum: 道具数量
/// - name: 礼物卡 的 礼物名称
/// - icon: 礼物卡 的礼物图标
/// - animEffectUrl: 礼物卡 的礼物特效
class AuvUserPropModel {
  /// 用户id
  final int userId;

  /// 道具类型
  /// 1.视频卡，2.钻石加成卡，3.礼物卡，4.聊天卡，5.匹配卡，6.头像框
  final AuvPropType propType;

  /// 视频卡时长（毫秒数）/钻石加成/礼物id
  final int propValue;

  /// 道具数量
  final int propNum;

  /// 礼物卡 的 礼物名称
  final String? name;

  /// 礼物卡 的礼物图标
  final String? icon;

  /// 礼物卡 的礼物特效
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
