/// 发布动态媒体资源模型
///
/// 表示动态中的单个媒体资源
///
/// 字段说明:
/// - mediaUrl: 资源链接
/// - videoCover: 资源类型为视频时的封面相对路径
/// - imageWidth: 图片宽度
/// - imageHeight: 图片高度
class AuvPublishMomentMediaRequest {
  /// 资源链接
  final String mediaUrl;

  /// 资源类型为视频时的封面相对路径
  final String? videoCover;

  /// 图片宽度
  final int imageWidth;

  /// 图片高度
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

  factory AuvPublishMomentMediaRequest.fromJson(Map<String, dynamic> json) {
    return AuvPublishMomentMediaRequest(
      mediaUrl: json['mediaUrl'] ?? json['media_url'] ?? '',
      videoCover: json['videoCover'] ?? json['video_cover'],
      imageWidth: json['imageWidth'] ?? json['image_width'] ?? 0,
      imageHeight: json['imageHeight'] ?? json['image_height'] ?? 0,
    );
  }
}

/// 发布动态请求模型
///
/// 发布动态接口的请求参数
///
/// 字段说明:
/// - content: 文字内容
/// - medias: 动态资源列表
/// - visibleType: 可见范围 0.公开 1.仅付费用户
/// - autoSend: 是否自动发送 0.否 1.是
class AuvPublishMomentRequest {
  /// 文字内容
  final String? content;

  /// 动态资源列表
  final List<AuvPublishMomentMediaRequest> medias;

  /// 可见范围 0.公开 1.仅付费用户
  final int visibleType;

  /// 是否自动发送 0.否 1.是
  final int? autoSend;

  AuvPublishMomentRequest({
    this.content,
    required this.medias,
    required this.visibleType,
    this.autoSend,
  });

  Map<String, dynamic> toJson() {
    return {
      if (content != null) 'content': content,
      'medias': medias.map((e) => e.toJson()).toList(),
      'visibleType': visibleType,
      if (autoSend != null) 'autoSend': autoSend,
    };
  }
}

/// 修改动态可见范围请求模型
///
/// 修改动态可见范围接口的请求参数
///
/// 字段说明:
/// - momentId: 动态id
/// - visibleType: 可见范围 0.公开 1.仅付费用户
class AuvUpdateMomentVisibleRequest {
  /// 动态id
  final int momentId;

  /// 可见范围 0.公开 1.仅付费用户
  final int visibleType;

  AuvUpdateMomentVisibleRequest({
    required this.momentId,
    required this.visibleType,
  });

  Map<String, dynamic> toJson() {
    return {
      'momentId': momentId,
      'visibleType': visibleType,
    };
  }
}