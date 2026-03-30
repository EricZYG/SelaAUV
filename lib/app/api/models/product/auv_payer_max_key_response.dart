/// payerMax初始化密钥模型
class AuvPayerMaxKeyResponse {
  /// clientKey
  final String? clientKey;

  /// sessionKey
  final String? sessionKey;

  AuvPayerMaxKeyResponse({
    this.clientKey,
    this.sessionKey,
  });

  factory AuvPayerMaxKeyResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvPayerMaxKeyResponse();
    return AuvPayerMaxKeyResponse(
      clientKey: json['clientKey'],
      sessionKey: json['sessionKey'],
    );
  }

  /// 是否有效
  bool get isValid => clientKey != null && sessionKey != null;
}