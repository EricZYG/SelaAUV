/// 用户编辑资料模型
library;

import 'auv_user_media_info.dart';

/// 用户端编辑资料获取信息接口返回的数据
/// 
/// 字段说明:
/// - userId: 用户ID
/// - username: 用于展示的ID
/// - portrait: 头像
/// - albumUrlList: 相册列表
/// - nickname: 昵称
/// - sex: 性别
class AuvUserUpdateDetailResponse {
  /// 用户ID
  final int? userId;
  
  /// 用于展示的ID
  final String? username;
  
  /// 头像
  final String? portrait;
  
  /// 相册列表
  final List<AuvUserMediaInfoResponse>? albumUrlList;
  
  /// 昵称
  final String? nickname;
  
  /// 性别
  final int? sex;

  AuvUserUpdateDetailResponse({
    this.userId,
    this.username,
    this.portrait,
    this.albumUrlList,
    this.nickname,
    this.sex,
  });

  factory AuvUserUpdateDetailResponse.fromJson(Map<String, dynamic> json) {
    return AuvUserUpdateDetailResponse(
      userId: json['userId'],
      username: json['username'],
      portrait: json['portrait'],
      albumUrlList: (json['albumUrlList'] as List<dynamic>?)
          ?.map((e) => AuvUserMediaInfoResponse.fromJson(e))
          .toList(),
      nickname: json['nickname'],
      sex: json['sex'],
    );
  }
}