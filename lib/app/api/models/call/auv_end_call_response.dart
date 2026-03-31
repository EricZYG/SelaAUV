/// 挂断通话响应模型
/// 
/// 通话结束后的结算信息
class AuvEndCallResponse {
  /// 频道id
  /// 
  /// 通话频道的唯一标识符
  final int? channelId;
  
  /// 通话时长
  /// 
  /// 本次通话的持续时长，格式为 HH:mm:ss
  final String? callTime;
  
  /// 总通话时长
  /// 
  /// 用户累计的通话时长，格式为 HH:mm:ss
  final String? totalCallTime;
  
  /// 是否使用了匹配卡
  /// 
  /// true表示本次通话使用了匹配卡
  final bool? usedMatchPropFlag;
  
  /// 是否使用了视频卡
  /// 
  /// true表示本次通话使用了视频卡
  final bool? usedCallPropFlag;
  
  /// 通话用户消费/主播收益
  /// 
  /// 本次通话产生的费用（用户视角）或收益（主播视角），小数点后两位
  final double? callAmount;
  
  /// 礼物用户消费/主播收益
  /// 
  /// 本次通话期间的礼物费用（用户视角）或收益（主播视角），小数点后两位
  final double? giftAmount;
  
  /// 用户/主播余额
  /// 
  /// 当前账户剩余的余额，小数点后两位
  final double? remainAmount;
  
  /// 剩余视频卡数量
  /// 
  /// 用户当前剩余的视频卡张数
  final int? callCardCount;

  AuvEndCallResponse({
    this.channelId,
    this.callTime,
    this.totalCallTime,
    this.usedMatchPropFlag,
    this.usedCallPropFlag,
    this.callAmount,
    this.giftAmount,
    this.remainAmount,
    this.callCardCount,
  });

  factory AuvEndCallResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvEndCallResponse();
    return AuvEndCallResponse(
      channelId: json['channelId'],
      callTime: json['callTime'],
      totalCallTime: json['totalCallTime'],
      usedMatchPropFlag: json['usedMatchPropFlag'],
      usedCallPropFlag: json['usedCallPropFlag'],
      callAmount: _parseDouble(json['callAmount']),
      giftAmount: _parseDouble(json['giftAmount']),
      remainAmount: _parseDouble(json['remainAmount']),
      callCardCount: json['callCardCount'],
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  /// 是否使用了道具
  /// 
  /// true表示本次通话使用了视频卡或匹配卡
  bool get usedAnyProp => usedMatchPropFlag == true || usedCallPropFlag == true;

  /// 获取总消费/收益
  /// 
  /// 通话费用和礼物费用的总和
  double get totalAmount => (callAmount ?? 0) + (giftAmount ?? 0);
}
