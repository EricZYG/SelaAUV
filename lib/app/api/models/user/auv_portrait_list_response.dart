/// 随机头像列表项模型
///
/// 随机获取头像列表接口返回的数据项
library;

/// 字段说明:
/// - userId: 用户ID
/// - portrait: 头像
class AuvPortraitItemResponse {
  /// 用户ID
  final int? userId;

  /// 头像
  final String? portrait;

  AuvPortraitItemResponse({
    this.userId,
    this.portrait,
  });

  factory AuvPortraitItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvPortraitItemResponse();
    return AuvPortraitItemResponse(
      userId: json['userId'],
      portrait: json['portrait'],
    );
  }
}
