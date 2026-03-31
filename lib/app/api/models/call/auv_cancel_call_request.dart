/// 取消通话请求模型
/// 
/// 主叫方在通话建立前取消通话时提交的数据
class AuvCancelCallRequest {
  /// 频道id
  /// 
  /// 通话频道的唯一标识符
  final int channelId;
  
  /// 挂断原因
  /// 
  /// 标识通话取消的原因
  /// - 0.正常挂断
  /// - 1.对方未接
  /// - 2.对方拒绝
  /// - 3.通话超时
  /// - 4.网络异常
  /// - 5.用户主动挂断
  /// - 6.对方挂断
  /// - 7.系统中断
  /// - 8.余额不足
  final int endType;
  
  /// 匹配模式
  /// 
  /// 1.隐私模式
  final int? matchMode;

  AuvCancelCallRequest({
    required this.channelId,
    required this.endType,
    this.matchMode,
  });

  Map<String, dynamic> toJson() {
    return {
      'channelId': channelId,
      'endType': endType,
      if (matchMode != null) 'matchMode': matchMode,
    };
  }

  /// 获取挂断原因描述
  /// 
  /// 返回可读性更好的挂断原因文字说明
  String get endTypeDesc {
    switch (endType) {
      case 0:
        return '正常挂断';
      case 1:
        return '对方未接';
      case 2:
        return '对方拒绝';
      case 3:
        return '通话超时';
      case 4:
        return '网络异常';
      case 5:
        return '用户主动挂断';
      case 6:
        return '对方挂断';
      case 7:
        return '系统中断';
      case 8:
        return '余额不足';
      default:
        return '未知';
    }
  }
}
