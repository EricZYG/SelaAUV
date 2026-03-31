/// 通话续费响应模型
/// 
/// 用户通话续费接口返回的数据
class AuvCallRefreshResponse {
  /// 声网token
  /// 
  /// 用于加入声网实时通话的认证令牌，续费后生成新的token
  final String? rtcToken;

  AuvCallRefreshResponse({this.rtcToken});

  factory AuvCallRefreshResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCallRefreshResponse();
    return AuvCallRefreshResponse(
      rtcToken: json['rtcToken'],
    );
  }
}