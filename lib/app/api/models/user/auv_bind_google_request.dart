/// 绑定谷歌账号请求模型
/// 
/// 用于绑定Google账号到当前登录用户
class AuvBindGoogleRequest {
  /// 谷歌openId（必填）
  /// 
  /// Google账号的唯一标识符
  final String id;
  
  /// 昵称（可选）
  /// 
  /// 用户的显示昵称
  final String? nickname;
  
  /// 头像（可选）
  /// 
  /// 用户头像URL地址
  final String? cover;
  
  /// 登录token（可选）
  /// 
  /// Google登录时获取的token
  final String? token;
  
  /// 邮箱（可选）
  /// 
  /// Google账号关联的邮箱地址
  final String? email;

  AuvBindGoogleRequest({
    required this.id,
    this.nickname,
    this.cover,
    this.token,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      if (nickname != null) 'nickname': nickname,
      if (cover != null) 'cover': cover,
      if (token != null) 'token': token,
      if (email != null) 'email': email,
    };
  }
}