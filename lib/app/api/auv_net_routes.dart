/// ShowDoc API 路由配置
/// 
/// 接口地址前缀: https://api.example.com (根据实际情况修改)
/// 
/// 所有接口需要签名验证，签名规则：
/// 1. 请求参数按ASCII码从小到大排序
/// 2. 拼接成URL键值对格式 stringA
/// 3. 在末尾拼接 time 和 key，得到 stringSignTemp
/// 4. 对 stringSignTemp 进行 MD5 运算，结果转小写得到 sign
/// 
/// 请求头需要添加：
/// - s-time: 请求时间戳（毫秒）
/// - s-sign: 签名值
abstract class AuvNetRoutes {
  // ==================== 认证相关 ====================
  
  /// 游客登录
  /// 请求方式: POST
  /// Body参数:
  ///   - password: 加密后的密码（必填）
  ///   - aidLimit: 是否限制广告id获取，0.未限制，1.限制获取（可选）
  ///   - aid: 广告id（可选）
  ///   - useVpn: 是否使用了vpn，0.未使用，1.使用了（可选）
  /// 返回数据:
  ///   - userId: 用户ID
  ///   - username: 用户名
  ///   - appChannel: app渠道
  ///   - deregisterFlag: 是否待注销
  ///   - deregisterTime: 注销时间
  ///   - authorization: 请求凭证（JWT token）
  /// 说明: 游客登录，无需验证码
  /// 需要签名: 是
  static const String guestLogin = '/user/login/guest';

  /// 手机号登录
  /// 请求方式: POST
  /// 请求参数: phone (手机号), code (验证码)
  /// 说明: 使用手机号和验证码登录
  /// 需要签名: 是
  static const String phoneLogin = '/user/login/phone';

  /// 谷歌登录
  /// 请求方式: POST
  /// 请求参数: id_token (Google ID Token)
  /// 说明: 使用Google账号登录
  /// 需要签名: 是
  static const String googleLogin = '/user/login/google';

  /// 苹果登录
  /// 请求方式: POST
  /// 请求参数: identity_token (Apple Identity Token), authorization_code (授权码,可选), name (用户名称,可选)
  /// 说明: 使用Apple ID登录
  /// 需要签名: 是
  static const String appleLogin = '/user/login/apple';

  /// 公会后台邀请码密码登录
  /// 请求方式: POST
  /// Body参数:
  ///   - username: 邀请码 (必填)
  ///   - password: 明文密码 (必填)
  /// 返回数据:
  ///   - code=0: 成功，返回authorization (JWT token)
  ///   - code=1031: 不能再用邀请码登录，此时data为账号id
  /// 说明: 分配的客户端账号设置了密码后不能再用邀请码登录，只能用账号登录
  /// 需要签名: 是
  static const String guildLogin = '/manager/login/guild';

  // ==================== 用户相关 ====================
  
  /// 用户端-获取我的页面信息
  /// 请求方式: GET
  /// 请求参数: 无
  /// 说明: 获取当前登录用户的详细信息（我的页面）
  static const String getUserDetail = '/user/user/getUserDetail';

  /// 用户信息
  /// 请求方式: GET
  /// 说明: 获取当前登录用户的信息
  /// 需要认证: 是
  static const String userInfo = '/user/info';

  /// 更新用户信息
  /// 请求方式: POST
  /// 说明: 更新用户资料
  /// 需要认证: 是
  static const String updateUserInfo = '/user/update';

  /// 签到领奖励
  /// 请求方式: POST
  /// 请求参数: signDay (签到天数), dateStr (日期字符串,可选,用于测试)
  /// 返回数据: 签到奖励信息
  /// 说明: 连续签到可获得不同奖励
  /// 需要签名: 是
  static const String signIn = '/user/sign/signIn';

  // ==================== 充值相关 ====================
  
  /// 礼物列表
  /// 请求方式: GET
  /// 请求参数: category_id (分类ID,可选), page (页码), page_size (每页数量)
  /// 返回数据: 礼物列表
  /// 说明: 获取可赠送的礼物列表
  static const String giftList = '/gift/list';

  // ==================== 用户礼物相关 ====================

  /// 获取普通礼物列表
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 普通礼物列表（分页）
  /// 说明: 获取普通礼物列表
  static const String getGiftList = '/user/gift/getGiftList';

  /// 获取普通+VIP礼物列表
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 普通+VIP礼物列表（分页）
  /// 说明: 获取普通+VIP礼物列表
  static const String getAllGifts = '/user/gift/getAllGifts';

  /// 获取单个礼物详情
  /// 请求方式: GET
  /// 请求参数: gid (礼物ID)
  /// 返回数据: 礼物详情
  /// 说明: 根据礼物ID获取单个礼物详情
  static const String getOneGift = '/user/gift/getOne';

  /// 获取礼物动作列表
  /// 请求方式: GET
  /// 请求参数: type (动作类型, 1:1v1动作, 2:直播间动作, 不传默认1)
  /// 返回数据: 动作列表
  /// 说明: 获取礼物动作列表
  static const String getActions = '/user/gift/getActions';

  /// 获取自己的礼物秀列表
  /// 请求方式: GET
  /// query参数:
  ///   - type: 类型（可选）
  ///     * 1. 1v1动作
  ///     * 2. 直播间动作
  ///     * 不传默认为1
  /// 返回数据: 礼物秀列表
  /// 说明: 获取自己配置的礼物秀列表
  static const String getGiftShows = '/user/gift/getGiftShows';

  /// 获取对方的礼物秀列表
  /// 请求方式: GET
  /// query参数:
  ///   - userId: 主播id（必填）
  ///   - type: 类型（可选）
  ///     * 1. 1v1动作
  ///     * 2. 直播间动作
  ///     * 不传默认为1
  /// 返回数据: 礼物秀列表
  /// 说明: 获取指定主播的礼物秀列表
  static const String getAnchorGiftShows = '/user/gift/getAnchorGiftShows';

  /// 设置1v1礼物秀
  /// 请求方式: POST
  /// Body参数:
  ///   - 礼物秀列表（数组）
  ///     * gid: 礼物ID（必填）
  ///     * actionId: 动作id（必填）
  /// 返回数据: null表示成功
  /// 说明: 设置自己的1v1礼物秀
  static const String setGiftShows = '/user/gift/setGiftShows';

  /// 增加直播间礼物秀
  /// 请求方式: POST
  /// Body参数:
  ///   - gid: 礼物ID（必填）
  ///   - actionId: 动作id（必填）
  /// 返回数据: null表示成功
  /// 说明: 增加直播间礼物秀
  static const String addLiveGiftShow = '/user/gift/addLiveGiftShow';

  /// 修改直播间礼物秀
  /// 请求方式: POST
  /// Body参数:
  ///   - showId: 主键id（必填）
  ///   - gid: 礼物ID（可选）
  ///   - actionId: 动作id（可选）
  /// 返回数据: null表示成功
  /// 说明: 修改直播间礼物秀
  static const String updateLiveGiftShow = '/user/gift/updateLiveGiftShow';

  /// 删除直播间礼物秀
  /// 请求方式: DELETE
  /// Path参数:
  ///   - showId: 主键id
  /// Body参数:
  ///   - showId: 主键id
  /// 返回数据: null表示成功
  /// 说明: 删除直播间礼物秀
  static const String deleteLiveGiftShow = '/user/gift/deleteLiveGiftShow/{showId}';

  /// 设置直播间礼物秀开关
  /// 请求方式: POST
  /// Body参数:
  ///   - flag: 直播间礼物秀开关（必填），0.关闭，1.开启
  /// 返回数据: null表示成功
  /// 说明: 设置直播间礼物秀开关
  static const String setLiveGiftShowFlag = '/user/anchor/setLiveGiftShowFlag';

  /// 获取直播间礼物秀开关
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据:
  ///   - flag: 直播间礼物秀开关，0.关闭，1.开启
  /// 说明: 获取直播间礼物秀开关
  static const String getLiveGiftShowFlag = '/user/anchor/getLiveGiftShowFlag';

