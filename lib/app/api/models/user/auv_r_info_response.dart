/// 不登录获取R信息响应模型
/// 
/// 对应接口: /user/user/getRInfo
/// 
/// 不登录状态下获取用户审核模式等信息
class AuvRInfoResponse {
  /// 是否审核模式
  /// - 0.否
  /// - 1.是
  final int rFlag;

  /// note 未知标志
  final int aFlag;

  /// note  未知标志
  final int tFlag;

  /// 用户昵称
  final String nickname;

  /// H5地址
  final String turl;

  AuvRInfoResponse({
    required this.rFlag,
    required this.aFlag,
    required this.tFlag,
    required this.nickname,
    required this.turl,
  });

  factory AuvRInfoResponse.fromJson(Map<String, dynamic> json) {
    return AuvRInfoResponse(
      rFlag: json['rFlag'] ?? 0,
      aFlag: json['aFlag'] ?? 0,
      tFlag: json['tFlag'] ?? 0,
      nickname: json['nickname'] ?? '',
      turl: json['turl'] ?? '',
    );
  }

  /// 是否审核模式
  bool get isReviewMode => rFlag == 1;
}