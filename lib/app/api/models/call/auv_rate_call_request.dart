/// 通话打分请求模型
///
/// 通话结束后给主播打分的请求数据
class AuvRateCallRequest {
  /// 频道id
  ///
  /// 通话频道的唯一标识符
  final int channelId;

  /// 打分分数
  ///
  /// 用户对主播的评分
  final int rateScore;

  /// 打分类型列表
  ///
  /// 评分类型，可传入多个类型
  final List<int> rateTypes;

  AuvRateCallRequest({
    required this.channelId,
    required this.rateScore,
    required this.rateTypes,
  });

  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'rateScore': rateScore,
      'rateTypes': rateTypes,
    };
  }
}
