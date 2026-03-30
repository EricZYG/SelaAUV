/// 敏感词模型
///
/// 表示敏感词信息
///
/// 字段说明:
/// - id: 敏感词id
/// - type: 敏感词类型，1.不能发送(引流词)，2.脱敏发送(私聊敏感词)，3.不能发送并提示(公聊敏感词)
/// - mode: 敏感词模式，1.单个词，2.范围
/// - words: 敏感词/开始范围敏感词
/// - wordsStop: 结束范围敏感词
class AuvSensitiveWordResponse {
  /// 敏感词id
  final int? id;

  /// 敏感词类型
  /// 1.不能发送(引流词)
  /// 2.脱敏发送(私聊敏感词)
  /// 3.不能发送并提示(公聊敏感词)
  final int? type;

  /// 敏感词模式
  /// 1.单个词
  /// 2.范围
  final int? mode;

  /// 敏感词/开始范围敏感词
  final String? words;

  /// 结束范围敏感词
  final String? wordsStop;

  AuvSensitiveWordResponse({
    this.id,
    this.type,
    this.mode,
    this.words,
    this.wordsStop,
  });

  factory AuvSensitiveWordResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvSensitiveWordResponse();
    return AuvSensitiveWordResponse(
      id: json['id'],
      type: json['type'],
      mode: json['mode'],
      words: json['words'],
      wordsStop: json['wordsStop'],
    );
  }

  /// 获取敏感词类型描述
  String get typeDesc {
    switch (type) {
      case 1:
        return '引流词';
      case 2:
        return '私聊敏感词';
      case 3:
        return '公聊敏感词';
      default:
        return '未知';
    }
  }

  /// 获取敏感词模式描述
  String get modeDesc {
    switch (mode) {
      case 1:
        return '单个词';
      case 2:
        return '范围';
      default:
        return '未知';
    }
  }

  /// 是否是引流词
  bool get isDrainageWord => type == 1;

  /// 是否是私聊敏感词
  bool get isPrivateChatSensitive => type == 2;

  /// 是否是公聊敏感词
  bool get isPublicChatSensitive => type == 3;
}