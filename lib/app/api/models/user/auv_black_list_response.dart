/// 黑名单列表项响应模型
/// 
/// 表示黑名单中的单个用户信息
class AuvBlackListItemResponse {
  /// 用户id
  final int? userId;

  /// 用户昵称
  final String? nickname;

  /// 头像相对地址
  final String? portrait;

  /// 身份
  final int? userAuth;

  /// 性别
  /// 
  /// 1.男，2.女
  final int? sex;

  /// 生日时间戳
  final int? birthday;

  /// 国家编码
  final int? countryCode;

  /// 国旗链接
  final String? countryPath;

  /// 国家名
  final String? countryTitle;

  /// 创建时间（拉黑时间）
  final int? createdAt;

  AuvBlackListItemResponse({
    this.userId,
    this.nickname,
    this.portrait,
    this.userAuth,
    this.sex,
    this.birthday,
    this.countryCode,
    this.countryPath,
    this.countryTitle,
    this.createdAt,
  });

  factory AuvBlackListItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvBlackListItemResponse();
    return AuvBlackListItemResponse(
      userId: json['userId'],
      nickname: json['nickname'],
      portrait: json['portrait'],
      userAuth: json['userAuth'],
      sex: json['sex'],
      birthday: json['birthday'],
      countryCode: json['countryCode'],
      countryPath: json['countryPath'],
      countryTitle: json['countryTitle'],
      createdAt: json['createdAt'],
    );
  }

  /// 获取拉黑时间
  DateTime? get blacklistedAt {
    if (createdAt == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(createdAt!);
  }
}
