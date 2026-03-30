/// 直播间观众模型
/// 
/// 表示直播间内的观众信息
/// 
/// 字段说明:
/// - userId: 用户ID
/// - name: 用户名称
/// - avatar: 用户头像
class AuvAudienceResponse {
  /// 用户ID
  final int? userId;
  
  /// 用户名称
  final String? name;
  
  /// 用户头像
  final String? avatar;

  AuvAudienceResponse({
    this.userId,
    this.name,
    this.avatar,
  });

  factory AuvAudienceResponse.fromJson(Map<String, dynamic> json) {
    return AuvAudienceResponse(
      userId: json['userId'],
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}