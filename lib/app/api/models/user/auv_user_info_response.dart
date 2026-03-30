/// 用户信息模型
/// 
/// 表示用户详细信息
/// 
/// 字段说明:
/// - userId: 用户ID
/// - name: 用户名称
/// - avatar: 头像URL
/// - phone: 手机号
/// - diamonds: 钻石余额
/// - isVip: 是否VIP
/// - vipExpireTime: VIP过期时间
/// - countryCode: 国家编码
class AuvUserInfoResponse {
  /// 用户ID
  final int? userId;
  
  /// 用户名称
  final String? name;
  
  /// 头像URL
  final String? avatar;
  
  /// 手机号
  final String? phone;
  
  /// 钻石余额
  final int? diamonds;
  
  /// 是否VIP
  final bool? isVip;
  
  /// VIP过期时间
  final String? vipExpireTime;
  
  /// 国家编码
  final int? countryCode;

  AuvUserInfoResponse({
    this.userId,
    this.name,
    this.avatar,
    this.phone,
    this.diamonds,
    this.isVip,
    this.vipExpireTime,
    this.countryCode,
  });

  factory AuvUserInfoResponse.fromJson(Map<String, dynamic> json) {
    return AuvUserInfoResponse(
      userId: json['userId'] ?? json['user_id'],
      name: json['name'],
      avatar: json['avatar'],
      phone: json['phone'],
      diamonds: json['diamonds'],
      isVip: json['isVip'] ?? json['is_vip'],
      vipExpireTime: json['vipExpireTime'] ?? json['vip_expire_time'],
      countryCode: json['countryCode'] ?? json['country_code'],
    );
  }
}