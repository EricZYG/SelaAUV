import 'auv_sticker_response.dart';

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