  /// 主播索要礼物
  /// 请求方式: POST
  /// Body参数:
  ///   - userId: 用户id（必填）
  ///   - gid: 礼物ID（必填）
  ///   - type: 类型（必填），1.私信中索要，2.通话中索要
  ///   - begId: 主播索要id（必填）
  /// 返回数据:
  ///   - content: 索要文案
  /// 说明: 主播索要礼物
  static const String begGift = '/user/beg/begGift';

  /// 获取送礼榜单
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据:
  ///   - List<GiftRankItem>:
  ///     - gid: 礼物ID
  ///     - senderId: 发送方ID
  ///     - receiverId: 接收方ID
  ///     - quantity: 礼物数量
  ///     - diamonds: 礼物价值钻石数（小数点后两位）
  ///     - time: 送礼时间
  ///     - senderNickname: 发送方昵称
  ///     - receiverNickname: 接收方昵称
  ///     - senderPortrait: 发送方头像
  ///     - receiverPortrait: 接收方头像
  ///     - icon: 礼物图标
  /// 说明: 获取送礼榜单
  static const String getGiftRank = '/user/gift/getGiftRank';

  /// 客户端获取主播礼物榜单
  /// 请求方式: GET
  /// Query参数:
  ///   - userId: 主播id（必填）
  ///   - gid: 礼物id（必填）
  /// 返回数据:
  ///   - List<AnchorGiftRankItem>:
  ///     - gid: 礼物ID
  ///     - icon: 礼物图标
  ///     - quantity: 礼物数量
  ///     - userId: 用户id
  ///     - nickname: 用户昵称
  ///     - portrait: 用户头像
  ///     - vipFlag: 是否vip
  ///     - level: 用户等级
  /// 说明: 客户端获取主播礼物榜单
  static const String getAnchorGiftRank = '/user/gift/getAnchorGiftRank';

  /// 主播端获取自己的送礼榜单
  /// 请求方式: GET
  /// Query参数:
  ///   - gid: 礼物id（必填）
  /// 返回数据:
  ///   - List<MyGiftRankItem>:
  ///     - gid: 礼物ID
  ///     - icon: 礼物图标
  ///     - quantity: 礼物数量
  ///     - userId: 用户id
  ///     - nickname: 用户昵称
  ///     - portrait: 用户头像
  ///     - vipFlag: 是否vip
  ///     - level: 用户等级
  /// 说明: 主播端获取自己收到的指定礼物的送礼榜单
  static const String getMyGiftRank = '/user/gift/getMyGiftRank';

  /// 主播端获取自己的送礼top1
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据:
  ///   - List<MyGiftTopOneItem>:
  ///     - gid: 礼物ID
  ///     - topOneUserId: top1用户id
  ///     - topOneNickname: top1用户昵称
  ///     - topOnePortrait: top1用户头像
  ///     - topOneVipFlag: top1是否vip
  /// 说明: 主播端获取自己收到的所有礼物的Top1用户
  static const String getMyGiftTopOne = '/user/gift/getMyGiftTopOne';

  /// 主播端获取自己收到的礼物墙
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据:
  ///   - List<MyGiftWallItem>:
  ///     - gid: 礼物ID
  ///     - name: 礼物名称
  ///     - diamonds: 钻石价格，小数点后两位
  ///     - icon: 礼物图标
  ///     - receiveNum: 收到的总数
  ///     - topOneUserId: top1用户id
  ///     - topOneNickname: top1用户昵称
  ///     - topOnePortrait: top1用户头像
  ///     - topOneVipFlag: top1用户是否vip
  ///     - currDiffNum: 当前用户距离top1用户相差的送礼数量
  /// 说明: 主播端获取自己收到的礼物墙
  static const String getMyGiftWall = '/user/gift/getMyGiftWall';

  /// 获取钻石数达到试播成功的礼物列表
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据:
  ///   - 分页礼物列表:
  ///     - total: 总记录数
  ///     - list: 礼物列表
  ///       - gid: 礼物ID
  ///       - name: 礼物名称
  ///       - diamonds: 钻石价格
  ///       - coins: 金币价格
  ///       - giftType: 礼物类型，1.普通礼物，2.VIP礼物
  ///       - icon: 图标
  ///       - animEffectUrl: 特效
  ///       - md5: md5
  ///     - pageNum: 当前页码
  ///     - pageSize: 每页数量
  ///     - pages: 总页数
  /// 说明: 获取钻石数达到试播成功的礼物列表
  static const String getTrialReachGifts = '/user/gift/getTrialReachGifts';

  /// 获取幸运礼物列表
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据:
  ///   - List<LuckyGiftItem>:
  ///     - luckyId: 主键id
  ///     - probability: 礼物概率，10表示10%的概率
  ///     - gid: 礼物ID
  ///     - name: 礼物名称
  ///     - diamonds: 钻石价格
  ///     - coins: 金币价格
  ///     - giftType: 礼物类型，1.普通礼物，2.VIP礼物
  ///     - icon: 图标
  ///     - animEffectUrl: 特效
  ///     - md5: md5
  /// 说明: 获取幸运礼物列表
  static const String getLuckyGifts = '/user/gift/getLuckyGifts';

  /// 分页查询聊天记录
  /// 请求方式: GET
  /// 参数:
  ///   - otherUserId: 对方用户id，选填
  ///   - offsetId: 偏移id，初始不传，后续传上次记录列表中的最后一个元素的id
  ///   - pageSize: 每页条数
  /// 返回数据:
  ///   - List<MsgRecordItem>:
  ///     - id: 主键id，用于后续传到offsetId参数
  ///     - fromUserId: 发送方用户id
  ///     - targetUserId: 接收方用户id
  ///     - msgType: 消息类型(1.文字, 2.图片, 4.视频, 5.语音等)
  ///     - content: 消息内容
  ///     - jsonData: 发给对方的原内容
  ///     - extraData: 额外内容
  ///     - createdAt: 发送时间
  ///     - otherUsername: 对方用户名
  ///     - otherNickname: 对方昵称
  ///     - otherPortrait: 对方头像
  ///     - otherIsOnline: 对方是否在线(0.离线, 1.在线)
  /// 说明: 分页查询聊天记录
  static const String getMsgRecords = '/user/msg/getMsgRecords';

  // ==================== 送礼相关 ====================

  /// 赠送礼物(真实礼物)
  /// 请求方式: POST
  /// Body参数:
  ///   - receiverId: 接收方id（必填）
  ///   - quantity: 数量（必填）
  ///   - gid: 礼物id（必填）
  ///   - channelName: 游戏房频道id（可选）
  ///   - begId: 主播索要id（可选）
  ///   - liveChannelName: 直播间频道号（可选）
  /// 返回数据:
  ///   - gid: 礼物id
  ///   - deposit: 剩余钻
  ///   - becomeTopOne: 是否从非top1变成了top1
  /// 说明: 向用户/主播赠送真实礼物，消耗钻石
  /// 需要签名: 是
  static const String sendRealGift = '/user/gift/sendReal';

  /// 赠送幸运礼物
  /// 请求方式: POST
  /// 请求参数: gift_id (礼物ID), anchor_id (主播ID), room_id (直播间ID), num (数量)
  /// 返回数据: 送礼结果,包含幸运抽奖结果等
  /// 说明: 赠送幸运礼物有机会获得额外奖励
  /// 需要签名: 是
  static const String sendLuckyGift = '/user/gift/sendLucky';

  // ==================== 直播间相关 ====================
  
  /// 分页查询直播间列表
  /// 请求方式: POST
  /// body参数: page (页码), pageSize (每页条数), categoryId (分类ID,可选), userId (用户ID,可选)
  /// 返回数据: 直播间列表
  /// 说明: 获取正在直播的房间列表
  static const String liveRoomList = '/live/room/getList';

  /// 直播间详情
  /// 请求方式: GET
  /// 请求参数: roomId (直播间ID)
  /// 返回数据: 直播间详细信息（含观众列表）
  /// 说明: 获取指定直播间的详细信息
  static const String liveRoomDetail = '/live/room/getDetail';

  // ==================== 主播相关 ====================
  
