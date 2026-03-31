/// 发布动态媒体项
class AuvPublishMediaItem {
  /// 指纹
  final int fingerPrint;

  /// 图片高度
  final int imageHeight;

  /// 图片宽度
  final int imageWidth;

  /// 媒体URL
  final String mediaUrl;

  /// 视频封面
  final String videoCover;

  AuvPublishMediaItem({
    required this.fingerPrint,
    required this.imageHeight,
    required this.imageWidth,
    required this.mediaUrl,
    required this.videoCover,
  });

  Map<String, dynamic> toJson() {
    return {
      'fingerPrint': fingerPrint,
      'imageHeight': imageHeight,
      'imageWidth': imageWidth,
      'mediaUrl': mediaUrl,
      'videoCover': videoCover,
    };
  }
}
