/// 话题媒体项
class AuvTopicMediaItem {
  /// 媒体ID
  final int mediaId;

  /// 媒体类型
  final int mediaType;

  /// 可见类型
  final int? visibleType;

  /// 缩放类型
  final int? scaleType;

  /// 媒体URL
  final String? mediaUrl;

  /// 视频封面
  final String? videoCover;

  /// 图片宽度
  final int? imageWidth;

  /// 图片高度
  final int? imageHeight;

  AuvTopicMediaItem({
    required this.mediaId,
    required this.mediaType,
    this.visibleType,
    this.scaleType,
    this.mediaUrl,
    this.videoCover,
    this.imageWidth,
    this.imageHeight,
  });

  factory AuvTopicMediaItem.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return AuvTopicMediaItem(
        mediaId: 0,
        mediaType: 0,
      );
    }
    return AuvTopicMediaItem(
      mediaId: json['mediaId'] as int? ?? 0,
      mediaType: json['mediaType'] as int? ?? 0,
      visibleType: json['visibleType'] as int?,
      scaleType: json['scaleType'] as int?,
      mediaUrl: json['mediaUrl'] as String?,
      videoCover: json['videoCover'] as String?,
      imageWidth: json['imageWidth'] as int?,
      imageHeight: json['imageHeight'] as int?,
    );
  }
}
