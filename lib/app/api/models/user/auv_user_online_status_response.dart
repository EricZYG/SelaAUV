/// 用户在线状态模型
///
/// 获取用户是否在线接口返回的数据
///
/// 字段说明:
/// - userId: 用户ID
/// - isOnline: 是否在线，0.离线，1.在线，2.忙线
/// - inScreen: 是否在屏幕中，0.否，1.是
class AuvUserOnlineStatusResponse {
  /// 用户ID
  final int? userId;

  /// 是否在线，0.离线，1.在线，2.忙线
  final int? isOnline;

  /// 是否在屏幕中，0.否，1.是
  final int? inScreen;

  AuvUserOnlineStatusResponse({
    this.userId,
    this.isOnline,
    this.inScreen,
  });

  factory AuvUserOnlineStatusResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvUserOnlineStatusResponse();
    return AuvUserOnlineStatusResponse(
      userId: json['userId'],
      isOnline: json['isOnline'],
      inScreen: json['inScreen'],
    );
  }

  /// 是否在线
  bool get isUserOnline => isOnline == 1;

  /// 是否忙线
  bool get isBusy => isOnline == 2;

  /// 是否离线
  bool get isOffline => isOnline == 0;

  /// 是否在屏幕中
  bool get isInScreen => inScreen == 1;

  /// 获取在线状态描述
  String get onlineStatusDesc {
    switch (isOnline) {
      case 0:
        return '离线';
      case 1:
        return '在线';
      case 2:
        return '忙线';
      default:
        return '未知';
    }
  }

  /// 获取在屏状态描述
  String get inScreenDesc => isInScreen ? '在屏幕中' : '不在屏幕中';
}