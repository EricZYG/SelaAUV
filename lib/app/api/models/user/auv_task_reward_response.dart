/// 任务奖励详情模型
///
/// 任务领取接口返回的奖励详情
library;

/// 字段说明:
/// - callCardNum: 视频卡数量
/// - chatCardNum: 聊天卡数量
/// - couponNum: 优惠券数量
/// - diamondNum: 钻石数量
/// - matchCardNum: 匹配卡数量
class AuvTaskRewardVoResponse {
  /// 视频卡数量
  final int? callCardNum;

  /// 聊天卡数量
  final int? chatCardNum;

  /// 优惠券数量
  final int? couponNum;

  /// 钻石数量
  final int? diamondNum;

  /// 匹配卡数量
  final int? matchCardNum;

  AuvTaskRewardVoResponse({
    this.callCardNum,
    this.chatCardNum,
    this.couponNum,
    this.diamondNum,
    this.matchCardNum,
  });

  factory AuvTaskRewardVoResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvTaskRewardVoResponse();
    return AuvTaskRewardVoResponse(
      callCardNum: json['callCardNum'],
      chatCardNum: json['chatCardNum'],
      couponNum: json['couponNum'],
      diamondNum: json['diamondNum'],
      matchCardNum: json['matchCardNum'],
    );
  }
}

/// 任务奖励JSON项模型
///
/// 任务领取接口返回的奖励JSON列表项
/// 字段说明:
/// - matchCardNum: 匹配卡数量
/// - numStr: 数量字符串
/// - chatCardNum: 聊天卡数量
/// - rewardType: 奖励类型
/// - num: 数量
/// - callCardNum: 视频卡数量
class AuvTaskRewardJsonItemResponse {
  /// 匹配卡数量
  final int? matchCardNum;

  /// 数量字符串
  final String? numStr;

  /// 聊天卡数量
  final int? chatCardNum;

  /// 奖励类型
  final int? rewardType;

  /// 数量
  final String? num;

  /// 视频卡数量
  final int? callCardNum;

  AuvTaskRewardJsonItemResponse({
    this.matchCardNum,
    this.numStr,
    this.chatCardNum,
    this.rewardType,
    this.num,
    this.callCardNum,
  });

  factory AuvTaskRewardJsonItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvTaskRewardJsonItemResponse();
    return AuvTaskRewardJsonItemResponse(
      matchCardNum: json['matchCardNum'],
      numStr: json['numStr'],
      chatCardNum: json['chatCardNum'],
      rewardType: json['rewardType'],
      num: json['num'],
      callCardNum: json['callCardNum'],
    );
  }
}

/// 任务领取响应模型
///
/// 任务领取接口返回的数据

/// 字段说明:
/// - rewardJson: 奖励JSON列表
/// - rewardVo: 奖励详情
/// - taskUnique: 任务唯一标识
class AuvTaskDrawResponse {
  /// 奖励JSON列表
  final List<AuvTaskRewardJsonItemResponse>? rewardJson;

  /// 奖励详情
  final AuvTaskRewardVoResponse? rewardVo;

  /// 任务唯一标识
  final String? taskUnique;

  AuvTaskDrawResponse({
    this.rewardJson,
    this.rewardVo,
    this.taskUnique,
  });

  factory AuvTaskDrawResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvTaskDrawResponse();
    return AuvTaskDrawResponse(
      rewardJson: json['rewardJson'] != null
          ? (json['rewardJson'] as List)
              .map((e) => AuvTaskRewardJsonItemResponse.fromJson(e))
              .toList()
          : null,
      rewardVo: json['rewardVo'] != null
          ? AuvTaskRewardVoResponse.fromJson(json['rewardVo'])
          : null,
      taskUnique: json['taskUnique'],
    );
  }
}
