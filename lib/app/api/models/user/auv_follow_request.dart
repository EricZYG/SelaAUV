/// 关注用户请求模型
/// 
/// 用于关注指定用户的请求参数
class AuvFollowRequest {
  /// 是否直播间内关注
  /// 
  /// 0.否，1.是
  /// 用于区分关注行为的来源场景
  final int? inLiveRoom;

  AuvFollowRequest({
    this.inLiveRoom,
  });

  Map<String, dynamic> toJson() {
    return {
      if (inLiveRoom != null) 'inLiveRoom': inLiveRoom,
    };
  }
}

/// 关注用户响应模型
/// 
/// 表示关注操作后的关系状态结果
class AuvFollowResponse {
  /// 关注后的关系状态
  /// 
  /// 0.双方都未关注
  /// 1.我未关注&对方已回关
  /// 2.我已关注&对方未回关
  /// 3.好友
  final int? followStatus;

  AuvFollowResponse({
    this.followStatus,
  });

  factory AuvFollowResponse.fromJson(dynamic json) {
    if (json == null) return AuvFollowResponse();
    return AuvFollowResponse(
      followStatus: json is int ? json : int.tryParse(json.toString()),
    );
  }

  /// 获取关系状态描述
  String get followStatusDesc {
    switch (followStatus) {
      case 0:
        return '双方都未关注';
      case 1:
        return '我未关注&对方已回关';
      case 2:
        return '我已关注&对方未回关';
      case 3:
        return '好友';
      default:
        return '未知状态';
    }
  }

  /// 是否为好友关系
  bool get isFriend => followStatus == 3;

  /// 是否已关注对方
  bool get hasFollowed => followStatus == 2 || followStatus == 3;

  /// 是否被对方关注
  bool get isFollowedByTarget => followStatus == 1 || followStatus == 3;
}
