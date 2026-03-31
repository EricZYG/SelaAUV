/// 发布动态媒体资源模型
class AuvPublishMomentMediaRequest {
  final String mediaUrl;
  final String? videoCover;
  final int imageWidth;
  final int imageHeight;

  AuvPublishMomentMediaRequest({
    required this.mediaUrl,
    this.videoCover,
    required this.imageWidth,
    required this.imageHeight,
  });

  Map<String, dynamic> toJson() {
    return {
      'mediaUrl': mediaUrl,
      if (videoCover != null) 'videoCover': videoCover,
      'imageWidth': imageWidth,
      'imageHeight': imageHeight,
    };
  }
}
