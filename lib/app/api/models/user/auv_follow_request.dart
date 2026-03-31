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
