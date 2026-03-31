/// 主播礼物墙模型
///
/// 主播端获取自己收到的礼物墙接口返回的数据
///
/// 字段说明:
/// - gid: 礼物ID
/// - name: 礼物名称
/// - diamonds: 钻石价格
/// - icon: 礼物图标
/// - receiveNum: 收到的总数
/// - topOneUserId: top1用户id
/// - topOneNickname: top1用户昵称
/// - topOnePortrait: top1用户头像
/// - topOneVipFlag: top1用户是否vip
/// - currDiffNum: 当前用户距离top1用户相差的送礼数量
class AuvMyGiftWallItemResponse {
  /// 礼物ID
  final int? gid;

  /// 礼物名称
  final String? name;

  /// 钻石价格
  final int? diamonds;

  /// 礼物图标
  final String? icon;

  /// 收到的总数
  final int? receiveNum;

  /// top1用户id
  final int? topOneUserId;

  /// top1用户昵称
  final String? topOneNickname;

  /// top1用户头像
  final String? topOnePortrait;

  /// top1用户是否vip
  final bool? topOneVipFlag;

  /// 当前用户距离top1用户相差的送礼数量
  final int? currDiffNum;

  AuvMyGiftWallItemResponse({
    this.gid,
    this.name,
    this.diamonds,
    this.icon,
    this.receiveNum,
    this.topOneUserId,
    this.topOneNickname,
    this.topOnePortrait,
    this.topOneVipFlag,
    this.currDiffNum,
  });

  factory AuvMyGiftWallItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvMyGiftWallItemResponse();
    return AuvMyGiftWallItemResponse(
      gid: json['gid'],
      name: json['name'],
      diamonds: json['diamonds'],
      icon: json['icon'],
      receiveNum: json['receiveNum'],
      topOneUserId: json['topOneUserId'],
      topOneNickname: json['topOneNickname'],
      topOnePortrait: json['topOnePortrait'],
      topOneVipFlag: json['topOneVipFlag'],
      currDiffNum: json['currDiffNum'],
    );
  }
}
