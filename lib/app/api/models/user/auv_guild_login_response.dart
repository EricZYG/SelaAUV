/// 公会登录响应数据
///
/// 根据不同的响应码，返回不同类型的数据：
/// - code=0: 成功，返回JWT token（authorization）
/// - code=1031: 不能再用邀请码登录，返回账号id
class AuvGuildLoginResponse {
  /// 请求凭证（JWT token）- 成功时返回
  final String? authorization;

  /// 账号ID - code=1031时返回，表示该账号已设置密码，需要用账号登录
  final String? accountId;

  /// 是否成功
  final bool isSuccess;

  /// 响应类型
  final AuvGuildLoginType type;

  AuvGuildLoginResponse({
    this.authorization,
    this.accountId,
    required this.isSuccess,
    required this.type,
  });

  /// 解析成功响应（JWT token）
  factory AuvGuildLoginResponse.success(String authorization) {
    return AuvGuildLoginResponse(
      authorization: authorization,
      isSuccess: true,
      type: AuvGuildLoginType.token,
    );
  }

  /// 解析失败响应（账号已设置密码）
  factory AuvGuildLoginResponse.accountHasPassword(String accountId) {
    return AuvGuildLoginResponse(
      accountId: accountId,
      isSuccess: false,
      type: AuvGuildLoginType.accountHasPassword,
    );
  }

  /// 根据响应数据创建实例
  /// [data] - 响应数据（可能是String token或accountId）
  /// [isSuccess] - 是否成功
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