  /// 主播列表
  /// 请求方式: GET
  /// 请求参数: category_id (分类ID,可选), page (页码), page_size (每页数量)
  /// 返回数据: 主播列表
  /// 说明: 获取主播列表
  static const String anchorList = '/anchor/list';

  /// 主播详情
  /// 请求方式: GET
  /// 请求参数: anchor_id (主播ID)
  /// 返回数据: 主播详细信息
  /// 说明: 获取指定主播的详细信息
  static const String anchorDetail = '/anchor/detail';

  // ==================== 分类相关 ====================
  
  /// 分类列表
  /// 请求方式: GET
  /// 返回数据: 分类列表
  /// 说明: 获取所有礼物/主播分类
  static const String categoryList = '/category/list';

  // ==================== 通话相关 ====================
  
  /// 获取通话记录
  /// 请求方式: POST
  /// body参数: callType (唤起方式), callFlag (0未接/1已接), callTypes (唤起方式列表)
  /// 返回数据: 通话记录列表
  /// 说明: 获取用户的历史通话记录
  static const String getCallRecordList = '/call/call/getCallRecordVoList';

  /// 创建通话频道
  /// 请求方式: POST
  /// 路径参数:
  ///   - type: 通话类型
  ///     * 0.正常拨打
  ///     * 1.AIB唤起
  ///     * 2.匹配唤起
  ///     * 3.主播邀请
  ///     * 4.主播免费邀请
  ///     * 5.免费匹配
  ///     * 6.直播间内唤起
  ///   - targetUserId: 对方的userId
  /// 返回数据: 频道信息
  /// 错误码:
  ///   - code=0: 成功
  ///   - code=1008: 余额不足
  /// 说明: 创建与目标用户的通话频道
  static const String createCallChannel = '/call/call/createCall';

  /// 加入通话聊天室
  /// 请求方式: POST
  /// 路径参数: channelId (频道ID)
  /// 返回数据: 聊天室信息
  ///   - channelId: 频道id
  ///   - callType: 通话类型（0.正常拨打，1.AIB，2.匹配，3.主播邀请，4.主播免费邀请，5.免费匹配，6.直播间内唤起）
  ///   - rtcToken: 声网token
  ///   - imToken: IM连接令牌
  ///   - usedCallCard: 是否使用视频卡
  ///   - remainDiamonds: 用户剩余钻石
  ///   - chargePrice: 收费钻石单价
  ///   - chargePriceCoins: 收费金币单价
  ///   - noProfitSeconds: 多少秒以内主播无收益
  ///   - liveFirstSeconds: 直播间内唤起首次扣费的通话时长
  ///   - callCardCoins: 视频卡金币价值
  ///   - callCardSeconds: 视频卡可使用的时长（秒数）
  ///   - matchCardCoins: 匹配卡金币价值
  ///   - matchCardSeconds: 匹配卡可使用的时长（秒数）
  /// 错误码:
  ///   - code=0: 成功
  ///   - code=1008: 余额不足
  /// 说明: 用户加入指定的通话聊天室
  static const String joinCallChannel = '/call/call/joinCall';

  /// 用户通话续费
  /// 请求方式: POST
  /// 路径参数: channelId (频道ID)
  /// 请求参数: 无
  /// 返回数据: rtcToken (声网token)
  /// 错误码:
  ///   - code=0: 成功
  ///   - code=1008: 余额不足
  /// 说明: 刷新/续期通话频道的RTC令牌
  static const String refreshCall = '/call/call/refreshCall';

  /// 挂断通话
  /// 请求方式: POST
  /// body参数:
  ///   - channelId: 频道id（必填）
  ///   - endType: 挂断原因（必填）
  ///     * 0.正常挂断
  ///     * 1.对方未接
  ///     * 2.对方拒绝
  ///     * 3.通话超时
  ///     * 4.网络异常
  ///     * 5.用户主动挂断
  ///     * 6.对方挂断
  ///     * 7.系统中断
  ///     * 8.余额不足
  ///   - clientEndAt: 客户端挂断时间，毫秒数（可选）
  ///   - clientDuration: 客户端通话时长，毫秒数（可选）
  ///   - outDuration: 不在视频范围内的时长，毫秒数（可选）
  ///   - outCount: 不在视频范围内的次数（可选）
  ///   - requestCount: 请求次数（可选）
  ///   - matchMode: 匹配模式，1.隐私模式（可选）
  /// 返回数据:
  ///   - channelId: 频道id
  ///   - callTime: 通话时长，格式HH:mm:ss
  ///   - totalCallTime: 总通话时长，格式HH:mm:ss
  ///   - usedMatchPropFlag: 是否使用了匹配卡
  ///   - usedCallPropFlag: 是否使用了视频卡
  ///   - callAmount: 通话用户消费/主播收益，小数点后两位
  ///   - giftAmount: 礼物用户消费/主播收益，小数点后两位
  ///   - remainAmount: 用户/主播余额，小数点后两位
  ///   - callCardCount: 剩余视频卡数量
  /// 错误码:
  ///   - code=0: 成功
  ///   - code=1008: 余额不足
  /// 说明: 结束当前通话并获取结算信息
  static const String endCall = '/call/call/endCall';

  /// 主叫取消通话
  /// 请求方式: POST
  /// body参数:
  ///   - channelId: 频道id（必填）
  ///   - endType: 挂断原因（必填）
  ///     * 0.正常挂断
  ///     * 1.对方未接
  ///     * 2.对方拒绝
  ///     * 3.通话超时
  ///     * 4.网络异常
  ///     * 5.用户主动挂断
  ///     * 6.对方挂断
  ///     * 7.系统中断
  ///     * 8.余额不足
  ///   - matchMode: 匹配模式，1.隐私模式（可选）
  /// 返回数据: 无
  /// 错误码:
  ///   - code=0: 成功
  ///   - code=1008: 余额不足
  /// 说明: 主叫方在通话建立前取消通话
  static const String cancelCall = '/call/cancelCall';

  /// 被叫拒绝通话
  /// 请求方式: POST
  /// body参数:
  ///   - channelId: 频道id（必填）
  ///   - endType: 挂断原因（必填）
  ///     * 0.正常挂断
  ///     * 1.对方未接
  ///     * 2.对方拒绝
  ///     * 3.通话超时
  ///     * 4.网络异常
  ///     * 5.用户主动挂断
  ///     * 6.对方挂断
  ///     * 7.系统中断
  ///     * 8.余额不足
  /// 返回数据: 无
  /// 错误码:
  ///   - code=0: 成功
  ///   - code=1008: 余额不足
  /// 说明: 被叫方拒绝接听来电
  static const String refuseCall = '/call/call/refuseCall';

  /// 心跳请求
  /// 请求方式: POST
  /// body参数: isScreenOff (主播是否熄屏), rtmStatus (用户RTM状态 0离线/1在线)
  /// 返回数据: 无
  /// 说明: 1-2分钟间隔请求一次，用于保持在线状态
  static const String heartbeat = '/user/user/heartbeat';

  /// 用户端编辑资料获取信息
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 用户资料信息
  /// 说明: 获取当前用户的编辑资料信息
  static const String getUserUpdateDetail = '/user/user/getUserUpdateDetailVo';

  /// 用户端编辑相册
  /// 请求方式: POST
  /// body参数: userId (用户ID), albumUrlList (相册列表)
  /// 返回数据: 无
  /// 说明: 更新用户的相册列表
  static const String updateAlbumUrlList = '/user/user/updateAlbumUrlList';

  /// 修改个人信息
  /// 请求方式: POST
  /// body参数: 详见 updateUserDetail 方法
  /// 返回数据: portrait/albumUrlList (有值表示命中黄色，Null表示正常)
  /// 说明: 用户端和主播端通用
  static const String updateUserDetail = '/user/user/updateUserDetail';

  // ==================== 动态相关 ====================

  /// 发布动态
  /// 请求方式: POST
  /// body参数: content (文字内容,可选), medias (动态资源列表), visibleType (可见范围 0公开/1仅付费用户), autoSend (是否自动发送)
  /// 返回数据: 尺度 1.正常尺度 2.大尺度
  /// 说明: 用户端和主播端通用
  static const String publishMoment = '/user/anchorMoment/publish';

