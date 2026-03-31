/// 心动主播列表项
class AuvHeartbeatListItemResponse {
  /// 主播ID
  final int userId;

  /// 昵称
  final String nickname;

  /// 头像
  final String portrait;

  /// 在线状态
  final int isOnline;

  /// 性别，1.男，2.女
  final int sex;

  /// 生日时间戳
  final int birthday;

  /// 国家编码
  final int countryCode;

  /// 国旗链接
  final String countryPath;

  /// 国家名
  final String countryTitle;

  /// 心动值（小数点后两位）
  final double score;

  /// 心动等级
  final int level;

  /// 是否在直播中（0否，1是）
  final int inLiveRoom;

  /// 房间ID
  final int roomId;

  AuvHeartbeatListItemResponse({
    required this.userId,
    required this.nickname,
    required this.portrait,
    required this.isOnline,
    required this.sex,
    required this.birthday,
    required this.countryCode,
    required this.countryPath,
    required this.countryTitle,
    required this.score,
    required this.level,
    required this.inLiveRoom,
    required this.roomId,
  });

  factory AuvHeartbeatListItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatListItemResponse(
        userId: 0,
        nickname: '',
        portrait: '',
        isOnline: 0,
        sex: 0,
        birthday: 0,
        countryCode: 0,
        countryPath: '',
        countryTitle: '',
        score: 0,
        level: 0,
        inLiveRoom: 0,
        roomId: 0,
      );
    }
    return AuvHeartbeatListItemResponse(
      userId: json['userId'] as int? ?? 0,
      nickname: json['nickname'] as String? ?? '',
      portrait: json['portrait'] as String? ?? '',
      isOnline: json['isOnline'] as int? ?? 0,
      sex: json['sex'] as int? ?? 0,
      birthday: json['birthday'] as int? ?? 0,
      countryCode: json['countryCode'] as int? ?? 0,
      countryPath: json['countryPath'] as String? ?? '',
      countryTitle: json['countryTitle'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0,
      level: json['level'] as int? ?? 0,
      inLiveRoom: json['inLiveRoom'] as int? ?? 0,
      roomId: json['roomId'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'nickname': nickname,
      'portrait': portrait,
      'isOnline': isOnline,
      'sex': sex,
      'birthday': birthday,
      'countryCode': countryCode,
      'countryPath': countryPath,
      'countryTitle': countryTitle,
      'score': score,
      'level': level,
      'inLiveRoom': inLiveRoom,
      'roomId': roomId,
    };
  }
}
