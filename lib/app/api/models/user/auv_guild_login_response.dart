/// 公会登录响应数据
///
/// 根据不同的响应码，返回不同类型的数据：
/// - code=0: 成功，返回JWT token（authorization）
/// - code=1031: 不能再用邀请码登录，返回账号id
class AuvGuildLoginResponse {
  /// 请求凭证
  /// 
  /// 成功登录时返回的JWT token，用于后续接口的身份认证
  final String? authorization;

  /// 账号ID
  /// 
  /// code=1031时返回，表示该账号已设置密码，需要用账号登录
  final String? accountId;

  /// 是否成功
  /// 
  /// true表示登录成功（code=0），false表示登录失败（code=1031）
  final bool isSuccess;

  /// 响应类型
  /// 
  /// 区分成功返回token还是失败返回账号ID
  final AuvGuildLoginType type;

  AuvGuildLoginResponse({
    this.authorization,
    this.accountId,
    required this.isSuccess,
    required this.type,
  });

  /// 创建成功响应
  /// 
  /// [authorization] JWT token
  factory AuvGuildLoginResponse.success(String authorization) {
    return AuvGuildLoginResponse(
      authorization: authorization,
      isSuccess: true,
      type: AuvGuildLoginType.token,
    );
  }

  /// 创建失败响应（账号已设置密码）
  /// 
  /// [accountId] 账号ID，提示用户改用账号登录
  factory AuvGuildLoginResponse.accountHasPassword(String accountId) {
    return AuvGuildLoginResponse(
      accountId: accountId,
      isSuccess: false,
      type: AuvGuildLoginType.accountHasPassword,
    );
  }

  /// 根据响应数据创建实例
  /// 
  /// [data] 响应数据（可能是String token或accountId）
  /// [isSuccess] 是否成功
  factory AuvGuildLoginResponse.fromData(dynamic data, bool isSuccess) {
    if (isSuccess) {
      return AuvGuildLoginResponse.success(data.toString());
    } else {
      return AuvGuildLoginResponse.accountHasPassword(data.toString());
    }
  }
}

/// 公会登录响应类型
enum AuvGuildLoginType {
  /// 成功返回JWT token
  token,
  
  /// 账号已设置密码，需要改用账号登录
  accountHasPassword,
}
