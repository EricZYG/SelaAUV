/// AI Help菜单响应模型【遗漏】
///
/// 获取AI Help菜单列表接口返回的数据
///
/// 对应接口: POST /system/aiHelp/getConfigList
///
/// 实际API返回示例:
/// ```json
/// {
///   "title": null,
///   "content": null,
///   "contentType": 1,
///   "subMenus": [...]
/// }
/// ```
///
/// 字段说明:
/// - title: 菜单标题
/// - content: 菜单内容
/// - contentType: 内容类型 1-文本, 2-表单-尚未收到付款, 3-表单-付款方式, 4-表单-问题反馈
/// - subMenus: 子菜单列表
class AuvAiHelpConfigResponse {
  /// 菜单标题
  final String? title;

  /// 菜单内容
  final String? content;

  /// 内容类型: 1-文本, 2-表单-尚未收到付款, 3-表单-付款方式, 4-表单-问题反馈
  final int? contentType;

  /// 子菜单列表
  final List<AuvAiHelpConfigResponse>? subMenus;

  AuvAiHelpConfigResponse({
    this.title,
    this.content,
    this.contentType,
    this.subMenus,
  });

  factory AuvAiHelpConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAiHelpConfigResponse();
    return AuvAiHelpConfigResponse(
      title: json['title'],
      content: json['content'],
      contentType: json['contentType'],
      subMenus: json['subMenus'] != null
          ? (json['subMenus'] as List)
              .map((e) => AuvAiHelpConfigResponse.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  /// 获取内容类型描述
  String get contentTypeDesc {
    switch (contentType) {
      case 1:
        return '文本';
      case 2:
        return '表单-尚未收到付款';
      case 3:
        return '表单-付款方式';
      case 4:
        return '表单-问题反馈';
      default:
        return '未知';
    }
  }

  /// 是否为文本类型
  bool get isText => contentType == 1;

  /// 是否为表单类型
  bool get isForm => contentType != null && contentType! >= 2 && contentType! <= 4;

  /// 是否有子菜单
  bool get hasSubMenus => subMenus != null && subMenus!.isNotEmpty;

  /// 获取所有子菜单（包括递归获取深层子菜单）
  List<AuvAiHelpConfigResponse> getAllSubMenus() {
    final result = <AuvAiHelpConfigResponse>[];
    if (subMenus != null) {
      for (final menu in subMenus!) {
        result.add(menu);
        result.addAll(menu.getAllSubMenus());
      }
    }
    return result;
  }
}
