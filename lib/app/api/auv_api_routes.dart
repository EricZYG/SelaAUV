/// API 路由配置
abstract class AuvApiRoutes {
  // ========== 认证相关 ==========
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  /// 游客登录 (新版)
  static const String guestLogin = '/user/login/guest';
  /// 游客登录 (旧版，兼容)
  static const String visitorLogin = '/auth/visitor';
  static const String googleLogin = '/auth/google';

  // ========== 用户相关 ==========
  static const String checkUserDetail = '/user/user/checkUserDetail';
  static const String userInfo = '/user/info';
  static const String setUserAlias = '/user/userAlias/setAlias';
  static const String updateSexDetail = '/user/user/updateSexDetail';
  static const String getRewards = '/user/user/getRewards';
  static const String getDiamondRanking = '/user/user/getDiamondRanking';
  static const String getFKUsers = '/user/anchor/getFKUsers';
  static const String updateSexMale = '/user/user/updateSexMale';
  static const String updateUserInfo = '/user/update';
  static const String uploadAvatar = '/user/avatar';
  static const String getUserPropVo = '/user/prop/getUserPropVo';
  static const String getUserBalanceRecords = '/user/balance/getUserBalanceRecords';
  static const String updateFirebaseToken = '/user/user/updateFirebaseToken';
  static const String updateAdFlag = '/user/user/updateAdFlag';
  static const String deleteUser = '/user/user/deleteUser';
  static const String getUserSimple = '/user/user/getUserSimple';
  static const String getUserExpand = '/user/user/getUserExpand';
  static const String getUserExpandNoLogin = '/user/user/getUserExpandNoLogin';
  static const String getUserExpandV2 = '/user/user/getUserExpandV2';
  static const String getAnchorExpandV2 = '/user/user/getAnchorExpandV2';
  static const String getUsers = '/user/user/getUsers';

  // ========== 举报/反馈 ==========
  static const String feedbackSave = '/user/feedback/save';

  // ========== 动态相关 ==========
  static const String publishMoment = '/user/userMoment/publish';
  /// 评论动态
  static const String commentMoment = '/user/anchorMoment/comment';
  /// 取消点赞动态/评论
  static const String praiseCancel = '/user/anchorMoment/praiseCancel';
  /// 获取动态通知列表
  static const String getNotices = '/user/anchorMoment/getNotices';
  /// 获取最后一条动态通知
  static const String getLastNotice = '/user/anchorMoment/getLastNotice';
  /// 用户端查主播动态V2
  static const String userGetMomentV2 = '/user/anchorMoment/userGetMomentV2';
  /// 用户端查主播hot动态V3
  static const String userGetHotMoment = '/user/anchorMoment/userGetHotMoment';
  /// 获取流量最高的动态
  static const String getTopShowMoment = '/user/anchorMoment/getTopShowMoment';
  /// 删除动态
  static const String deleteMoment = '/user/anchorMoment/delete';
  /// 查单个主播动态附带第一页评论
  static const String getOneMomentWithComment = '/user/anchorMoment/getOneMomentWithComment';

  // ========== 密码相关 ==========
  static const String changePassword = '/user/user/changePassword';
  static const String setPassword = '/user/user/setPassword';

  // ========== 用户在线状态 ==========
  static const String getIsOnlines = '/user/user/getIsOnlines';

  // ========== 随机头像 ==========
  static const String getPortraits = '/user/user/getPortraits';

  // ========== 账号注销 ==========
  static const String logoffDeleteUserByPassword = '/user/logoff/deleteUserByPassword';

  // ========== App评分 ==========
  static const String updateAppRateScore = '/user/user/updateAppRateScore';

  // ========== 高级用户相关 ==========
  static const String getDialogDetail = '/user/advance/getDialogDetail';

  // ========== 邀请相关 ==========
  static const String isHasInviteRecord = '/user/user/isHasInviteRecord';
  static const String getInviteUserVoList = '/user/user/getInviteUserVoList';
  static const String getInviteInfo = '/user/user/getInviteInfo';
  static const String bindInviteCode = '/user/user/bindInviteCode';
  static const String getInviteRecord = '/user/user/getInviteRecord';

  // ========== 任务相关 ==========
  static const String getUserTaskList = '/user/task/getUserTaskList';
  static const String claimTaskReward = '/user/task/claimTaskReward';
  static const String userDraw = '/user/task/userDraw';

  // ========== 首页/发现 ==========
  static const String discover = '/discover';
  static const String discoverList = '/discover/list';