  /// 修改动态可见范围
  /// 请求方式: POST
  /// body参数: momentId (动态id), visibleType (可见范围 0公开/1仅付费用户)
  /// 返回数据: 无
  static const String updateMomentVisibleType = '/user/anchorMoment/updateVisibleType';

  /// 主播端查自己动态
  /// 请求方式: POST
  /// body参数: pageNum (页码), pageSize (每页条数), condition (查询条件)
  /// 返回数据: 分页动态列表
  static const String getMyMoment = '/user/anchorMoment/getMyMoment';

  /// 查单个主播动态
  /// 请求方式: GET
  /// query参数: momentId (动态id)
  /// 返回数据: 单条动态详情
  static const String getOneMoment = '/user/anchorMoment/getOneMoment';

  /// 主播端查其他主播动态
  /// 请求方式: POST
  /// body参数: pageNum (页码), pageSize (每页条数), condition (查询条件)
  /// 支持查询类型: 1.hot 2.new, 可查询单个或多个主播的动态
  static const String anchorGetOtherMoment = '/user/anchorMoment/anchorGetOtherMoment';

  /// 用户端查主播动态
  /// 请求方式: POST
  /// body参数: pageNum (页码), pageSize (每页条数), condition (查询条件)
  /// 支持查询类型: 1.hot 2.new 3.follow, 可查询单个或多个主播的动态
  static const String userGetMoment = '/user/anchorMoment/userGetMoment';

  /// 获取动态评论
  /// 请求方式: POST
  /// body参数: pageNum (页码), pageSize (每页条数), condition (查询条件)
  /// 返回动态的评论列表及回复
  static const String getComments = '/user/anchorMoment/getComments';

  /// 关注主播是否有新的动态
  /// 请求方式: GET
  /// 无参数
  /// 返回数据: 0.没有 1.有
  static const String hasNewFollowMoment = '/user/anchorMoment/hasNewFollowMoment';

  // ==================== 消息相关 ====================

  /// 发送消息
  /// 请求方式: POST
  /// body参数:
  ///   - recipientId: 接收者id
  ///   - type: 消息类型 (11.文字，12.图片 14.视频 15.语音)
  ///   - urlOrContent: 图片地址/视频地址/语音地址/文本内容
  ///   - jsonData: 客户端自己用的数据（可选）
  ///   - extraData: 额外数据（可选）
  /// 返回数据: code=0表示成功
  static const String sendMsg = '/user/msg/sendMsg';

  /// 通话中发送消息
  /// 请求方式: POST
  /// body参数:
  ///   - recipientId: 接收者id
  ///   - type: 消息类型 (11.文字，12.图片 14.视频 15.语音)
  ///   - channelId: 通话频道id
  ///   - urlOrContent: 图片地址/视频地址/语音地址/文本内容
  ///   - jsonData: 客户端自己用的数据（可选）
  /// 返回数据: code=0表示成功
  /// 说明: 视频通话中发送消息，不校验好友关系也不扣费
  static const String sendMsgInCall = '/user/msg/sendMsgInCall';

  /// 游戏房间中发送消息
  /// 请求方式: POST
  /// body参数:
  ///   - recipientId: 接收者id（固定传0）
  ///   - channelId: 频道名称
  ///   - type: 消息类型 (11.文字，12.图片 14.视频 15.语音)
  ///   - urlOrContent: 图片地址/视频地址/语音地址/文本内容
  ///   - jsonData: 客户端自己用的数据（可选）
  /// 返回数据: code=0表示成功
  static const String sendMsgInGameRoom = '/user/msg/sendMsgInGameRoom';

  /// 直播间中发送消息
  /// 请求方式: POST
  /// 参数:
  ///   - recipientId: 接收者id，固定传0
  ///   - channelId: 频道号
  ///   - type: 消息类型(11.文字, 12.图片, 14.视频, 15.语音)
  ///   - urlOrContent: 图片地址/视频地址/语音地址/文本内容
  ///   - jsonData: 客户端自己用的数据（可选）
  /// 返回数据: code=0表示成功
  static const String sendMsgInLiveRoom = '/user/msg/sendMsgInLiveRoom';

  // ==================== 用户行为埋点 ====================

  /// 查看对方主页埋点
  /// 请求方式: GET
  /// query参数: userId (对方用户id)
  /// 返回数据: code=0表示成功
  static const String saveSeeHome = '/user/user/saveSeeHome';

  // ==================== 访客相关 ====================

  /// 获取访客列表
  /// 请求方式: GET
  /// query参数: size (查询个数，不传返回24小时内的全部)
  /// 返回数据: 访客列表（最新的人查看记录）
  static const String getUserSeeVo = '/user/user/getUserSeeVo';

  // ==================== 聊天记录 ====================

  // ==================== 商品相关 ====================

  /// 获取商品列表
  /// 请求方式: GET
  /// query参数: type (商品类型，1.充值中心，2.快捷弹窗，3.充值VIP)
  /// 返回数据: 商品列表
  static const String getProducts = '/p/product/getProducts';

  /// 按国家获取单个商品
  /// 请求方式: GET
  /// query参数:
  ///   - productId: 商品id（必填）
  ///   - countryCode: 国家编码（必填）
  /// 返回数据: 单个商品详情（包含该国家的支付渠道）
  static const String getCountryProduct = '/p/product/getCountryProduct';

  /// 获取官方支付商品id列表
  /// 请求方式: GET
  /// 返回数据: 商品编码列表
  static const String getProductCodes = '/p/product/getProductCodes';

  // ==================== 订单相关 ====================

  /// 获取订单列表
  /// 请求方式: POST
  /// body参数:
  ///   - pageNum: 第几页
  ///   - pageSize: 每页几条
  ///   - condition: 查询条件（可选）
  ///     - productType: 商品类型（1.普通，2.折扣，3.vip，不传查询全部）
  ///     - orderStatus: 订单状态（0.待支付，1.已支付，2.已退款，3.已关闭，不传查询全部）
  /// 返回数据: 分页订单列表
  static const String getOrderList = '/p/order/getOrderList';

  /// 批量获取订单状态
  /// 请求方式: POST
  /// body参数:
  ///   - orderNos: 订单号列表
  /// 返回数据: 订单状态列表
  static const String getOrderStatusBatch = '/p/order/getOrderStatusBatch';

  /// 充值（下单）
  /// 请求方式: POST
  /// 请求头: s-time(时间戳), s-sign(签名)
  /// body参数:
  ///   - ppId: 支付渠道id（必填）
  ///   - productId: 商品id（必填）
  ///   - anchorUserId: 引导充值的主播（可选）
  ///   - couponRecordId: 优惠券记录id（可选）
  ///   - videoId: 充值转化的虚拟视频id（可选）
  ///   - createPath: 下单路径（可选）
  ///   - gameRoomId: 游戏房间ID（可选）
  ///   - paymentToken: payermax支付token（可选）
  ///   - sessionKey: payermax会话密钥（可选）
  /// 返回数据: 订单信息（含支付链接）
  static const String createOrder = '/p/order/createOrder';

  /// Apple支付回调（服务端回调）
  /// 请求方式: POST
  /// 说明: Apple服务器在支付完成后会自动调用此接口通知服务端
  /// 客户端无需调用此接口，由Apple服务器直接回调服务端
  /// body参数: Apple支付收据数据（具体结构参考Apple官方文档）
  static const String applePay = '/p/notify/applePay';

  /// Google支付回调（服务端回调）
  /// 请求方式: POST
  /// 说明: Google服务器在支付完成后会自动调用此接口通知服务端
  /// 客户端无需调用此接口，由Google服务器直接回调服务端
  /// body参数: Google支付购买数据（具体结构参考Google官方文档）
  static const String googlePay = '/p/notify/googlePay';

  // ==================== 优惠券相关 ====================

  /// 获取待领取的优惠券
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 可领取的优惠券列表
  /// 说明: 获取用户可领取的优惠券
  static const String getNewCoupon = '/p/coupon/getNewCoupon';

  /// 领取优惠券
  /// 请求方式: POST
  /// 路径参数: couponId (优惠券id)
  /// 返回数据: 无
  /// 说明: 领取指定优惠券
  static const String takeCoupon = '/p/coupon/takeCoupon';

