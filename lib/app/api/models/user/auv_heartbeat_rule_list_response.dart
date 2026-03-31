/// 心动等级规则列表响应
class AuvHeartbeatRuleListResponse {
  /// 语言
  final String language;

  /// 规则列表
  final List<String> rules;

  /// 总规则说明
  final String masterRule;

  AuvHeartbeatRuleListResponse({
    required this.language,
    required this.rules,
    required this.masterRule,
  });

  factory AuvHeartbeatRuleListResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvHeartbeatRuleListResponse(
        language: '',
        rules: [],
        masterRule: '',
      );
    }
    return AuvHeartbeatRuleListResponse(
      language: json['language'] as String? ?? '',
      rules: (json['rules'] as List<dynamic>?)?.cast<String>() ?? [],
      masterRule: json['masterRule'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'rules': rules,
      'masterRule': masterRule,
    };
  }
}
