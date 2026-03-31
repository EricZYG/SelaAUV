import 'auv_top_user_response.dart';

/// 直播间详细信息
///
/// 获取直播间详情接口返回的完整数据
class AuvLiveRoomFullDetailResponse {
  /// 房间ID
  final int roomId;

  /// 房间频道号
  final String? channelName;

  /// 房间标题
  final String? title;

  /// 房间公告
  final String? notice;

  /// 封面地址
  final String? coverUrl;

  /// 游戏编码
  final String? gameCode;

  /// 游戏房间id
  final int? gameRoomId;

  /// 游戏房间频道号
  final String? gameChannelName;

  /// 游戏图标
  final String? gameIcon;

  /// 游戏名称
  final String? gameTitle;

  /// 游戏高度
  final int? gameHeight;

  /// 游戏房间人数
  final int? gameUserCount;

  /// 试看时长
  final int? previewSeconds;

  /// 房主用户ID
  final int? userId;

  /// 房主昵称
  final String? nickname;

  /// 房主头像
  final String? portrait;

  /// 房间类型（1.普通直播间，2.游戏直播间，3.私密直播间）
  final int? roomType;

  /// 房间状态（1.直播中，2.暂停，3.结束）
  final int? roomStatus;

  /// 礼物收益
  final int? giftCoins;

  /// 礼物数
  final int? giftCount;

  /// 送礼人数
  final int? giftUserCount;

  /// 直播间人数
  final int? userCount;

  /// 观看人数
  final int? watchCount;

  /// 新增粉丝数
  final int? followCount;

  /// 点赞数
  final int? likeCount;

  /// 贡献值
  final int? heatValue;

  /// 房主是否可接收电话（0.否，1.是）
  final int? callFlag;

  /// 直播时长（毫秒数）
  final int? duration;

  /// 是否送过礼物（0.否，1.是）
  final int? giftFlag;

  /// 关注状态（1 未关注，2已关注，3好友）
  final int? followFlag;

  /// top3用户列表
  final List<AuvTopUserResponse>? topUsers;

  AuvLiveRoomFullDetailResponse({
    required this.roomId,
    this.channelName,
    this.title,
    this.notice,
    this.coverUrl,
    this.gameCode,
    this.gameRoomId,
    this.gameChannelName,
    this.gameIcon,
    this.gameTitle,
    this.gameHeight,
    this.gameUserCount,
    this.previewSeconds,
    this.userId,
    this.nickname,
    this.portrait,
    this.roomType,
    this.roomStatus,
    this.giftCoins,
    this.giftCount,
    this.giftUserCount,
    this.userCount,
    this.watchCount,
    this.followCount,
    this.likeCount,
    this.heatValue,
    this.callFlag,
    this.duration,
    this.giftFlag,
    this.followFlag,
    this.topUsers,
  });

  factory AuvLiveRoomFullDetailResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvLiveRoomFullDetailResponse(roomId: 0);
    }
    return AuvLiveRoomFullDetailResponse(
      roomId: json['roomId'] as int? ?? 0,
      channelName: json['channelName'] as String?,
      title: json['title'] as String?,
      notice: json['notice'] as String?,
      coverUrl: json['coverUrl'] as String?,
      gameCode: json['gameCode'] as String?,
      gameRoomId: json['gameRoomId'] as int?,
      gameChannelName: json['gameChannelName'] as String?,
      gameIcon: json['gameIcon'] as String?,
      gameTitle: json['gameTitle'] as String?,
      gameHeight: json['gameHeight'] as int?,
      gameUserCount: json['gameUserCount'] as int?,
      previewSeconds: json['previewSeconds'] as int?,
      userId: json['userId'] as int?,
      nickname: json['nickname'] as String?,
      portrait: json['portrait'] as String?,
      roomType: json['roomType'] as int?,
      roomStatus: json['roomStatus'] as int?,
      giftCoins: json['giftCoins'] as int?,
      giftCount: json['giftCount'] as int?,
      giftUserCount: json['giftUserCount'] as int?,
      userCount: json['userCount'] as int?,
      watchCount: json['watchCount'] as int?,
      followCount: json['followCount'] as int?,
      likeCount: json['likeCount'] as int?,
      heatValue: json['heatValue'] as int?,
      callFlag: json['callFlag'] as int?,
      duration: json['duration'] as int?,
      giftFlag: json['giftFlag'] as int?,
      followFlag: json['followFlag'] as int?,
      topUsers: (json['topUsers'] as List<dynamic>?)
          ?.map((e) => AuvTopUserResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