  /// 查询用户优惠券
  /// 请求方式: GET
  /// query参数: available (是否可用，0.不可用，1.可用)
  /// 返回数据: 用户优惠券列表
  /// 说明: 查询用户已领取的优惠券
  static const String getUserCoupons = '/p/coupon/getUserCoupons';

  /// 获取商品列表附带优惠券
  /// 请求方式: GET
  /// query参数: type (1.充值中心，2.快捷弹窗，3.充值VIP)
  /// 返回数据: 带优惠券的商品列表
  /// 说明: 获取商品列表，同时返回可用于该商品的优惠券
  static const String getProductsWithCoupon = '/p/product/getProductsWithCoupon';

  /// 获取中奖商品
  /// 请求方式: GET
  /// query参数: whichOne (第几个商品)
  /// 返回数据: 中奖商品详情
  /// 说明: 获取指定位置的中奖商品信息
  static const String getLotteryProduct = '/p/product/getLotteryProduct';

  /// 获取分次订单领取记录
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 分次订单领取记录
  /// 说明: 获取分次订单的分次领取记录
  static const String getSplitOrder = '/p/order/getSplitOrder';

  /// 领取分次订单奖励
  /// 请求方式: POST
  /// 参数: 无
  /// 返回数据: null
  /// 说明: 领取当前可领取的分次订单奖励
  static const String takeSplitReward = '/p/order/takeSplitReward';

  /// 主播索要充值
  /// 请求方式: POST
  /// Body参数: userId (用户id)
  /// 返回数据: { content: 索要文案 }
  /// 说明: 主播向用户索要充值，返回索要文案
  static const String begRecharge = '/user/beg/begRecharge';

  /// 获取降档营销配置
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 降档营销配置
  /// 说明: 获取降档营销的浏览次数和轮次配置
  static const String getDowngradeConfig = '/p/downgrade/getConfig';

  /// 获取降档营销商品
  /// 请求方式: GET
  /// query参数: roundNo (第几轮)
  /// 返回数据: 降档营销商品详情
  /// 说明: 获取指定轮次的降档营销商品
  static const String getDowngradeProduct = '/p/product/getDowngradeProduct';

  /// 获取金币商城
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 金币商城商店列表
  /// 说明: 获取可用金币兑换钻石的商店列表
  static const String getStores = '/p/exchangeStore/getStores';

  /// 兑换钻石
  /// 请求方式: POST
  /// Body参数: storeId (商店id)
  /// 返回数据: null
  /// 说明: 使用金币兑换钻石
  static const String exchangeDiamonds = '/p/exchangeStore/exchangeDiamonds';

  /// payerMax前置组件初始化
  /// 请求方式: POST
  /// Body参数: uid (用户id), orderNo (系统订单号)
  /// 返回数据: payerMax初始化密钥
  /// 说明: payerMax支付前置组件初始化，返回clientKey和sessionKey
  static const String createPayerMaxKey = '/p/order/createPayerMaxKey';

  /// h5页面payerMax充值
  /// 请求方式: POST
  /// Body参数: uid (用户id), orderNo (系统订单号), paymentToken (payerMax支付token), sessionKey (payerMax sessionKey)
  /// 返回数据: payerMax密钥
  /// 说明: h5页面完成payerMax支付后调用，返回新的clientKey和sessionKey
  static const String createPayerMaxOrder = '/p/order/createPayerMaxOrder';

  /// 查询订单简要信息
  /// 请求方式: POST
  /// Body参数: pageNum (页码), pageSize (每页条数), condition (查询条件)
  /// 返回数据: 订单简要信息分页列表
  /// 说明: 查询用户的订单简要信息列表
  static const String getOrderSimpleList = '/p/order/getOrderSimpleList';

  // ==================== 应用配置 ====================
  
  /// 应用配置
  /// 请求方式: GET
  /// 返回数据: 应用配置信息,包含签名密钥等
  /// 说明: 获取应用配置,需要先调用此接口获取签名key
  /// 重要: 返回数据中的 ok 字段作为签名密钥使用
  static const String appConfig = '/system/app/getConfig';

  /// 客户端获取aiHelp菜单
  /// 请求方式: POST
  /// 参数:
  ///   - lang: 语言（可选）
  /// 返回数据: AI Help菜单列表
  /// 说明: 客户端获取aiHelp菜单
  static const String getAiHelpConfigList = '/system/aiHelp/getConfigList';

  /// 获取aiHelp记录
  /// 请求方式: POST
  /// 参数:
  ///   - lang: 语言（可选）
  /// Body参数:
  ///   - userId: 用户id（必填）
  /// 返回数据: AI Help记录列表
  /// 说明: 获取aiHelp记录
  static const String getAiHelpRecords = '/system/aiHelp/getAiHelpRecords';

  /// 保存aiHelp表单或者聊天数据
  /// 请求方式: POST
  /// Body参数:
  ///   - userId: 用户id（必填）
  ///   - contentType: 内容类型（必填）: 1-文本,2-表单-尚未收到付款,3-表单-付款方式,4-表单-问题反馈,5-投诉主播
  ///   - content: 消息内容（必填）
  /// 返回数据: 是否保存成功
  /// 说明: 保存aiHelp表单或者聊天数据
  static const String saveAiHelpRecord = '/system/aiHelp/saveAiHelpRecord';

  // ==================== 系统相关 ====================

  /// 获取地区列表
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 地区列表
  /// 说明: 获取所有可用地区信息，包含地区编码、名称、主播数、头像等
  static const String getAreas = '/system/country/getAreas';

  /// 获取AI配置
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: AI配置列表
  /// 说明: 获取AI配置信息，包含各种触发条件和次数限制
  static const String getAiConfigs = '/system/ai/getAiConfigs';

  /// 按国家获取银行渠道列表
  /// 请求方式: GET
  /// query参数: countryCode (国家编码)
  /// 返回数据: 银行渠道列表
  /// 说明: 获取指定国家的可用收款渠道
  static const String getPayoutChannels = '/system/bank/getPayoutChannels';

  /// 获取标签配置
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 标签配置列表
  /// 说明: 获取所有可用标签配置信息
  static const String getTagConfigs = '/system/app/getTagConfigs';

  /// 获取广告列表
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 广告列表数据（包含list字段）
  /// 说明: 获取所有广告配置信息
  static const String getAdvertisement = '/system/app/getAdvertisement';

  /// IP和语言检测
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 0-检测不通过，1-检测通过
  /// 说明: 检测用户IP和语言是否合规，可登录可不登录
  static const String checkRegion = '/system/app/checkRegion';

  /// 获取招呼话术列表
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 话术字符串列表
  /// 说明: 获取所有可用的招呼话术
  static const String getAigConfigs = '/system/ai/getAigConfigs';

  /// 获取敏感词库V2
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 敏感词列表
  /// 说明: 获取敏感词库，包含引流词、私聊敏感词、公聊敏感词
  static const String getSensitiveWordsV2 = '/system/sensitive/getSensitiveWordsV2';

  /// 获取通话记录
  /// 请求方式: POST
  /// Body参数:
  ///   - condition.callTypes: 唤起方式列表 [0.正常唤起,1.AIB唤起,2.匹配唤起,3.主播邀请,4.主播免费邀请,5.免费匹配]
  ///   - condition.callType: 唤起方式（可选）
  ///   - condition.callFlag: 通话标志，0.未接，1.已接（可选）
  ///   - pageNum: 页码（必填）
  ///   - pageSize: 每页条数（必填）
  /// 返回数据: 通话记录分页列表
  /// 说明: 分页查询用户的通话记录
  static const String getCallRecordVoList = '/call/call/getCallRecordVoList';

  /// 通话结束是否可打标签
  /// 请求方式: POST
  /// Body参数:
  ///   - channelId: 通话频道id（必填）
  /// 返回数据:
  ///   - isTagCall: 是否可打标签
  ///   - tags: 标签列表
  ///     * id: 标签id
  ///     * classifyId: 分类id
  ///     * title: 分类名
  ///     * tagValue: 标签值
  ///     * tagType: 标签类型
  ///     * tagImg: 标签图片
  /// 说明: 查询通话结束后是否可以给该通话打标签
  static const String isTagCall = '/call/call/isTagCall';

