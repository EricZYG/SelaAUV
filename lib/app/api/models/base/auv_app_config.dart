/// 应用配置模型
///
/// 表示应用配置信息
///
/// 字段说明:
/// - ok: 签名密钥(用于接口签名)
/// - version: 应用版本
/// - updateUrl: 更新地址
/// - maintenance: 是否维护中
/// - maintenanceMsg: 维护提示信息
class AuvAppConfigResponse {
  /// 签名密钥(用于接口签名)
  final String? ok;

  /// 应用版本
  final String? version;

  /// 更新地址
  final String? updateUrl;

  /// 是否维护中
  final bool? maintenance;

  /// 维护提示信息
  final String? maintenanceMsg;

  AuvAppConfigResponse({
    this.ok,
    this.version,
    this.updateUrl,
    this.maintenance,
    this.maintenanceMsg,
  });

  factory AuvAppConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAppConfigResponse();
    return AuvAppConfigResponse(
      ok: json['ok'],
      version: json['version'],
      updateUrl: json['update_url'] ?? json['updateUrl'],
      maintenance: json['maintenance'],
      maintenanceMsg: json['maintenance_msg'] ?? json['maintenanceMsg'],
    );
  }
}
