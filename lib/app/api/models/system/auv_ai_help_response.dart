/// AI Help菜单项模型
///
/// 表示AI Help菜单中的单个菜单项
///
/// 字段说明:
/// - title: 菜单标题
/// - content: 菜单内容
/// - contentType: 内容类型: 1-文本, 2-表单-尚未收到付款, 3-表单-付款方式, 4-表单-问题反馈, 5-投诉主播
/// - subMenus: 子菜单列表
class AuvAiHelpMenuItemResponse {
  /// 菜单标题
  final String? title;

  /// 菜单内容
  final String? content;

  /// 内容类型: 1-文本, 2-表单-尚未收到付款, 3-表单-付款方式, 4-表单-问题反馈, 5-投诉主播
  final int? contentType;

  /// 子菜单列表
  final List<AuvAiHelpMenuItemResponse>? subMenus;

  AuvAiHelpMenuItemResponse({
    this.title,
    this.content,
    this.contentType,
    this.subMenus,
  });

  factory AuvAiHelpMenuItemResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAiHelpMenuItemResponse();
    return AuvAiHelpMenuItemResponse(
      title: json['title'],
      content: json['content'],
      contentType: json['contentType'],
      subMenus: json['subMenus'] != null
          ? (json['subMenus'] as List)
              .map((e) => AuvAiHelpMenuItemResponse.fromJson(e))
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
      case 5:
        return '投诉主播';
      default:
        return '未知';
    }
  }

  /// 是否为文本类型
  bool get isText => contentType == 1;

  /// 是否为表单类型
  bool get isForm => contentType != null && contentType! >= 2 && contentType! <= 5;

  /// 是否有子菜单
  bool get hasSubMenus => subMenus != null && subMenus!.isNotEmpty;
}
