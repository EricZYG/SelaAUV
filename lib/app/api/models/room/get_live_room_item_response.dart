/// 直播间列表项模型
library;

/// 直播间列表项数据
class GetLiveRoomItemResponse {
  /// 房间ID
  final int? roomId;

  /// 房间频道号
  final String? channelName;

  /// 房间标题
  final String? title;

  /// 封面地址
  final String? coverUrl;

  /// 游戏编码
  final String? gameCode;

  /// 游戏图标
  final String? gameIcon;

  /// 游戏名称
  final String? gameTitle;

  /// 试看时长
  final int? previewSeconds;

  /// 房主用户ID
  final int? userId;

  /// 房主昵称
  final String? nickname;

  /// 房主头像
  final String? portrait;

  /// 国家
  final int? countryCode;

  /// 国旗链接
  final String? countryPath;

  /// 国家名
  final String? countryTitle;

  /// 房间类型
  /// 1.普通直播间，2.游戏直播间，3.私密直播间
  final int? roomType;

  /// 房间状态
  /// 1.直播中，2.暂停，3.结束
  final int? roomStatus;

  /// 直播间人数
  final int? userCount;

  /// 贡献值
  final int? heatValue;

  /// 是否送过礼物
  /// 0.否，1.是
  final int? giftFlag;

  GetLiveRoomItemResponse({
    this.roomId,
    this.channelName,
    this.title,
    this.coverUrl,
    this.gameCode,
    this.gameIcon,
    this.gameTitle,
    this.previewSeconds,
    this.userId,
    this.nickname,
    this.portrait,
    this.countryCode,
    this.countryPath,
    this.countryTitle,
    this.roomType,
    this.roomStatus,
    this.userCount,
    this.heatValue,
    this.giftFlag,
  });

  factory GetLiveRoomItemResponse.fromJson(Map<String, dynamic> json) {
    return GetLiveRoomItemResponse(
      roomId: json['roomId'],
      channelName: json['channelName'],
      title: json['title'],
      coverUrl: json['coverUrl'],
      gameCode: json['gameCode'],
      gameIcon: json['gameIcon'],
      gameTitle: json['gameTitle'],
      previewSeconds: json['previewSeconds'],
      userId: json['userId'],
      nickname: json['nickname'],
      portrait: json['portrait'],
      countryCode: json['countryCode'],
      countryPath: json['countryPath'],
      countryTitle: json['countryTitle'],
      roomType: json['roomType'],
      roomStatus: json['roomStatus'],
      userCount: json['userCount'],
      heatValue: json['heatValue'],
      giftFlag: json['giftFlag'],
    );
  }
}
