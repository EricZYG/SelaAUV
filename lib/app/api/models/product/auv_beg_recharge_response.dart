/// 主播索要充值响应模型
class AuvBegRechargeResponse {
  /// 索要文案
  final String? content;

  AuvBegRechargeResponse({this.content});

  factory AuvBegRechargeResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvBegRechargeResponse();
    return AuvBegRechargeResponse(
      content: json['content'],
    );
  }
}