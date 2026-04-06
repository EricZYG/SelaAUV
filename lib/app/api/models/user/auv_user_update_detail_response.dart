/// 用户编辑资料模型
library;

import 'auv_user_media_info.dart';

/// 用户端编辑资料获取信息接口返回的数据
///
/// 对应接口: /user/user/getUserUpdateDetailVo
///
/// 字段说明:
/// - userId: 用户ID
/// - username: 用于展示的ID
/// - portrait: 头像
/// - albumUrlList: 相册列表
/// - nickname: 昵称
/// - sex: 性别 1男 2女
/// - birthday: 出生日期
/// - language: 语言
/// - manyLanguage: 多语言 en,en
/// - languageName: 语言显示名
/// - manyLanguageName: 多语言显示名
/// - tagList: 标签列表
/// - signature: 个人签名
/// - faceFlag: 是否真人
/// - notifyFlag: 推送开关
class AuvUserUpdateDetailResponse {
  /// 用户ID
  final int userId;

  /// 用于展示的ID
  final String username;

  /// 头像
  final String portrait;

  /// 相册列表
  final List<AuvUserMediaInfoResponse> albumUrlList;

  /// 昵称
  final String nickname;

  /// 性别 1男 2女
  final int sex;

  /// 出生日期（毫秒时间戳）
  final int birthday;

  /// 语言
  final String language;

  /// 多语言 en,en
  final String manyLanguage;

  /// 语言显示名
  final String languageName;

  /// 多语言显示名
  final String manyLanguageName;

  /// 标签列表
  final List<String> tagList;

  /// 个人签名
  final String signature;

  /// 是否真人 false.否，true.是
  final bool faceFlag;

  /// 是否推送开关，0.关闭，1.开启
  final int notifyFlag;

  /// 【遗漏】在线开始时间
  final String? onlineBegin;

  /// 【遗漏】在线结束时间
  final String? onlineEnd;

  /// 【遗漏】是否显示送礼入口，1显示 0不显示
  final int showSendGift;

  /// 【遗漏】相册数量
  final int albumCount;

  /// 【遗漏】头像状态，1正常 0异常
  final int portraitStatus;

  /// 【遗漏】昵称状态，1正常 0异常
  final int nicknameStatus;

  AuvUserUpdateDetailResponse({
    required this.userId,
    required this.username,
    required this.portrait,
    required this.albumUrlList,
    required this.nickname,
    required this.sex,
    required this.birthday,
    required this.language,
    required this.manyLanguage,
    required this.languageName,
    required this.manyLanguageName,
    required this.tagList,
    required this.signature,
    required this.faceFlag,
    required this.notifyFlag,
    this.onlineBegin,
    this.onlineEnd,
    this.showSendGift = 1,
    this.albumCount = 0,
    this.portraitStatus = 1,
    this.nicknameStatus = 0,
  });

  factory AuvUserUpdateDetailResponse.fromJson(Map<String, dynamic> json) {
    return AuvUserUpdateDetailResponse(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      portrait: json['portrait'] ?? '',
      albumUrlList: (json['albumUrlList'] as List?)
          ?.map((e) => AuvUserMediaInfoResponse.fromJson(e))
          .toList() ?? [],
      nickname: json['nickname'] ?? '',
      sex: json['sex'] ?? 0,
      birthday: json['birthday'] ?? 0,
      language: json['language'] ?? '',
      manyLanguage: json['manyLanguage'] ?? '',
      languageName: json['languageName'] ?? '',
      manyLanguageName: json['manyLanguageName'] ?? '',
      tagList: List<String>.from(json['tagList'] ?? []),
      signature: json['signature'] ?? '',
      faceFlag: json['faceFlag'] ?? false,
      notifyFlag: json['notifyFlag'] ?? 0,
      onlineBegin: json['onlineBegin'],
      onlineEnd: json['onlineEnd'],
      showSendGift: json['showSendGift'] ?? 1,
      albumCount: json['albumCount'] ?? 0,
      portraitStatus: json['portraitStatus'] ?? 1,
      nicknameStatus: json['nicknameStatus'] ?? 0,
    );
  }

  /// 是否男
  bool get isMale => sex == 1;

  /// 是否女
  bool get isFemale => sex == 2;

  /// 是否真人
  bool get isRealPerson => faceFlag;

  /// 是否推送开启
  bool get isNotifyEnabled => notifyFlag == 1;

  /// 获取生日日期
  DateTime? get birthdayDateTime {
    if (birthday <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(birthday);
  }

  /// 获取语言列表
  List<String> get languageList {
    if (manyLanguage.isEmpty) return [];
    return manyLanguage.split(',').where((s) => s.isNotEmpty).toList();
  }

  /// 是否显示送礼入口
  bool get canSendGift => showSendGift == 1;

  /// 头像是否正常
  bool get isPortraitNormal => portraitStatus == 1;

  /// 昵称是否正常
  bool get isNicknameNormal => nicknameStatus == 1;
}
