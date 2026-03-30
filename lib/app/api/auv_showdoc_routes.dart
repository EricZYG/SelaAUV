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
abstract class AuvShowDocRoutes {
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
  static const String guestLogin = '/user/login/guest';

  /// 手机号登录
  /// 请求方式: POST
  /// 请求参数: phone (手机号), code (验证码)
  /// 说明: 使用手机号和验证码登录
  static const String phoneLogin = '/user/login/phone';

  /// 谷歌登录
  /// 请求方式: POST
  /// 请求参数: id_token (Google ID Token)
  /// 说明: 使用Google账号登录
  static const String googleLogin = '/user/login/google';

  /// 苹果登录
  /// 请求方式: POST
  /// 请求参数: identity_token (Apple Identity Token), authorization_code (授权码,可选), name (用户名称,可选)
  /// 说明: 使用Apple ID登录
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

  // ==================== 送礼相关 ====================

  /// 赠送礼物(真实礼物)
  /// 请求方式: POST
  /// 请求参数: gift_id (礼物ID), anchor_id (主播ID), room_id (直播间ID), num (数量)
  /// 返回数据: 送礼结果,包含扣除钻石数,剩余余额等
  /// 说明: 在直播间向主播赠送真实礼物
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
  /// 路径参数: type (0:普通通话, 1:AIB通话, 2:匹配通话), targetUserId (目标用户ID)
  /// 返回数据: 频道信息
  /// 说明: 创建与目标用户的通话频道
  static const String createCallChannel = '/call/call/createCall';

  /// 加入通话聊天室
  /// 请求方式: POST
  /// 路径参数: channelId (频道ID)
  /// 返回数据: 聊天室信息(含IMToken)
  /// 说明: 用户加入指定的通话聊天室
  static const String joinCallChannel = '/call/call/joinCall';

  /// 用户通话续费
  /// 请求方式: POST
  /// 路径参数: channelId (频道ID)
  /// 返回数据: RTC Token
  /// 说明: 刷新/续期通话频道的RTC令牌
  static const String refreshCall = '/call/call/refreshCall';

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

  /// 分页查询聊天记录
  /// 请求方式: GET
  /// query参数:
  ///   - otherUserId: 对方用户id（选填）
  ///   - offsetId: 偏移id，初始不传，后续传上次记录列表中的最后一个元素的id
  ///   - pageSize: 每页条数
  /// 返回数据: 聊天记录列表
  static const String getMsgRecords = '/user/msg/getMsgRecords';

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
  static const String appConfig = '/app/config';

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
  ///   - condition.callTypes: 唤起方式列表 [0,1,2,3,4,5] (可选)
  ///   - pageNum: 页码
  ///   - pageSize: 每页条数
  /// 返回数据: 通话记录分页列表
  /// 说明: 分页查询用户的通话记录
  static const String getCallRecordVoList = '/call/call/getCallRecordVoList';

  /// 通话结束是否可打标签
  /// 请求方式: POST
  /// Body参数:
  ///   - channelId: 通话频道id
  /// 返回数据: 是否可打标签及标签列表
  /// 说明: 查询通话结束后是否可以给该通话打标签
  static const String isTagCall = '/call/call/isTagCall';

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
}
