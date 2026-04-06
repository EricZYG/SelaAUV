/// 应用配置 - 迁移目标App模型
///
/// 字段说明:
/// - title: 目标app应用名称
/// - logo: 目标app图标地址
/// - downloadUrl: 目标app下载地址
class AuvAppConfigMigrationResponse {
  /// 目标app应用名称
  final String? title;

  /// 目标app图标地址
  final String? logo;

  /// 目标app下载地址
  final String? downloadUrl;

  AuvAppConfigMigrationResponse({
    this.title,
    this.logo,
    this.downloadUrl,
  });

  factory AuvAppConfigMigrationResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAppConfigMigrationResponse();
    return AuvAppConfigMigrationResponse(
      title: json['title'],
      logo: json['logo'],
      downloadUrl: json['downloadUrl'],
    );
  }
}