  /// 通话结束打标签
  /// 请求方式: POST
  /// Body参数:
  ///   - channelId: 通话频道id（必填）
  ///   - tagId: 标签ID（必填）
  /// 返回数据: 无
  /// 说明: 通话结束后给主播打标签
  static const String tagCall = '/call/call/tagCall';

  /// 上报通话质量
  /// 请求方式: POST
  /// Body参数:
  ///   - channelId: 频道id（必填）
  ///   - rxQuality: 接收质量（必填）
  ///   - time: 时间，毫秒数（必填）
  ///   - txQuality: 发送质量（必填）
  ///   - isRemote: 是否是对方，0.自己，1.对方（必填）
  /// 返回数据: 无
  /// 说明: 上报通话质量数据用于监控分析
  static const String reportCall = '/call/call/reportCall';

  /// 查询对方免费邀请通话相关信息
  /// 请求方式: GET
  /// query参数: userId (用户id)
  /// 返回数据:
  ///   - freeInviteSeconds: 免费邀请通话的免费时长，单位秒
  ///   - freeInviteCountLimit: 免费邀请通话次数上限
  ///   - freeInviteLeftCount: 免费邀请通话剩余次数
  /// 说明: 获取指定用户可用的免费邀请通话信息
  static const String getFreeInviteCallInfo = '/call/call/getFreeInviteCallInfo';

  /// 获取违规处罚配置
  /// 请求方式: GET
  /// Body参数: 无
  /// 返回数据:
  ///   - preFlag: 高频开关，0.关闭，1.打开
  ///   - postFlag: 低频开关，0.关闭，1.打开
  ///   - preRemind: 高频提醒开关，0.关闭，1.打开
  ///   - postRemind: 低频提醒开关，0.关闭，1.打开
  ///   - preDelayCount: 高频通话间隔数量
  ///   - postDelayCount: 低频通话间隔数量
  ///   - preDelaySeconds: 高频检测间隔秒数
  ///   - postDelaySeconds: 低频检测间隔秒数
  ///   - preTotalSeconds: 高频检测秒数
  ///   - remindCount: 提醒次数
  ///   - warnCount: 警告次数
  ///   - banCount: 封禁次数
  ///   - banType: 封禁类型
  ///   - banReason: 封禁理由
  ///   - authDelaySeconds: 重新认证间隔秒数
  ///   - cancelAuthReason: 取消认证理由
  ///   - violateCount: 今日违规次数
  ///   - banMinutes: 封禁分钟数
  ///   - resetDays: 违规重置天数
  /// 说明: 获取通话违规处罚相关配置信息
  static const String getViolationConfig = '/call/violate/getConfig';

  /// 获取违规处罚记录
  /// 请求方式: POST
  /// Body参数:
  ///   - pageNum: 第几页（必填）
  ///   - pageSize: 每页几条（必填）
  ///   - condition: 查询条件（可选）
  ///     - recordType: 处罚类型，1.提醒，2.警告，3.封禁，4.取消认证
  ///     - recordStatus: 申诉状态，0.无申诉，1.申诉中，2.申诉成功，3.申诉失败
  /// 返回数据:
  ///   - list: 违规记录列表
  ///   - pageNum: 当前页码
  ///   - pageSize: 每页条数
  ///   - total: 总记录数
  ///   - hasNextPage: 是否有下一页
  /// 说明: 分页获取违规处罚记录列表
  static const String getViolationRecordPage = '/call/violate/recordPage';

  /// 上传违规处罚记录
  /// 请求方式: POST
  /// Body参数:
  ///   - channelId: 频道id（必填）
  ///   - recordSeconds: 通话多少秒时违规（必填）
  ///   - screenshotUrl: 违规截图（可选）
  /// 返回数据:
  ///   - violateType: 处罚类型，1.提醒，2.警告，3.封禁，4.取消认证
  ///   - violateCount: 违规次数
  /// 说明: 上报违规处罚记录信息
  static const String uploadViolationRecord = '/call/violate/uploadRecord';

  /// 主播答题重新认证
  /// 请求方式: POST
  /// Body参数: 无
  /// 返回数据: 无
  /// 说明: 主播通过答题重新获取认证资格
  static const String reAuth = '/call/violate/reAuth';

  /// 获取挂机检测配置
  /// 请求方式: GET
  /// Body参数: 无
  /// 返回数据:
  ///   - hangupType: 挂机类型，1.正常模式，2.匹配模式
  ///   - delaySeconds: 检测间隔，单位秒
  ///   - closeSeconds: 关闭弹窗时间，单位秒
  ///   - dailyBegin: 每日开始时间，格式HH:mm
  ///   - dailyEnd: 每日结束时间，格式HH:mm
  /// 说明: 获取通话挂机检测相关配置信息
  static const String getHangupConfigs = '/call/hangup/getConfigs';

  /// 获取挂机记录
  /// 请求方式: POST
  /// Body参数:
  ///   - pageNum: 第几页（必填）
  ///   - pageSize: 每页几条（必填）
  ///   - condition: 查询条件（可选）
  ///     - hangupType: 挂机类型，1.正常模式，2.匹配模式，3.连续超时挂断
  /// 返回数据:
  ///   - list: 挂机记录列表
  ///   - pageNum: 当前页码
  ///   - pageSize: 每页条数
  ///   - total: 总记录数
  ///   - hasNextPage: 是否有下一页
  /// 说明: 分页获取挂机记录列表
  static const String getHangupRecordPage = '/call/hangup/recordPage';

  /// 上传挂机记录
  /// 请求方式: POST
  /// Body参数:
  ///   - hangupType: 挂机类型，1.正常模式，2.匹配模式，3.连续超时挂断（必填）
  /// 返回数据: 无
  /// 说明: 上报用户挂机行为记录
  static const String uploadHangupRecord = '/call/hangup/uploadRecord';

  /// 获取对方的简要信息
  /// 请求方式: GET
  /// query参数: userId (用户id)
  /// 返回数据: 用户简要信息
  /// 说明: 获取指定用户的简要信息，包含昵称、头像、等级等
  static const String getUserSimple = '/user/user/getUserSimple';

  /// 获取用户是否在线
  /// 请求方式: POST
  /// Body参数:
  ///   - userIds: 用户ID列表
  /// 返回数据: 用户在线状态列表
  /// 说明: 批量查询用户的在线状态
  static const String getIsOnlines = '/user/user/getIsOnlines';

  /// 获取等级区间详情
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 等级配置列表及当前总经验值
  /// 说明: 获取所有等级的配置信息
  static const String getLevelInfoConfigs = '/user/level/getLevelInfoConfigs';

  /// 获取高级用户弹窗接口
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 高级用户弹窗信息
  /// 说明: 获取高级用户的奖励信息和弹窗状态
  static const String getDialogDetail = '/user/advance/getDialogDetail';

  // ==================== 第三方账号绑定相关 ====================

  /// 绑定谷歌账号
  /// 请求方式: POST
  /// Body参数:
  ///   - id: 谷歌openId（必填）
  ///   - nickname: 昵称（可选）
  ///   - cover: 头像（可选）
  ///   - token: 登录token（可选）
  ///   - email: 邮箱（可选）
  /// 返回数据: code=0成功，code=1018表示谷歌账号已被其他账号绑定
  /// 说明: 将Google账号绑定到当前登录用户
  static const String bindGoogle = '/user/user/bindGoogle';

  /// 账号密码登录
  /// 请求方式: POST
  /// Body参数:
  ///   - username: 用户名（必填）
  ///   - password: 加密后的密码（必填）
  ///   - aidLimit: 是否限制广告id获取，0.未限制，1.限制获取（可选）
  ///   - aid: 广告id（可选）
  /// 返回数据: 登录响应数据（与游客登录一致）
  /// 说明: 使用用户名和密码登录
  /// 需要签名: 是
  static const String passwordLogin = '/user/login/password';

  // ==================== 关注相关 ====================

