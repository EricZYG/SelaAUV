import 'package:slea_auv/app/api/models/auv_models.dart';

/// 表情包单条信息
class AuvStickerItemResponse {
  final int stickerId;
  final String stickerIcon;
  final String stickerUrl;

  AuvStickerItemResponse({
    required this.stickerId,
    required this.stickerIcon,
    required this.stickerUrl,
  });

  factory AuvStickerItemResponse.fromJson(Map<String, dynamic> json) {
    return AuvStickerItemResponse(
      stickerId: json['stickerId'] as int? ?? 0,
      stickerIcon: json['stickerIcon'] as String? ?? '',
      stickerUrl: json['stickerUrl'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'stickerId': stickerId,
      'stickerIcon': stickerIcon,
      'stickerUrl': stickerUrl,
    };
  }
}
