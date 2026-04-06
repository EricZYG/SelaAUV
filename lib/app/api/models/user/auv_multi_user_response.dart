/// 多账号用户信息模型
///
/// 对应接口: GET /user/user/getMultiUser
library;

import 'auv_login_response.dart';

/// 获取多账号用户接口返回的数据
///
/// 【接口说明】
/// 存在多个账号时返回余额最多和最新登录的一个账号，与游客登录逻辑一致
///
/// 【响应字段】
/// - userId: 用户ID
/// - username: 用于显示的UID
/// - nickname: 用户昵称
/// - portrait: 头像
/// - email: 邮箱
/// - sex: 性别，1.男，2.女
/// - oauthTypes: 登录方式列表，0.谷歌登录，4.账号密码登录
class AuvMultiUserResponse {
  /// 用户ID
  final int userId;

  /// 用于显示的UID
  final String username;

  /// 用户昵称
  final String nickname;

  /// 头像
  final String portrait;

  /// 邮箱
  final String email;

  /// 性别，1.男，2.女
  final int sex;

  /// 登录方式列表
  /// 0.谷歌登录
  /// 4.账号密码登录
  final List<int> oauthTypes;

  AuvMultiUserResponse({
    required this.userId,
    required this.username,
    required this.nickname,
    required this.portrait,
    required this.email,
    required this.sex,
    required this.oauthTypes,
  });

  factory AuvMultiUserResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvMultiUserResponse(
        userId: 0,
        username: '',
        nickname: '',
        portrait: '',
        email: '',
        sex: 0,
        oauthTypes: [],
      );
    }
    return AuvMultiUserResponse(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      email: json['email'] ?? '',
      sex: json['sex'] ?? 0,
      oauthTypes: (json['oauthTypes'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          [],
    );
  }

  /// 是否为男性
  bool get isMale => sex == 1;

  /// 是否为女性
  bool get isFemale => sex == 2;

  /// 是否使用谷歌登录
  bool get isGoogleLogin => oauthTypes.contains(0);

  /// 是否使用账号密码登录
  bool get isAccountLogin => oauthTypes.contains(4);

  /// 性别描述
  String get sexDesc {
    switch (sex) {
      case 1:
        return '男';
      case 2:
        return '女';
      default:
        return '未知';
    }
  }

  /// 登录方式描述列表
  List<String> get oauthTypeDescs {
    return oauthTypes.map((type) {
      switch (type) {
        case 0:
          return '谷歌登录';
        case 4:
          return '账号密码登录';
        default:
          return '其他($type)';
      }
    }).toList();
  }
}
