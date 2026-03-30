/// 用户详情模型
/// 
/// 用户端-获取我的页面信息接口返回的用户数据
/// 
/// 字段说明:
/// - userId: 用户ID
/// - name: 用户名称
/// - avatar: 头像URL
/// - phone: 手机号(带掩码，如138****8888)
/// - countryCode: 国家编码(如86为中国)
/// - diamonds: 钻石余额
/// - isVip: 是否VIP用户
/// - vipExpireTime: VIP过期时间(如2024-12-31 23:59:59)
class AuvUserDetailResponse {
  /// 用户ID
  final int? userId;
  
  /// 用户名称
  final String? name;
  
  /// 头像URL
  final String? avatar;
  
  /// 手机号(带掩码)
  final String? phone;
  
  /// 国家编码
  final int? countryCode;
  
  /// 钻石余额
  final int? diamonds;
  
  /// 是否VIP用户
  final bool? isVip;
  
  /// VIP过期时间
  final String? vipExpireTime;

  AuvUserDetailResponse({
    this.userId,
    this.name,
    this.avatar,
    this.phone,
    this.countryCode,
    this.diamonds,
    this.isVip,
    this.vipExpireTime,
  });

  factory AuvUserDetailResponse.fromJson(Map<String, dynamic> json) {
    return AuvUserDetailResponse(
      userId: json['userId'],
      name: json['name'],
      avatar: json['avatar'],
      phone: json['phone'],
      countryCode: json['countryCode'],
      diamonds: json['diamonds'],
      isVip: json['isVip'],
      vipExpireTime: json['vipExpireTime'],
    );
  }
}