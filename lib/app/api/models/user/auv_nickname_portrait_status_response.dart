/// 昵称头像审核状态响应模型
/// 
/// 对应接口: /user/user/getNicknamePortraitStatus
/// 
/// 获取用户昵称和头像的审核状态
class AuvNicknamePortraitStatusResponse {
  /// 头像审核状态
  /// - 0.待审核
  /// - 1.审核通过
  /// - 2.审核失败
  final int portraitStatus;

  /// 昵称审核状态
  /// - 0.待审核
  /// - 1.审核通过
  /// - 2.审核失败
  final int nicknameStatus;

  /// 头像审核变更时间
  final int portraitUpdatedAt;

  /// 昵称审核变更时间
  final int nicknameUpdatedAt;

  AuvNicknamePortraitStatusResponse({
    required this.portraitStatus,
    required this.nicknameStatus,
    required this.portraitUpdatedAt,
    required this.nicknameUpdatedAt,
  });

  factory AuvNicknamePortraitStatusResponse.fromJson(Map<String, dynamic> json) {
    return AuvNicknamePortraitStatusResponse(
      portraitStatus: json['portraitStatus'] ?? 0,
      nicknameStatus: json['nicknameStatus'] ?? 0,
      portraitUpdatedAt: json['portraitUpdatedAt'] ?? 0,
      nicknameUpdatedAt: json['nicknameUpdatedAt'] ?? 0,
    );
  }

  /// 头像审核状态描述
  String get portraitStatusDesc {
    switch (portraitStatus) {
      case 0:
        return '待审核';
      case 1:
        return '审核通过';
      case 2:
        return '审核失败';
      default:
        return '未知';
    }
  }

  /// 昵称审核状态描述
  String get nicknameStatusDesc {
    switch (nicknameStatus) {
      case 0:
        return '待审核';
      case 1:
        return '审核通过';
      case 2:
        return '审核失败';
      default:
        return '未知';
    }
  }

  /// 头像是否待审核
  bool get isPortraitPending => portraitStatus == 0;

  /// 头像是否审核通过
  bool get isPortraitApproved => portraitStatus == 1;

  /// 头像是否审核失败
  bool get isPortraitRejected => portraitStatus == 2;

  /// 昵称是否待审核
  bool get isNicknamePending => nicknameStatus == 0;

  /// 昵称是否审核通过
  bool get isNicknameApproved => nicknameStatus == 1;

  /// 昵称是否审核失败
  bool get isNicknameRejected => nicknameStatus == 2;

  /// 获取头像审核变更时间
  DateTime? get portraitUpdatedAtDateTime {
    if (portraitUpdatedAt <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(portraitUpdatedAt);
  }

  /// 获取昵称审核变更时间
  DateTime? get nicknameUpdatedAtDateTime {
    if (nicknameUpdatedAt <= 0) return null;
    return DateTime.fromMillisecondsSinceEpoch(nicknameUpdatedAt);
  }
}
