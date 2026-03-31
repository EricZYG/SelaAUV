import 'auv_publish_moment_media_request.dart';

/// 发布动态请求模型
class AuvPublishMomentRequest {
  final String? content;
  final List<AuvPublishMomentMediaRequest> medias;
  final int visibleType;
  final int? autoSend;

  AuvPublishMomentRequest({
    this.content,
    required this.medias,
    required this.visibleType,
    this.autoSend,
  });

  Map<String, dynamic> toJson() => {
    if (content != null) 'content': content,
    'medias': medias.map((e) => e.toJson()).toList(),
    'visibleType': visibleType,
    if (autoSend != null) 'autoSend': autoSend,
  };
}
