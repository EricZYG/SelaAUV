/// 修改个人信息请求模型
library;

import 'auv_user_media_info.dart';

/// 修改个人信息接口的请求参数
class AuvUpdateUserDetailRequest {
  /// 用户ID
  final int? userId;
  
  /// 头像
  final String? portrait;
  
  /// 相册列表
  final List<AuvUserMediaInfoResponse>? albumUrlList;
  
  /// 删除相册标志 1删除相册
  final int? removeAlbumFlag;
  
  /// 昵称
  final String? nickname;
  
  /// 用于展示的ID
  final String? username;
  
  /// 性别
  final int? sex;
  
  /// 出生日期
  final int? birthday;
  
  /// 语言
  final String? language;
  
  /// 多语言 en,en
  final String? manyLanguage;
  
  /// 删除多语言标志 1删除多语言
  final int? removeManyLanguage;
  
  /// 标签列表
  final List<String>? tagList;
  
  /// 标签ID列表
  final List<int>? tagIdList;
  
  /// 个人签名
  final String? signature;
  
  /// 勿扰 0关闭 1开启
  final int? disturbFlag;
  
  /// 视频接听标识 0关闭 1开启
  final int? workFlag;
  
  /// 显示地理位置 0关闭 1开启
  final int? showCountry;
  
  /// 悬浮窗 0关闭 1开启
  final int? floatFlag;
  
  /// AIG开关 0关闭 1开启
  final int? aigFlag;
  
  /// AI尺度 0关闭 1正常尺度 2大尺度
  final int? aiScale;
  
  /// 是否自动接收好友请求 0否 1是
  final int? autoFriend;
  
  /// 主播每分钟通话金币数
  final double? callPriceCoins;
  
  /// 是否展示送出礼物 0关闭 1开启
  final int? showSendGift;
  
  /// 主播每日在线开始时间 格式HH:mm
  final String? onlineBegin;
  
  /// 主播每日在线结束时间 格式HH:mm
  final String? onlineEnd;
  
  /// 是否展示新手引导 0不展示 1展示
  final int? showGuild;
  
  /// 推送开关 0关闭 1开启
  final int? notifyFlag;
  
  /// 敏感提示开关 0关闭 1开启
  final int? sexyTipFlag;
  
  /// 敏感动态展示开关 0关闭 1开启
  final int? sexyMomentFlag;
  
  /// 是否成年
  final int? isAdult;

  AuvUpdateUserDetailRequest({
    this.userId,
    this.portrait,
    this.albumUrlList,
    this.removeAlbumFlag,
    this.nickname,
    this.username,
    this.sex,
    this.birthday,
    this.language,
    this.manyLanguage,
    this.removeManyLanguage,
    this.tagList,
    this.tagIdList,
    this.signature,
    this.disturbFlag,
    this.workFlag,
    this.showCountry,
    this.floatFlag,
    this.aigFlag,
    this.aiScale,
    this.autoFriend,
    this.callPriceCoins,
    this.showSendGift,
    this.onlineBegin,
    this.onlineEnd,
    this.showGuild,
    this.notifyFlag,
    this.sexyTipFlag,
    this.sexyMomentFlag,
    this.isAdult,
  });

  Map<String, dynamic> toJson() {
    return {
      if (userId != null) 'userId': userId,
      if (portrait != null) 'portrait': portrait,
      if (albumUrlList != null) 'albumUrlList': albumUrlList!.map((e) => e.toJson()).toList(),
      if (removeAlbumFlag != null) 'removeAlbumFlag': removeAlbumFlag,
      if (nickname != null) 'nickname': nickname,
      if (username != null) 'username': username,
      if (sex != null) 'sex': sex,
      if (birthday != null) 'birthday': birthday,
      if (language != null) 'language': language,
      if (manyLanguage != null) 'manyLanguage': manyLanguage,
      if (removeManyLanguage != null) 'removeManyLanguage': removeManyLanguage,
      if (tagList != null) 'tagList': tagList,
      if (tagIdList != null) 'tagIdList': tagIdList,
      if (signature != null) 'signature': signature,
      if (disturbFlag != null) 'disturbFlag': disturbFlag,
      if (workFlag != null) 'workFlag': workFlag,
      if (showCountry != null) 'showCountry': showCountry,
      if (floatFlag != null) 'floatFlag': floatFlag,
      if (aigFlag != null) 'aigFlag': aigFlag,
      if (aiScale != null) 'aiScale': aiScale,
      if (autoFriend != null) 'autoFriend': autoFriend,
      if (callPriceCoins != null) 'callPriceCoins': callPriceCoins,
      if (showSendGift != null) 'showSendGift': showSendGift,
      if (onlineBegin != null) 'onlineBegin': onlineBegin,
      if (onlineEnd != null) 'onlineEnd': onlineEnd,
      if (showGuild != null) 'showGuild': showGuild,
      if (notifyFlag != null) 'notifyFlag': notifyFlag,
      if (sexyTipFlag != null) 'sexyTipFlag': sexyTipFlag,
      if (sexyMomentFlag != null) 'sexyMomentFlag': sexyMomentFlag,
      if (isAdult != null) 'isAdult': isAdult,
    };
  }
}
