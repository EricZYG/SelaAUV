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

/// 表情包分组
class AuvStickerPackageResponse {
  final String name;
  final String icon;
  final int heartbeatLevel;
  final List<AuvStickerItemResponse> stickers;

  AuvStickerPackageResponse({
    required this.name,
    required this.icon,
    required this.heartbeatLevel,
    required this.stickers,
  });

  factory AuvStickerPackageResponse.fromJson(Map<String, dynamic> json) {
    return AuvStickerPackageResponse(
      name: json['name'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      heartbeatLevel: json['heartbeatLevel'] as int? ?? 0,
      stickers: (json['stickers'] as List<dynamic>?)
              ?.map((e) => AuvStickerItemResponse.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'heartbeatLevel': heartbeatLevel,
      'stickers': stickers.map((e) => e.toJson()).toList(),
    };
  }
}
