/// Banner 跳转类型
enum AuvBannerTarget {
  web,      // 0: 网页
  appPage, // 1: App 内页
  whatsApp, // 2: WhatsApp
}

/// Banner 封面类型
enum AuvBannerCoverType {
  normal, // 0: 普通
  webp,   // 1: webp 动图
}

/// Banner 配置
class AuvBannerModel {
  final String title;
  final String cover;
  final AuvBannerCoverType coverType;
  final AuvBannerTarget target;
  final String link;
  final int sort;

  AuvBannerModel({
    required this.title,
    required this.cover,
    required this.coverType,
    required this.target,
    required this.link,
    required this.sort,
  });

  factory AuvBannerModel.fromJson(Map<String, dynamic> json) {
    return AuvBannerModel(
      title: json['title'] ?? '',
      cover: json['cover'] ?? '',
      coverType: AuvBannerCoverType.values[json['coverType'] ?? 0],
      target: AuvBannerTarget.values[json['target'] ?? 0],
      link: json['link'] ?? '',
      sort: json['sort'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'cover': cover,
        'coverType': coverType.index,
        'target': target.index,
        'link': link,
        'sort': sort,
      };

  bool get isWebp => coverType == AuvBannerCoverType.webp;
  bool get isWebLink => target == AuvBannerTarget.web;
  bool get isAppPageLink => target == AuvBannerTarget.appPage;
  bool get isWhatsAppLink => target == AuvBannerTarget.whatsApp;
}
