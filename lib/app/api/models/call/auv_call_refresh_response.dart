/// 通话续费响应模型
/// 
/// 用户通话续费接口返回的数据
/// 
/// 字段说明:
/// - rtcToken: RTC通话令牌
class AuvCallRefreshResponse {
  /// RTC通话令牌
  final String? rtcToken;

  AuvCallRefreshResponse({this.rtcToken});

  factory AuvCallRefreshResponse.fromJson(Map<String, dynamic> json) {
    return AuvCallRefreshResponse(
      rtcToken: json['rtcToken'],
    );
  }
}