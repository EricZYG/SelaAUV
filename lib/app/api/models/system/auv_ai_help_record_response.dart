/// AI Help记录模型
///
/// 表示AI Help的记录信息
///
/// 字段说明:
/// - id: 记录id
/// - userId: 用户id
/// - countryCode: 国家编码
/// - appChannel: 包名
/// - content: 内容
/// - contentType: 内容类型: 1-文本, 2-表单-尚未收到付款, 3-表单-付款方式, 4-表单-问题反馈, 5-投诉主播
/// - opUid: 操作人id
/// - isVip: 是否是vip: 0-否, 1-是
/// - isRecharge: 是否充值: 0-否, 1-是
/// - status: 表单状态: -1-用户发的还未被查看过, 0-待处理, 1-处理中, 2-处理完成, 3-忽略
/// - createdAt: 创建时间
/// - updatedAt: 修改时间
class AuvAiHelpRecordResponse {
  /// 记录id
  final int? id;

  /// 用户id
  final int? userId;

  /// 国家编码
  final int? countryCode;

  /// 包名
  final String? appChannel;

  /// 内容
  final String? content;

  /// 内容类型: 1-文本, 2-表单-尚未收到付款, 3-表单-付款方式, 4-表单-问题反馈, 5-投诉主播
  final int? contentType;

  /// 操作人id
  final String? opUid;

  /// 是否是vip: 0-否, 1-是
  final int? isVip;

  /// 是否充值: 0-否, 1-是
  final int? isRecharge;

  /// 表单状态: -1-用户发的还未被查看过, 0-待处理, 1-处理中, 2-处理完成, 3-忽略
  final int? status;

  /// 创建时间
  final int? createdAt;

  /// 修改时间
  final int? updatedAt;

  AuvAiHelpRecordResponse({
    this.id,
    this.userId,
    this.countryCode,
    this.appChannel,
    this.content,
    this.contentType,
    this.opUid,
    this.isVip,
    this.isRecharge,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AuvAiHelpRecordResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAiHelpRecordResponse();
    return AuvAiHelpRecordResponse(
      id: json['id'],
      userId: json['userId'],
      countryCode: json['countryCode'],
      appChannel: json['appChannel'],
      content: json['content'],
      contentType: json['contentType'],
      opUid: json['opUid'],
      isVip: json['isVip'],
      isRecharge: json['isRecharge'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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

  /// 是否是vip用户
  bool get isVipUser => isVip == 1;

  /// 是否充值用户
  bool get hasRecharged => isRecharge == 1;

  /// 获取状态描述
  String get statusDesc {
    switch (status) {
      case -1:
        return '未查看';
      case 0:
        return '待处理';
      case 1:
        return '处理中';
      case 2:
        return '处理完成';
      case 3:
        return '忽略';
      default:
        return '未知';
    }
  }

  /// 是否为未处理状态
  bool get isPending => status == null || status == -1 || status == 0;
}
