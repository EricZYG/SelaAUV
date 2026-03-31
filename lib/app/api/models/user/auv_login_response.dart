/// 登录响应数据
/// 
/// 登录成功后返回的用户标识信息
class AuvLoginResponse {
  /// 用户ID
  /// 
  /// 用户的唯一标识符
  final String userId;
  
  /// 用户名
  /// 
  /// 用户的登录名称
  final String username;
  
  /// app渠道
  /// 
  /// 用户来源的应用渠道
  final String? appChannel;
  
  /// 是否待注销
  /// 
  /// 0.否 1.是，表示用户是否申请了账号注销
  final int? deregisterFlag;
  
  /// 注销时间
  /// 
  /// 时间戳，账号计划注销的时间（仅当 deregisterFlag=1 时有效）
  final int? deregisterTime;
  
  /// 请求凭证
  /// 
  /// JWT token，用于后续接口的身份认证
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