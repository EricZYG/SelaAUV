/// 设置礼物秀请求项模型
///
/// 设置1v1礼物秀接口的请求参数项
///
/// 字段说明:
/// - gid: 礼物ID
/// - actionId: 动作id
class AuvSetGiftShowItem {
  /// 礼物ID
  final int gid;

  /// 动作id
  final int actionId;

  AuvSetGiftShowItem({
    required this.gid,
    required this.actionId,
  });

  Map<String, dynamic> toJson() {
    return {
      'gid': gid,
      'actionId': actionId,
    };
  }
}
