/// 动态媒体信息模型
class AuvMomentMediaResponse {
  /// 资源链接
  final String? mediaUrl;

  /// 图片宽度
  final int? imageWidth;

  /// 图片高度
  final int? imageHeight;

  AuvMomentMediaResponse({
    this.mediaUrl,
    this.imageWidth,
    this.imageHeight,
  });

  factory AuvMomentMediaResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvMomentMediaResponse();
    return AuvMomentMediaResponse(
      mediaUrl: json['mediaUrl'] ?? json['media_url'],
      imageWidth: json['imageWidth'] ?? json['image_width'],
      imageHeight: json['imageHeight'] ?? json['image_height'],
    );
  }
}