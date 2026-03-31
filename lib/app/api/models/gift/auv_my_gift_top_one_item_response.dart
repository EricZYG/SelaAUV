/// 主播礼物Top1模型
///
/// 主播端获取自己的送礼Top1接口返回的数据
///
/// 字段说明:
/// - gid: 礼物ID
/// - topOneUserId: top1用户id
/// - topOneNickname: top1用户昵称
/// - topOnePortrait: top1用户头像
/// - topOneVipFlag: top1是否vip
class AuvMyGiftTopOneItemResponse {
  /// 礼物ID
  final int? gid;

  /// top1用户id
  final int? topOneUserId;

  /// top1用户昵称
  final String? topOneNickname;

  /// top1用户头像
  final String? topOnePortrait;

  /// top1是否vip
  final bool? topOneVipFlag;

  AuvMyGiftTopOneItemResponse({
    this.gid,
    this.topOneUserId,
    this.topOneNickname,
    this.topOnePortrait,
    this.topOneVipFlag,
  });

  factory AuvMyGiftTopOneItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvMyGiftTopOneItemResponse();
    return AuvMyGiftTopOneItemResponse(
      gid: json['gid'],
      topOneUserId: json['topOneUserId'],
      topOneNickname: json['topOneNickname'],
      topOnePortrait: json['topOnePortrait'],
      topOneVipFlag: json['topOneVipFlag'],
    );
  }
}