  /// 关注对方
  /// 请求方式: POST
  /// 路径参数:
  ///   - followUserId: 被关注的用户ID（必填）
  /// Body参数:
  ///   - inLiveRoom: 是否直播间内关注，0.否，1.是（可选）
  /// 返回数据:
  ///   - 0: 双方都未关注
  ///   - 1: 我未关注&对方已回关
  ///   - 2: 我已关注&对方未回关
  ///   - 3: 好友
  /// 说明: 关注指定用户，返回关注后的关系状态
  static const String saveUserFollow = '/user/follow/saveUserFollow';

  /// 取消关注
  /// 请求方式: POST
  /// 路径参数:
  ///   - followUserId: 被取消关注的用户ID（必填）
  /// 返回数据:
  ///   - true: 取消成功
  /// 说明: 取消对指定用户的关注
  static const String removeUserFollow = '/user/follow/removeUserFollow';

  /// 获取好友/好友请求/我的关注列表
  /// 请求方式: POST
  /// Body参数:
  ///   - type: 列表类型（必填）
  ///     * 1.好友列表
  ///     * 2.好友请求列表
  ///     * 3.我的关注列表
  ///   - pageNum: 页码（必填）
  ///   - pageSize: 每页条数（必填）
  /// 返回数据: 分页用户列表
  /// 说明: 获取用户的好友、好友请求或关注列表
  static const String getFollowList = '/user/follow/getFollowList';

  /// 获取好友/好友请求/我的关注列表V2版本
  /// 请求方式: POST
  /// Body参数:
  ///   - type: 列表类型（必填）
  ///     * 1.好友列表
  ///     * 2.好友请求列表
  ///     * 3.我的关注列表（关注&&粉丝 => 自己没关注对方）
  ///   - pageNum: 页码（必填）
  ///   - pageSize: 每页条数（必填）
  /// 返回数据: 分页用户列表V2版本
  /// 说明: V2版本增加了inLiveRoom和roomId字段
  static const String getFollowListV2 = '/user/follow/getFollowListV2';

  // ==================== 黑名单相关 ====================

  /// 拉黑用户
  /// 请求方式: POST
  /// 路径参数:
  ///   - blackUserId: 被拉黑的用户ID（必填）
  /// 返回数据:
  ///   - true: 拉黑成功
  /// 说明: 将指定用户加入黑名单
  static const String saveBlack = '/user/blacklist/saveBlack';

  /// 取消拉黑
  /// 请求方式: POST
  /// 路径参数:
  ///   - blackUserId: 被取消拉黑的用户ID（必填）
  /// 返回数据:
  ///   - true: 取消拉黑成功
  /// 说明: 将指定用户从黑名单中移除
  static const String removeBlack = '/user/blacklist/removeBlack';

  /// 获取拉黑列表
  /// 请求方式: POST
  /// Body参数:
  ///   - pageNum: 页码（必填）
  ///   - pageSize: 每页条数（必填）
  /// 返回数据: 分页黑名单用户列表
  /// 说明: 获取当前用户的黑名单列表
  static const String getBlackList = '/user/blacklist/getBlackList';

  // ==================== 喜欢相关 ====================

  /// 喜欢对方
  /// 请求方式: POST
  /// 路径参数:
  ///   - likeUserId: 被喜欢的用户ID（必填）
  /// 返回数据:
  ///   - 0: 喜欢成功
  /// 说明: 对指定用户表示喜欢
  static const String saveUserLike = '/user/like/saveUserLike';

  /// 取消喜欢对方
  /// 请求方式: POST
  /// 路径参数:
  ///   - likeUserId: 被取消喜欢的用户ID（必填）
  /// 返回数据:
  ///   - 0: 取消成功
  /// 说明: 取消对指定用户的喜欢
  static const String removeUserLike = '/user/like/removeUserLike';

  /// 获取关系请求数值
  /// 请求方式: GET
  /// query参数:
  ///   - userId: 用户ID（必填）
  /// 返回数据: 关注数、被关注数、喜欢数等关系数据
  /// 说明: 获取指定用户的关系数据，包括关注数、被关注数、喜欢数等
  static const String getRelationCount = '/user/user/getRelationCount';

  /// 获取好友请求数值
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据:
  ///   - 好友请求数量
  /// 说明: 获取当前用户未处理的好友请求数量
  static const String getFollowCount = '/user/follow/getFollowCount';

  /// 获取我的喜欢列表
  /// 请求方式: POST
  /// Body参数:
  ///   - condition.type: 列表类型（必填）
  ///     * 1. 我喜欢的
  ///     * 2. 喜欢我的
  ///   - pageNum: 页码（必填）
  ///   - pageSize: 每页条数（必填）
  /// 返回数据: 喜欢列表分页数据
  /// 说明: 获取我喜欢的人或喜欢我的人的列表
  static const String getLikeList = '/user/like/getLikeList';

  /// 更新喜欢状态
  /// 请求方式: POST
  /// Body参数:
  ///   - likeMeUserIds: 喜欢我的人用户ID列表（必填）
  ///   - stat: 状态（必填）
  ///     * 1. 忽略
  ///     * 2. 回喜欢
  /// 返回数据: 0表示成功
  /// 说明: 批量更新喜欢我的人的状态
  static const String updateLikeStat = '/user/like/updateLikeStat';

  // ==================== 表情包相关 ====================

  /// 获取系统表情包
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 表情包列表
  /// 说明: 获取表情包列表，每个表情包包含解锁等级和表情列表
  static const String getCommonPackages = '/user/sticker/getCommonPackages';

  // ==================== 心动等级相关 ====================

  /// 获取心动等级区间详情
  /// 请求方式: GET
  /// query参数: otherUserId (对方用户ID)
  /// 返回数据: 心动等级详情
  /// 说明: 获取与指定用户的心动等级详情，包含当前心动值、等级、勋章等
  static const String getHeartbeatLevelInfo = '/user/heartbeatLevel/getLevelInfoConfigs';

  /// 主播获取心动用户列表
  /// 请求方式: POST
  /// Body参数:
  ///   - pageNum: 第几页（必填）
  ///   - pageSize: 每页几条（必填）
  /// 返回数据: 分页心动用户列表
  /// 说明: 主播获取对自己有心动值的用户列表
  static const String getHeartbeatUsers = '/user/heartbeatLevel/getHeartbeatUsers';

  /// 批量查询主播心动信息
  /// 请求方式: POST
  /// Body参数:
  ///   - otherUserIdList: 主播ID列表（必填）
  /// 返回数据: 主播心动信息列表
  /// 说明: 批量查询多个主播的心动值、在线状态、直播状态
  static const String getHeartbeatAnchorsV2 = '/user/heartbeatLevel/getHeartbeatAnchorsV2';

  /// 获取心动等级规则列表
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 心动等级规则列表
  /// 说明: 获取心动等级的规则说明列表
  static const String getHeartbeatRuleList = '/user/heartbeatLevel/getRuleList';

  /// 批量获取主播心动值
  /// 请求方式: POST
  /// Body参数:
  ///   - otherUserIdList: 主播ID列表（必填）
  /// 返回数据: 主播心动值列表
  /// 说明: 批量查询多个主播的心动值和心动等级
  static const String batchGetHeartbeatValues = '/user/heartbeatLevel/batchGetHeartbeatValues';

  /// 用户获取心动主播列表
  /// 请求方式: POST
  /// Body参数:
  ///   - pageNum: 第几页（必填）
  ///   - pageSize: 每页几条（必填）
  /// 返回数据: 分页心动主播列表
  /// 说明: 获取用户关注的主播中，有心动值的主播列表
  static const String getHeartbeatList = '/user/heartbeatLevel/getHeartbeatList';

  /// 获取心动等级配置
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 心动等级配置
  /// 说明: 获取心动等级的配置信息，包含礼物比例和等级配置列表
  static const String getHeartbeatConfig = '/user/heartbeatLevel/getConfig';

  /// 用户获取常驻心动主播
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 常驻心动主播列表
  /// 说明: 获取用户关注的常驻心动主播列表
  static const String getFixHeartbeatAnchors = '/user/heartbeatLevel/getFixHeartbeatAnchors';

