import 'dart:convert';

/// 应用配置 - 聊天翻译配置模型
///
/// chatTranslateConfig 字段的JSON解析结果
///
/// 字段说明:
/// - state: 翻译状态，1=开启
/// - isGetRequest: 是否GET请求
/// - headers: 请求头配置
/// - baseUrl: 翻译服务基础URL
/// - path: 翻译接口路径
/// - data: 请求数据模板
/// - parseContentStart: 解析内容起始标记
/// - parseContentEnd: 解析内容结束标记
/// - parseLanguageCodeStart: 解析语言代码起始标记
/// - parseLanguageCodeEnd: 解析语言代码结束标记
class AuvAppConfigChatTranslateResponse {
  /// 翻译状态，1=开启
  final int? state;

  /// 是否GET请求
  final bool? isGetRequest;

  /// 请求头配置（Map）
  final Map<String, String>? headers;

  /// 翻译服务基础URL
  final String? baseUrl;

  /// 翻译接口路径
  final String? path;

  /// 请求数据模板
  final String? data;

  /// 解析内容起始标记
  final String? parseContentStart;

  /// 解析内容结束标记
  final String? parseContentEnd;

  /// 解析语言代码起始标记
  final String? parseLanguageCodeStart;

  /// 解析语言代码结束标记
  final String? parseLanguageCodeEnd;

  AuvAppConfigChatTranslateResponse({
    this.state,
    this.isGetRequest,
    this.headers,
    this.baseUrl,
    this.path,
    this.data,
    this.parseContentStart,
    this.parseContentEnd,
    this.parseLanguageCodeStart,
    this.parseLanguageCodeEnd,
  });

  factory AuvAppConfigChatTranslateResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAppConfigChatTranslateResponse();
    return AuvAppConfigChatTranslateResponse(
      state: json['state'],
      isGetRequest: json['isGetRequest'],
      headers: json['headers'] != null
          ? Map<String, String>.from(json['headers'] as Map)
          : null,
      baseUrl: json['baseUrl'],
      path: json['path'],
      data: json['data'],
      parseContentStart: json['parseContentStart'],
      parseContentEnd: json['parseContentEnd'],
      parseLanguageCodeStart: json['parseLanguageCodeStart'],
      parseLanguageCodeEnd: json['parseLanguageCodeEnd'],
    );
  }

  factory AuvAppConfigChatTranslateResponse.fromJsonString(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      return AuvAppConfigChatTranslateResponse();
    }
    try {
      final parsed = jsonDecode(jsonString);
      return AuvAppConfigChatTranslateResponse.fromJson(
        parsed is Map<String, dynamic> ? parsed : null,
      );
    } catch (_) {
      return AuvAppConfigChatTranslateResponse();
    }
  }
}