  // ========== 匹配相关 ==========
  static const String match = '/match';
  static const String matchStart = '/match/start';
  static const String matchCancel = '/match/cancel';
  static const String matchHistory = '/match/history';

  // ========== 聊天相关 ==========
  static const String chatList = '/chat/list';
  static const String chatHistory = '/chat/history';
  static const String sendMessage = '/chat/send';

  // ========== 消息相关 ==========
  /// 发送消息
  static const String sendMsg = '/user/msg/sendMsg';
  /// 通话中发送消息（不校验好友关系也不扣费）
  static const String sendMsgInCall = '/user/msg/sendMsgInCall';
  /// 游戏房间中发送消息
  static const String sendMsgInGameRoom = '/user/msg/sendMsgInGameRoom';

  // ========== 用户行为埋点 ==========
  /// 查看对方主页埋点
  static const String saveSeeHome = '/user/user/saveSeeHome';

  // ========== 访客相关 ==========
  /// 获取访客列表
  static const String getUserSeeVo = '/user/user/getUserSeeVo';

  // ========== 聊天记录 ==========
  /// 分页查询聊天记录
  static const String getMsgRecords = '/user/msg/getMsgRecords';

  // ========== 商品相关 ==========
  /// 获取商品列表
  static const String getProducts = '/p/product/getProducts';
  /// 按国家获取单个商品
  static const String getCountryProduct = '/p/product/getCountryProduct';
  /// 获取官方支付商品id列表
  static const String getProductCodes = '/p/product/getProductCodes';

  // ========== 订单相关 ==========
  /// 获取订单列表
  static const String getOrderList = '/p/order/getOrderList';
  /// 批量获取订单状态
  static const String getOrderStatusBatch = '/p/order/getOrderStatusBatch';
  /// 充值（下单）
  static const String createOrder = '/p/order/createOrder';
  /// Apple支付回调（服务端回调，客户端无需调用）
  /// Apple服务器在支付完成后会自动调用此接口
  static const String applePay = '/p/notify/applePay';
  /// Google支付回调（服务端回调，客户端无需调用）
  /// Google服务器在支付完成后会自动调用此接口
  static const String googlePay = '/p/notify/googlePay';

  // ========== 优惠券相关 ==========
  /// 获取待领取的优惠券
  static const String getNewCoupon = '/p/coupon/getNewCoupon';
  /// 领取优惠券
  static const String takeCoupon = '/p/coupon/takeCoupon';
  /// 查询用户优惠券
  static const String getUserCoupons = '/p/coupon/getUserCoupons';
  /// 获取商品列表附带优惠券
  static const String getProductsWithCoupon = '/p/product/getProductsWithCoupon';
  /// 获取中奖商品
  static const String getLotteryProduct = '/p/product/getLotteryProduct';
  /// 获取分次订单领取记录
  static const String getSplitOrder = '/p/order/getSplitOrder';
  /// 领取分次订单奖励
  static const String takeSplitReward = '/p/order/takeSplitReward';
  /// 主播索要充值
  static const String begRecharge = '/user/beg/begRecharge';
  /// 获取降档营销配置
  static const String getDowngradeConfig = '/p/downgrade/getConfig';
  /// 获取降档营销商品
  static const String getDowngradeProduct = '/p/product/getDowngradeProduct';
  /// 获取金币商城
  static const String getStores = '/p/exchangeStore/getStores';
  /// 兑换钻石
  static const String exchangeDiamonds = '/p/exchangeStore/exchangeDiamonds';
  /// payerMax前置组件初始化
  static const String createPayerMaxKey = '/p/order/createPayerMaxKey';
  /// h5页面payerMax充值
  static const String createPayerMaxOrder = '/p/order/createPayerMaxOrder';
  /// 查询订单简要信息
  static const String getOrderSimpleList = '/p/order/getOrderSimpleList';

  // ========== 通话相关 ==========
  static const String callStart = '/call/start';
  static const String callEnd = '/call/end';
  static const String callAccept = '/call/accept';
  static const String callReject = '/call/reject';

  // ========== 充值相关 ==========
  static const String coinBalance = '/coin/balance';
  static const String coinRecharge = '/coin/recharge';
  static const String coinRecords = '/coin/records';
  static const String products = '/products';

  // ========== VIP 相关 ==========
  static const String vipInfo = '/vip/info';
  static const String vipPurchase = '/vip/purchase';

