/// 登录响应数据
/// 
/// 登录成功后返回的用户标识信息
/// 
/// 字段说明:
/// - userId: 用户ID
/// - username: 用户名
/// - appChannel: app渠道
/// - deregisterFlag: 是否待注销（0.否 1.是）
/// - deregisterTime: 注销时间（时间戳）
/// - authorization: 请求凭证（JWT token）
class AuvLoginResponse {
  /// 用户ID
  final String userId;
  
  /// 用户名
  final String username;
  
  /// app渠道
  final String? appChannel;
  
  /// 是否待注销（0.否 1.是）
  final int? deregisterFlag;
  
  /// 注销时间（时间戳）
  final int? deregisterTime;
  
  /// 请求凭证（JWT token）
  final String? authorization;

  AuvLoginResponse({
    required this.userId,
    required this.username,
    this.appChannel,
    this.deregisterFlag,
    this.deregisterTime,
    this.authorization,
  });

  factory AuvLoginResponse.fromJson(Map<String, dynamic> json) {
    return AuvLoginResponse(
      userId: (json['userId'] ?? json['user_id'] ?? 0).toString(),
      username: json['username'] ?? '',
      appChannel: json['appChannel'],
      deregisterFlag: json['deregisterFlag'],
      deregisterTime: json['deregisterTime'],
      authorization: json['authorization'],
    );
  }
}