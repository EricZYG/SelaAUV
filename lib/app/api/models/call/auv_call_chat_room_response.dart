/// 加入通话聊天室响应模型
/// 
/// 用户加入指定通话聊天室后返回的数据
class AuvCallChatRoomResponse {
  /// 频道id
  /// 
  /// 通话频道的唯一标识符
  final int? channelId;
  
  /// 通话类型
  /// 
  /// 0.正常拨打，1.AIB唤起，2.匹配唤起，3.主播邀请，4.主播免费邀请，5.免费匹配，6.直播间内唤起
  final int? callType;
  
  /// 多少秒以内主播无收益
  /// 
  /// 通话开始的前N秒，主播不计算收益
  final int? noProfitSeconds;
  
  /// 直播间内唤起首次扣费的通话时长
  /// 
  /// 直播间内发起通话时，首次扣费的时间阈值（秒）
  final int? liveFirstSeconds;
  
  /// 是否需要使用视频卡
  /// 
  /// true表示当前通话可以使用视频卡进行免费通话
  final bool? usedCallCard;
  
  /// 视频卡金币价值
  /// 
  /// 视频卡折算的金币数量
  final int? callCardCoins;
  
  /// 视频卡可使用的时长
  /// 
  /// 视频卡可抵扣的通话时长（秒数）
  final int? callCardSeconds;
  
  /// 匹配卡金币价值
  /// 
  /// 匹配卡折算的金币数量
  final int? matchCardCoins;
  
  /// 匹配卡可使用的时长
  /// 
  /// 匹配卡可抵扣的通话时长（秒数）
  final int? matchCardSeconds;
  
  /// 用户剩余钻石
  /// 
  /// 当前账户剩余的钻石数量
  final int? remainDiamonds;
  
  /// 收费钻石单价
  /// 
  /// 每次续费所扣除的钻石费用
  final int? chargePrice;
  
  /// 收费金币单价
  /// 
  /// 每次续费所扣除的金币费用
  final int? chargePriceCoins;
  
  /// 声网token
  /// 
  /// 用于加入声网实时通话的认证令牌
  final String? rtcToken;
  
  /// 开始计时时间
  /// 
  /// 通话开始计时的时间戳（毫秒）
  final int? startAt;
  
  /// 通话状态
  /// 
  /// 0.拨号中，1.未接，2.拒绝，3.通话中
  final int? status;
  
  /// IM连接令牌
  /// 
  /// 用于连接即时通讯的认证令牌
  final String? imToken;

  AuvCallChatRoomResponse({
    this.channelId,
    this.callType,
    this.noProfitSeconds,
    this.liveFirstSeconds,
    this.usedCallCard,
    this.callCardCoins,
    this.callCardSeconds,
    this.matchCardCoins,
    this.matchCardSeconds,
    this.remainDiamonds,
    this.chargePrice,
    this.chargePriceCoins,
    this.rtcToken,
    this.startAt,
    this.status,
    this.imToken,
  });

  factory AuvCallChatRoomResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvCallChatRoomResponse();
    return AuvCallChatRoomResponse(
      channelId: json['channelId'],
      callType: json['callType'],
      noProfitSeconds: json['noProfitSeconds'],
      liveFirstSeconds: json['liveFirstSeconds'],
      usedCallCard: json['usedCallCard'],
      callCardCoins: json['callCardCoins'],
      callCardSeconds: json['callCardSeconds'],
      matchCardCoins: json['matchCardCoins'],
      matchCardSeconds: json['matchCardSeconds'],
      remainDiamonds: json['remainDiamonds'],
      chargePrice: json['chargePrice'],
      chargePriceCoins: json['chargePriceCoins'],
      rtcToken: json['rtcToken'],
      startAt: json['startAt'],
      status: json['status'],
      imToken: json['imToken'],
    );
  }

  /// 获取通话类型描述
  /// 
  /// 返回可读性更好的通话类型文字说明
  String get callTypeDesc {
    switch (callType) {
      case 0:
        return '正常拨打';
      case 1:
        return 'AIB';
      case 2:
        return '匹配';
      case 3:
        return '主播邀请';
      case 4:
        return '主播免费邀请';
      case 5:
        return '免费匹配';
      case 6:
        return '直播间内唤起';
      default:
        return '未知';
    }
  }

  /// 获取通话状态描述
  /// 
  /// 返回可读性更好的通话状态文字说明
  String get statusDesc {
    switch (status) {
      case 0:
        return '拨号中';
      case 1:
        return '未接';
      case 2:
        return '拒绝';
      case 3:
        return '通话中';
      default:
        return '未知';
    }
  }

  /// 是否可以通话
  /// 
  /// true表示通话已建立，可以进行通话
  bool get canCall => status == 3;

  /// 是否使用视频卡
  /// 
  /// true表示可以使用视频卡进行免费通话
  bool get hasCallCard => usedCallCard == true && (callCardSeconds ?? 0) > 0;
}