  // ========== 主播相关 ==========
  /// 获取AIV主播
  static const String getAivAnchor = '/user/anchor/getAivAnchor';
  /// AIV播放回调
  static const String callbackByAiv = '/user/anchor/callbackByAiv';
  /// 获取主播录制视频配置
  static const String getAnchorVideoConfig = '/user/anchor/getAnchorVideoConfig';
  /// 设置主播结束匹配
  static const String closeMatching = '/user/anchor/closeMatching';
  /// 获取主播个人相册和视频
  static const String getAnchorAlbumVideoVo = '/user/anchor/getAnchorAlbumVideoVo';
  /// 试播视频观看完成
  static const String callbackByTrialVideo = '/user/anchor/callbackByTrialVideo';
  /// 查看匹配主播繁忙程度
  static const String getMatchBusyLevel = '/user/anchor/getMatchBusyLevel';
  /// 获取匹配收益排行榜
  static const String getMatchRanking = '/user/anchor/getMatchRanking';
  /// 获取所有收益排行榜
  static const String getCoinRanking = '/user/anchor/getCoinRanking';
  /// 获取匹配主播，aim不扣款
  static const String tryGetMatchAnchor = '/user/anchor/tryGetMatchAnchor';
  /// aim扣款
  static const String deductByAim = '/user/anchor/deductByAim';
  /// 获取主播聊天图片
  static const String getAnchorChatImgVo = '/user/anchor/getAnchorChatImgVo';
  /// 调整主播端聊天图片顺序
  static const String updateAnchorChatImgSort = '/user/anchor/updateAnchorChatImgSort';
  /// 删除主播端聊天图片
  static const String delAnchorChatImgSort = '/user/anchor/delAnchorChatImgSort';
  /// 刷新主播活跃时间
  static const String setActive = '/user/anchor/setActive';
  /// 虚拟视频播放结束回调
  static const String callbackByVideoEnd = '/user/anchor/callbackByVideoEnd';
  /// 虚拟视频用户评分回调
  static const String callbackByVideoUserRate = '/user/anchor/callbackByVideoUserRate';
  /// 上传主播端设备信息
  static const String uploadAnchorDevice = '/user/anchor/uploadAnchorDevice';
  /// 主播代理-邀请主播列表
  static const String anchorToGuildProgressInfo = '/user/anchor/anchorToGuildProgressInfo';
  /// 获取我的雷达图相关数据
  static const String getAnchorRadarChart = '/user/anchor/getAnchorRadarChart';
  /// 获取指定主播的雷达图相关数据（免登录）
  static const String getAnchorRadarChartNoLogin = '/user/anchor/getAnchorRadarChartNoLogin';
  /// 校验主播银行卡验证码
  static const String verifyBankCardCode = '/user/anchor/verifyBankCardCode';
  /// 查询匹配限制信息
  static const String getMatchLimit = '/user/anchor/getMatchLimit';
  /// 用户获取标签推荐主播列表
  static const String getTagRecommendAnchors = '/user/anchor/getTagRecommendAnchors';
  /// 获取一键打招呼主播列表
  static const String getQuickGreetAnchors = '/user/anchor/getQuickGreetAnchors';
  /// 用户对主播一键打招呼
  static const String quickGreet = '/user/anchor/quickGreet';
  /// 上传主播端私密聊天图片
  static const String uploadAnchorPrivacyChatImg = '/user/anchor/uploadAnchorPrivacyChatImg';
  /// 获取自己的私密聊天图片
  static const String getAnchorPrivacyChatImg = '/user/anchor/getAnchorPrivacyChatImg';
  /// 解锁主播私密聊天图片/视频
  static const String unlockAnchorPrivacyChatImg = '/user/anchor/unlockAnchorPrivacyChatImg';
  /// 查询私密聊天图片解锁记录
  static const String getPrivacyChatImgUnlock = '/user/anchor/getPrivacyChatImgUnlock';
  /// 删除私密聊天图片解锁记录
  static const String deletePrivacyChatImgUnlock = '/user/anchor/deletePrivacyChatImgUnlock';
  /// 主播发送私密聊天图片给用户
  static const String sendPrivacyChatImg = '/user/anchor/sendPrivacyChatImg';
  /// 获取主播认证流程信息V2
  static const String getAnchorAuthV2 = '/user/anchor/getAnchorAuthV2';
  /// 提交审核资料V2
  static const String saveAnchorAuthV2 = '/user/anchor/saveAnchorAuthV2';
  /// 认证流程V2 设置首次进入认证成功页面
  static const String callbackByFirstAuth = '/user/anchor/callbackByFirstAuth';
  /// 获取我的星级相关数据V2
  static const String getAnchorLevelV2 = '/user/anchor/getAnchorLevelV2';
  /// 获取主播免费视频
  static const String getFreeVideo = '/user/anchor/getFreeVideo';
  /// 清理设备免费视频相关的缓存
  static const String clearFreeVideoCache = '/user/anchor/clearFreeVideoCache';
  /// 获取多账号主播
  static const String getMultiAnchor = '/user/anchor/getMultiAnchor';
  /// 公会邀请码校验
  static const String guildCodeVerify = '/user/anchor/guildCodeVerify';
  /// 发送绑定邮箱验证码
  static const String sendBindEmailVerifyCode = '/user/anchor/sendBindEmailVerifyCode';
  /// 绑定邮箱
  static const String bindEmail = '/user/anchor/bindEmail';
  /// 发送修改银行卡验证码
  static const String sendChangeBankCardVerifyCode = '/user/anchor/sendChangeBankCardVerifyCode';
  /// 获取绑定公会登录信息
  static const String getGuildLoginInfo = '/user/anchor/getGuildLoginInfo';
  /// 获取主播曝光度相关数据
  static const String getAnchorExposure = '/user/anchor/getAnchorExposure';
  /// 试播答题完成
  static const String callbackByTrialExam = '/user/anchor/callbackByTrialExam';
  /// 用户随机获取免费匹配主播
  static const String getFreeMatchAnchors = '/user/anchor/getFreeMatchAnchors';
  /// 获取主播试播进度
  static const String getAnchorTrialProgress = '/user/anchor/getAnchorTrialProgress';
  /// 上报主播在通话过程中未露脸
  static const String reportAnchorOutScreen = '/user/anchor/reportAnchorOutScreen';
  /// 上传主播端聊天图片/视频
  static const String uploadAnchorChatMedia = '/user/media/uploadAnchorChatMedia';
  /// 上传主播端私密聊天图片/视频
  static const String uploadAnchorPrivacyChatMedia = '/user/media/uploadAnchorPrivacyChatMedia';
/// 获取发布动态奖励的金币数
static const String getMomentReward = '/user/task/getMomentReward';
/// 解锁主播私密聊天视频
static const String unlockAnchorPrivacyChatVideo = '/user/anchor/unlockAnchorPrivacyChatVideo';
/// 高风险主播上传高风险类型
static const String uploadAnchorFKType = '/user/anchor/uploadAnchorFKType';
/// 获取主播视频价格配置
static const String getAnchorVideoPriceConfig = '/user/anchor/getAnchorVideoPriceConfig';
/// 设置主播在屏幕中
static const String setInScreen = '/user/anchor/setInScreen';
/// 设置主播不在屏幕中
static const String setOutScreen = '/user/anchor/setOutScreen';
/// 获取匹配主播（屏幕筛选），aim不扣款
static const String tryGetScreenMatchAnchor = '/user/anchor/tryGetScreenMatchAnchor';
/// 获取批量匹配主播，aim不扣款
static const String tryBatchMatchAnchor = '/user/anchor/tryBatchMatchAnchor';

