import 'dart:convert';

/// 应用配置 - 视频通话人脸验证配置模型
///
/// videoChatFaceVerifyConfig 字段的JSON解析结果
///
/// 字段说明:
/// - turnOffCountry: 关闭人脸验证的国家代码列表，逗号分隔
/// - isOpen: 是否开启人脸验证
/// - verifyTime: 验证时长（秒）
/// - noFaceTime: 无脸检测时长（秒）
class AuvAppConfigFaceVerifyResponse {
  /// 关闭人脸验证的国家代码列表，逗号分隔
  final String? turnOffCountry;

  /// 是否开启人脸验证
  final bool? isOpen;

  /// 验证时长（秒）
  final int? verifyTime;

  /// 无脸检测时长（秒）
  final int? noFaceTime;

  AuvAppConfigFaceVerifyResponse({
    this.turnOffCountry,
    this.isOpen,
    this.verifyTime,
    this.noFaceTime,
  });

  factory AuvAppConfigFaceVerifyResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAppConfigFaceVerifyResponse();
    return AuvAppConfigFaceVerifyResponse(
      turnOffCountry: json['turnOffCountry'],
      isOpen: json['isOpen'],
      verifyTime: json['verifyTime'],
      noFaceTime: json['noFaceTime'],
    );
  }

  factory AuvAppConfigFaceVerifyResponse.fromJsonString(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      return AuvAppConfigFaceVerifyResponse();
    }
    try {
      final parsed = jsonDecode(jsonString);
      return AuvAppConfigFaceVerifyResponse.fromJson(
        parsed is Map<String, dynamic> ? parsed : null,
      );
    } catch (_) {
      return AuvAppConfigFaceVerifyResponse();
    }
  }
}