  /// 主播获取常驻心动用户
  /// 请求方式: GET
  /// 参数: 无
  /// 返回数据: 常驻心动用户列表
  /// 说明: 主播视角获取对自己有心动值的常驻用户列表
  static const String getFixHeartbeatUsers = '/user/heartbeatLevel/getFixHeartbeatUsers';

  /// 获取标签列表
  /// 请求方式: POST
  /// 参数: 无
  /// 返回数据: 标签列表
  /// 说明: 获取话题标签列表，包含用户关注状态
  static const String listTopicTag = '/topia/listTopicTag';

  /// 关注标签/调整标签顺序
  /// 请求方式: POST
  /// 参数:
  ///   - tagId: 标签id（必填）
  ///   - sort: 顺序（必填）
  /// 返回数据: 无
  /// 说明: 关注某个标签或调整标签的排序顺序
  static const String followTopicTag = '/topia/followTopicTag';

  /// 发布动态
  /// 请求方式: POST
  /// 参数:
  ///   - content: 动态内容（必填）
  ///   - topicIds: 话题id列表（必填）
  ///   - medias: 媒体列表（可选）
  ///     - fingerPrint: 指纹
  ///     - imageHeight: 图片高度
  ///     - imageWidth: 图片宽度
  ///     - mediaUrl: 媒体URL
  ///     - videoCover: 视频封面
  /// 返回数据: 无
  /// 说明: 发布新的动态
  static const String publish = '/topia/publish';

  /// 获取话题列表
  /// 请求方式: POST
  /// 参数:
  ///   - tagId: 标签id
  ///   - order: 排序方式（0热门，1最新）
  ///   - pageNum: 页码
  ///   - pageSize: 每页数量
  /// 返回数据: 话题分页列表
  /// 说明: 获取话题列表，包含每个话题的动态信息
  static const String pageTopic = '/topia/pageTopic';

  /// 获取动态列表
  /// 请求方式: POST
  /// 参数:
  ///   - topicId: 主题id（必填）
  ///   - order: 排序方式（0热门，1最新）
  ///   - pageNum: 页码
  ///   - pageSize: 每页数量
  /// 返回数据: 动态分页列表
  /// 说明: 获取某个话题下的动态列表
  static const String pageTopicMoment = '/topia/pageTopicMoment';

  /// 点赞动态/评论
  /// 请求方式: POST
  /// 参数:
  ///   - momentId: 动态ID（必填）
  ///   - commentId: 评论ID（必填，0表示点赞动态）
  /// 返回数据: 无
  /// 说明: 对动态或评论进行点赞
  static const String praise = '/topia/praise';

  /// 取消点赞动态/评论
  /// 请求方式: POST
  /// 参数:
  ///   - momentId: 动态ID（必填）
  ///   - commentId: 评论ID（必填，0表示取消点赞动态）
  /// 返回数据: 无
  /// 说明: 取消对动态或评论的点赞
  static const String praiseCancel = '/topia/praiseCancel';

  /// 评论/回复
  /// 请求方式: POST
  /// 参数:
  ///   - momentId: 动态ID（必填）
  ///   - replyCommentId: 回复的评论ID（评论动态时不用传）
  ///   - content: 评论内容（必填）
  /// 返回数据: 评论ID
  /// 说明: 对动态进行评论或回复其他评论
  static const String comment = '/topia/comment';

  /// 获取评论列表
  /// 请求方式: POST
  /// 参数:
  ///   - momentId: 动态ID（必填）
  ///   - pageNum: 页码
  ///   - pageSize: 每页数量
  /// 返回数据: 评论分页列表
  /// 说明: 获取某个动态下的评论列表
  static const String pageComments = '/topia/pageComments';

  /// 创建直播间开始直播
  /// 请求方式: POST
  /// 参数:
  ///   - title: 房间标题（必填）
  ///   - notice: 房间公告
  ///   - coverUrl: 封面地址
  ///   - gameCode: 游戏编码
  /// 返回数据: 直播间信息
  /// 说明: 创建直播间并开始直播，返回1043错误码表示直播间游戏挂载人数已满
  static const String roomCreate = '/live/room/create';

  /// 用户点赞
  /// 请求方式: POST
  /// 参数:
  ///   - roomId: 房间ID（必填）
  /// Body参数:
  ///   - count: 连点次数（必填）
  /// 返回数据: 无
  /// 说明: 用户对直播间进行点赞
  static const String roomLike = '/live/room/like/{roomId}';

  /// 获取直播间详细信息
  /// 请求方式: GET
  /// 参数:
  ///   - roomId: 房间id（必填）
  /// 返回数据: 直播间详细信息
  /// 说明: 获取指定直播间的详细信息
  static const String roomGetDetail = '/live/room/getDetail';

  /// 修改直播间信息
  /// 请求方式: POST
  /// 路径参数:
  ///   - roomId: 房间ID（必填）
  /// Body参数:
  ///   - title: 房间标题
  ///   - notice: 房间公告
  ///   - coverUrl: 封面地址
  /// 返回数据: 无
  /// 说明: 修改指定直播间的信息
  static const String roomUpdate = '/live/room/update/{roomId}';

  /// 结束直播
  /// 请求方式: POST
  /// 参数:
  ///   - roomId: 房间ID（必填）
  /// 返回数据: 直播结束统计信息
  /// 说明: 结束指定直播间的直播
  static const String roomEnd = '/live/room/end/{roomId}';

  /// 恢复直播
  /// 请求方式: POST
  /// 参数:
  ///   - roomId: 房间ID（必填）
  /// 返回数据: 无
  /// 说明: 恢复暂停的直播
  static const String roomResume = '/live/room/resume/{roomId}';

  /// 暂停直播
  /// 请求方式: POST
  /// 参数:
  ///   - roomId: 房间ID（必填）
  /// 返回数据: 无
  /// 说明: 暂停直播
  static const String roomPause = '/live/room/pause/{roomId}';

  /// 用户加入直播间
  /// 请求方式: POST
  /// 参数:
  ///   - roomId: 房间ID（必填）
  /// 返回数据: 无
  /// 说明: 用户加入直播间
  static const String roomJoin = '/live/room/join/{roomId}';

  /// 用户离开直播间
  /// 请求方式: POST
  /// 参数:
  ///   - roomId: 房间ID（必填）
  /// 返回数据: 无
  /// 说明: 用户离开直播间
  static const String roomLeave = '/live/room/leave/{roomId}';

  /// 分页查询直播间列表
  /// 请求方式: POST
  /// body参数:
  ///   - pageNum: 页码（必填）
  ///   - pageSize: 每页条数（必填）
  ///   - condition: 查询条件（必填）
  ///     - roomType: 房间类型（可选）
  ///     - areaCode: 地区编码（可选）
  /// 返回数据: 直播间列表分页数据
  /// 说明: 分页查询直播间列表
  static const String getLiveRoomList = '/live/room/getList';

  /// 获取直播间topN用户
  /// 请求方式: GET
  /// 参数:
  ///   - roomId: 房间id（必填）
  ///   - size: 要获取的用户个数（必填）
  /// 返回数据: Top用户列表
  /// 说明: 获取直播间topN用户
  static const String getTopUsers = '/live/room/getTopUsers';

  /// 主播发送直播间心跳
  /// 请求方式: POST
  /// 参数:
  ///   - roomId: 房间ID（必填）
  /// 返回数据: 无
  /// 说明: 主播发送直播间心跳
  static const String roomHeartbeat = '/live/room/heartbeat/{roomId}';

  /// 主播设置直播中可接收电话
  /// 请求方式: POST
  /// 参数:
  ///   - roomId: 房间ID（必填）
  /// 返回数据: 无
  /// 说明: 主播设置直播中可接收电话
  static const String roomOpenCall = '/live/room/openCall/{roomId}';

  /// 主播设置直播中不接收电话
  /// 请求方式: POST
  /// 参数:
  ///   - roomId: 房间ID（必填）
  /// 返回数据: 无
  /// 说明: 主播设置直播中不接收电话
  static const String roomCloseCall = '/live/room/closeCall/{roomId}';
}