  // ========== 系统相关 ==========
  static const String appConfig = '/system/app/getConfig';
  static const String rtmToken = '/system/app/getRtmToken';
  static const String rtcToken = '/system/app/getRtcToken';
  static const String languageConfig = '/system/app/getLanguageConfig';
  static const String banners = '/system/banner/getBanners';
  /// 获取地区列表
  static const String getAreas = '/system/country/getAreas';
  /// 获取AI配置
  static const String getAiConfigs = '/system/ai/getAiConfigs';
  /// 按国家获取银行渠道列表
  static const String getPayoutChannels = '/system/bank/getPayoutChannels';
  /// 获取标签配置
  static const String getTagConfigs = '/system/app/getTagConfigs';
  /// 获取广告列表
  static const String getAdvertisement = '/system/app/getAdvertisement';
  /// IP和语言检测
  static const String checkRegion = '/system/app/checkRegion';
  /// 获取招呼话术列表
  static const String getAigConfigs = '/system/ai/getAigConfigs';
  /// 获取敏感词库V2
  static const String getSensitiveWordsV2 = '/system/sensitive/getSensitiveWordsV2';
  /// 获取通话记录
  static const String getCallRecordVoList = '/call/call/getCallRecordVoList';
  /// 通话结束是否可打标签
  static const String isTagCall = '/call/call/isTagCall';
}
