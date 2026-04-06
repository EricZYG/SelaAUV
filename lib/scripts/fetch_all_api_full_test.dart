import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

/// 全局静态配置
class AppConfig {
  static const String appName = 'SleaAUV';
  static const String appVersion = '1.0.0';
  static const String baseUrl = 'https://testapi.selalive.com';

  static const bool debugMode = true;
  static const String debugAuth = 'DSTEST-eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxMDIwNzMwNCIsInN1YiI6IjEwMjA3MzA0IiwiaWF0IjoxNzc0MjQ5ODUwLCJpc3MiOiJzZWxhIiwidXNlciI6IntcImFwcENoYW5uZWxcIjpcInNlbGExMDBcIixcImFwcE5hbWVcIjpcInNlbGFcIixcImNvdW50cnlDb2RlXCI6ODQwLFwiY3JlYXRlZEF0XCI6MTc3NDI0OTQ3NjkwMSxcImRldmljZUlkXCI6XCJkODk3OTMwMzVkOThjNDhmLVhpYW9taVwiLFwibG9naW5UaW1lXCI6MTc3NDI0OTg1MDE5MyxcIm9wZW5JZFwiOlwiejc0NDQ0ODc1NVwiLFwicmVnaXN0ZXJGbGFnXCI6ZmFsc2UsXCJ0eXBlXCI6MCxcInVzZXJJZFwiOjEwMjA3MzA0LFwidXNlcm5hbWVcIjoidGVzdDEyMzQ1NlwifV0.gI4R1lVHK0k0K2yBHGpP1lO1xO_LY9Z2aC6p9xR8n4kQf7wT8zL2mV3uJ5gH0cA';
  static const String debugUserAgent = 'sela,3.0.8,android Mi Note 3,9,sela100,40';
  static String debugDeviceId = '';
}

/// API 测试结果
class ApiTestResult {
  final String name;
  final String path;
  final String method;
  final Map<String, dynamic>? params;
  final int statusCode;
  final int? code;
  final String? message;
  final dynamic data;
  final String? error;
  final int duration;

  ApiTestResult({
    required this.name,
    required this.path,
    required this.method,
    this.params,
    required this.statusCode,
    this.code,
    this.message,
    this.data,
    this.error,
    required this.duration,
  });

  bool get isSuccess => statusCode == 200 && code == 0;
}

/// HTTP 客户端
class HttpClient {
  final Dio _dio;

  HttpClient() : _dio = Dio() {
    _dio.options.baseUrl = AppConfig.baseUrl;
    _dio.options.connectTimeout = 30000;
    _dio.options.receiveTimeout = 30000;
    _dio.options.validateStatus = (status) => true;

    _dio.options.headers = {
      'Accept': '*/*',
      'Accept-Encoding': 'gzip, deflate, br',
      'Connection': 'keep-alive',
      'authorization': AppConfig.debugAuth,
      'content-type': 'application/json; charset=utf-8',
      'device-id': AppConfig.debugDeviceId,
      'user-agent': AppConfig.debugUserAgent,
      'user-language': 'zh',
    };
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }
}

/// API 端点定义
class ApiEndpoint {
  final String name;
  final String path;
  final String method;
  final Map<String, dynamic>? params;
  final String? description;

  ApiEndpoint({
    required this.name,
    required this.path,
    required this.method,
    this.params,
    this.description,
  });
}

/// 获取所有 API 端点
List<ApiEndpoint> getAllEndpoints() {
  return [
    // ========== 认证相关 ==========
    // ApiEndpoint(name: '游客登录', path: '/user/login/guest', method: 'POST', params: {'deviceId': AppConfig.debugDeviceId}),
    // ApiEndpoint(name: '手机号登录', path: '/user/login/phone', method: 'POST', params: {'phone': '1234567890', 'code': '123456'}),
    // ApiEndpoint(name: '谷歌登录', path: '/user/login/google', method: 'POST', params: {'id_token': 'mock_id_token'}),
    // ApiEndpoint(name: '苹果登录', path: '/user/login/apple', method: 'POST', params: {'identity_token': 'mock_identity_token', 'name': 'Test User'}),
    //
    // // ========== 用户相关 ==========
    // ApiEndpoint(name: '获取我的页面信息', path: '/user/user/getUserDetail', method: 'GET'),
    // ApiEndpoint(name: '获取对方详情(需登录)', path: '/user/user/getUserExpand', method: 'GET'),
    // ApiEndpoint(name: '获取对方详情(无需登录)', path: '/user/user/getUserExpandNoLogin', method: 'GET'),
    // ApiEndpoint(name: '获取对方简要信息', path: '/user/user/getUserSimple', method: 'GET'),
    // ApiEndpoint(name: '获取用户背包道具列表', path: '/user/prop/getUserPropVo', method: 'GET'),
    // ApiEndpoint(name: '用户端编辑资料获取信息', path: '/user/user/getUserUpdateDetailVo', method: 'GET'),
    // ApiEndpoint(name: '获取邀请信息', path: '/user/user/getInviteInfo', method: 'GET'),
    // ApiEndpoint(name: '获取邀请奖励记录列表', path: '/user/user/getInviteUserVoList', method: 'GET'),
    // ApiEndpoint(name: '获取邀请绑定记录', path: '/user/user/getInviteRecord', method: 'GET'),
    // ApiEndpoint(name: '检查用户资料完整度', path: '/user/user/checkUserDetail', method: 'GET'),
    // ApiEndpoint(name: '获取高级用户弹窗详情', path: '/user/advance/getDialogDetail', method: 'GET'),
    // ApiEndpoint(name: '获取随机15条奖励飘屏', path: '/user/user/getRewards', method: 'GET'),
    // ApiEndpoint(name: '获取用户钻石排行', path: '/user/user/getDiamondRanking', method: 'GET'),
    // ApiEndpoint(name: '获取主播首页用户列表', path: '/user/user/getUsers', method: 'GET'),
    // ApiEndpoint(name: '获取男用户详情V2', path: '/user/user/getUserExpandV2', method: 'GET'),
    // ApiEndpoint(name: '获取主播详情V2', path: '/user/user/getAnchorExpandV2', method: 'GET'),
    // ApiEndpoint(name: '随机获取头像', path: '/user/user/getPortraits', method: 'GET'),
    // ApiEndpoint(name: '女用户更新为男用户', path: '/user/user/updateSexMale', method: 'POST'),
    // ApiEndpoint(name: '注销账号', path: '/user/user/deleteUser', method: 'POST'),
    // ApiEndpoint(name: '获取用户信息', path: '/user/info', method: 'GET'),
    // ApiEndpoint(name: '查看对方主页埋点', path: '/user/user/saveSeeHome', method: 'GET', params: {'userId': '123456'}),
    // ApiEndpoint(name: '获取访客列表', path: '/user/user/getUserSeeVo', method: 'GET'),
    // ApiEndpoint(name: '批量获取用户是否在线', path: '/user/user/getIsOnlines', method: 'POST', params: {'userIds': [123456, 789012]}),
    // ApiEndpoint(name: '设置密码', path: '/user/user/setPassword', method: 'POST', params: {'password': '123456'}),
    // ApiEndpoint(name: '修改密码', path: '/user/user/changePassword', method: 'POST', params: {'oldPassword': '123456', 'newPassword': '654321'}),
    // ApiEndpoint(name: '给对方设置别名', path: '/user/userAlias/setAlias', method: 'POST', params: {'userId': '123456', 'alias': '测试别名'}),
    // ApiEndpoint(name: '更新性别引导页信息', path: '/user/user/updateSexDetail', method: 'POST', params: {'age': 25}),
    // ApiEndpoint(name: '获取合规用户/主播列表', path: '/user/anchor/getFKUsers', method: 'GET'),
    // ApiEndpoint(name: '检查是否有填写邀请码记录', path: '/user/user/isHasInviteRecord', method: 'GET'),
    // ApiEndpoint(name: '绑定邀请码', path: '/user/user/bindInviteCode', method: 'POST', params: {'inviteCode': 'ABC123'}),
    // ApiEndpoint(name: '用户端编辑相册', path: '/user/user/updateAlbumUrlList', method: 'POST', params: {'userId': '123456', 'albumUrlList': []}),
    // ApiEndpoint(name: '修改个人信息', path: '/user/user/updateUserDetail', method: 'POST', params: {'nickname': 'TestNick'}),
    // ApiEndpoint(name: '举报/反馈', path: '/user/feedback/save', method: 'POST', params: {'content': '测试反馈内容', 'type': 1}),
    // ApiEndpoint(name: '获取用户钻石/金币明细', path: '/user/balance/getUserBalanceRecords', method: 'GET', params: {'pageNum': 1, 'pageSize': 20}),
    // ApiEndpoint(name: '更新FirebaseToken', path: '/user/user/updateFirebaseToken', method: 'POST', params: {'fcmToken': 'mock_fcm_token'}),
    // ApiEndpoint(name: '更新广告标识', path: '/user/user/updateAdFlag', method: 'POST', params: {'adFlag': 1}),
    // ApiEndpoint(name: 'App评分', path: '/user/user/updateAppRateScore', method: 'POST', params: {'score': 5}),
    //
    // // ========== 签到相关 ==========
    // ApiEndpoint(name: '签到领奖励', path: '/user/sign/signIn', method: 'POST', params: {'signDay': 1}),
    //
    // // ========== 任务相关 ==========
    // ApiEndpoint(name: '获取用户任务列表', path: '/user/task/getUserTaskList', method: 'GET'),
    // ApiEndpoint(name: '领取任务奖励', path: '/user/task/claimTaskReward', method: 'POST', params: {'taskId': 1}),
    // ApiEndpoint(name: '用户抽奖', path: '/user/task/userDraw', method: 'POST', params: {'drawType': 1}),
    // ApiEndpoint(name: '获取发布动态奖励金币数', path: '/user/task/getMomentReward', method: 'GET'),
    //
    // // ========== 动态相关 ==========
    // ApiEndpoint(name: '发布动态', path: '/user/anchorMoment/publish', method: 'POST', params: {'content': '测试动态内容', 'medias': [], 'visibleType': 0}),
    // ApiEndpoint(name: '评论动态', path: '/user/anchorMoment/comment', method: 'POST', params: {'momentId': '123', 'content': '测试评论'}),
    // ApiEndpoint(name: '取消点赞动态/评论', path: '/user/anchorMoment/praiseCancel', method: 'POST', params: {'momentId': '123'}),
    // ApiEndpoint(name: '获取动态通知列表', path: '/user/anchorMoment/getNotices', method: 'GET'),
    // ApiEndpoint(name: '获取最后一条动态通知', path: '/user/anchorMoment/getLastNotice', method: 'GET'),
    // ApiEndpoint(name: '用户端查主播动态V2', path: '/user/anchorMoment/userGetMomentV2', method: 'POST', params: {'pageNum': 1, 'pageSize': 20, 'condition': {}}),
    // ApiEndpoint(name: '用户端查主播hot动态V3', path: '/user/anchorMoment/userGetHotMoment', method: 'POST', params: {'pageNum': 1, 'pageSize': 20}),
    // ApiEndpoint(name: '获取流量最高的动态', path: '/user/anchorMoment/getTopShowMoment', method: 'GET'),
    // ApiEndpoint(name: '删除动态', path: '/user/anchorMoment/delete', method: 'POST', params: {'momentId': '123'}),
    // ApiEndpoint(name: '查单个主播动态附带第一页评论', path: '/user/anchorMoment/getOneMomentWithComment', method: 'GET', params: {'momentId': '123'}),
    // ApiEndpoint(name: '主播端查自己动态', path: '/user/anchorMoment/getMyMoment', method: 'POST', params: {'pageNum': 1, 'pageSize': 20}),
    // ApiEndpoint(name: '查单个主播动态', path: '/user/anchorMoment/getOneMoment', method: 'GET', params: {'momentId': '123'}),
    // ApiEndpoint(name: '主播端查其他主播动态', path: '/user/anchorMoment/anchorGetOtherMoment', method: 'POST', params: {'pageNum': 1, 'pageSize': 20, 'anchorIds': [123456]}),
    // ApiEndpoint(name: '获取动态评论', path: '/user/anchorMoment/getComments', method: 'POST', params: {'momentId': '123', 'pageNum': 1, 'pageSize': 20}),
    // ApiEndpoint(name: '关注主播是否有新动态', path: '/user/anchorMoment/hasNewFollowMoment', method: 'GET'),
    // ApiEndpoint(name: '修改动态可见范围', path: '/user/anchorMoment/updateVisibleType', method: 'POST', params: {'momentId': '123', 'visibleType': 0}),
    //
    // // ========== 消息相关 ==========
    // ApiEndpoint(name: '发送消息', path: '/user/msg/sendMsg', method: 'POST', params: {'recipientId': '123456', 'type': 11, 'urlOrContent': '测试消息'}),
    // ApiEndpoint(name: '通话中发送消息', path: '/user/msg/sendMsgInCall', method: 'POST', params: {'recipientId': '123456', 'channelId': 'channel123', 'type': 11, 'urlOrContent': '测试消息'}),
    // ApiEndpoint(name: '游戏房间中发送消息', path: '/user/msg/sendMsgInGameRoom', method: 'POST', params: {'channelId': 'room123', 'type': 11, 'urlOrContent': '测试消息'}),
    // ApiEndpoint(name: '分页查询聊天记录', path: '/user/msg/getMsgRecords', method: 'GET', params: {'otherUserId': '123456', 'pageSize': 20}),
    //
    // // ========== 匹配相关 ==========
    // ApiEndpoint(name: '获取匹配配置', path: '/match', method: 'GET'),
    // ApiEndpoint(name: '开始匹配', path: '/match/start', method: 'POST'),
    // ApiEndpoint(name: '取消匹配', path: '/match/cancel', method: 'POST'),
    // ApiEndpoint(name: '匹配历史', path: '/match/history', method: 'GET'),
    //
    // // ========== 通话相关 ==========
    // ApiEndpoint(name: '开始通话', path: '/call/start', method: 'POST', params: {'targetUserId': '123456', 'type': 0}),
    // ApiEndpoint(name: '结束通话', path: '/call/end', method: 'POST', params: {'channelId': 'channel123'}),
    // ApiEndpoint(name: '接听通话', path: '/call/accept', method: 'POST', params: {'channelId': 'channel123'}),
    // ApiEndpoint(name: '拒绝通话', path: '/call/reject', method: 'POST', params: {'channelId': 'channel123'}),
    // ApiEndpoint(name: '获取通话记录', path: '/call/call/getCallRecordVoList', method: 'POST', params: {'callType': 0, 'callFlag': 1}),
    // ApiEndpoint(name: '创建通话频道', path: '/call/call/createCall', method: 'POST', params: {'targetUserId': '123456', 'type': 0}),
    // ApiEndpoint(name: '加入通话聊天室', path: '/call/call/joinCall', method: 'POST', params: {'channelId': 'channel123'}),
    // ApiEndpoint(name: '通话续费', path: '/call/call/refreshCall', method: 'POST', params: {'channelId': 'channel123'}),
    // ApiEndpoint(name: '心跳请求', path: '/user/user/heartbeat', method: 'POST', params: {'isScreenOff': false}),
    //
    // // ========== 首页/发现 ==========
    // ApiEndpoint(name: '发现首页', path: '/discover', method: 'GET'),
    // ApiEndpoint(name: '发现列表', path: '/discover/list', method: 'GET'),
    //
    // // ========== 充值相关 ==========
    // ApiEndpoint(name: '获取商品列表', path: '/p/product/getProducts', method: 'GET', params: {'type': 1}),
    // ApiEndpoint(name: '按国家获取商品', path: '/p/product/getCountryProduct', method: 'GET', params: {'productId': 'prod001', 'countryCode': '840'}),
    // ApiEndpoint(name: '获取官方商品ID列表', path: '/p/product/getProductCodes', method: 'GET'),
    // ApiEndpoint(name: '创建订单', path: '/p/order/createOrder', method: 'POST', params: {'ppId': 'pp001', 'productId': 'prod001'}),
    // ApiEndpoint(name: '获取订单列表', path: '/p/order/getOrderList', method: 'POST', params: {'pageNum': 1, 'pageSize': 20}),
    // ApiEndpoint(name: '批量获取订单状态', path: '/p/order/getOrderStatusBatch', method: 'POST', params: {'orderNos': ['order001']}),
    // ApiEndpoint(name: '获取分次订单', path: '/p/order/getSplitOrder', method: 'GET'),
    // ApiEndpoint(name: '领取分次订单奖励', path: '/p/order/takeSplitReward', method: 'POST'),
    // ApiEndpoint(name: '查询订单简要信息', path: '/p/order/getOrderSimpleList', method: 'POST', params: {'pageNum': 1, 'pageSize': 20}),
    //
    // // ========== 优惠券相关 ==========
    // ApiEndpoint(name: '获取待领取优惠券', path: '/p/coupon/getNewCoupon', method: 'GET'),
    // ApiEndpoint(name: '领取优惠券', path: '/p/coupon/takeCoupon', method: 'POST', params: {'couponId': 'coup001'}),
    // ApiEndpoint(name: '查询用户优惠券', path: '/p/coupon/getUserCoupons', method: 'GET', params: {'available': 1}),
    // ApiEndpoint(name: '获取商品附带优惠券', path: '/p/product/getProductsWithCoupon', method: 'GET', params: {'type': 1}),
    //
    // // ========== 金币商城相关 ==========
    // ApiEndpoint(name: '获取金币商城', path: '/p/exchangeStore/getStores', method: 'GET'),
    // ApiEndpoint(name: '兑换钻石', path: '/p/exchangeStore/exchangeDiamonds', method: 'POST', params: {'storeId': 'store001'}),
    // ApiEndpoint(name: '获取降档营销配置', path: '/p/downgrade/getConfig', method: 'GET'),
    // ApiEndpoint(name: '获取降档营销商品', path: '/p/product/getDowngradeProduct', method: 'GET', params: {'roundNo': 1}),
    //
    // // ========== payerMax相关 ==========
    // ApiEndpoint(name: 'payerMax初始化', path: '/p/order/createPayerMaxKey', method: 'POST', params: {'uid': '123456', 'orderNo': 'order001'}),
    // ApiEndpoint(name: 'payerMax充值', path: '/p/order/createPayerMaxOrder', method: 'POST', params: {'uid': '123456', 'orderNo': 'order001', 'paymentToken': 'token001', 'sessionKey': 'session001'}),
    //
    // // ========== 礼物相关 ==========
    // ApiEndpoint(name: '赠送真实礼物', path: '/user/gift/sendReal', method: 'POST', params: {'giftId': 1, 'anchorId': '123456', 'roomId': 'room001', 'num': 1}),
    // ApiEndpoint(name: '赠送幸运礼物', path: '/user/gift/sendLucky', method: 'POST', params: {'giftId': 1, 'anchorId': '123456', 'roomId': 'room001', 'num': 1}),
    //
    // // ========== 主播相关 ==========
    // ApiEndpoint(name: '获取AIV主播', path: '/user/anchor/getAivAnchor', method: 'GET'),
    // ApiEndpoint(name: 'AIV播放回调', path: '/user/anchor/callbackByAiv', method: 'POST', params: {'anchorId': '123456'}),
    // ApiEndpoint(name: '获取主播录制视频配置', path: '/user/anchor/getAnchorVideoConfig', method: 'GET'),
    // ApiEndpoint(name: '设置主播结束匹配', path: '/user/anchor/closeMatching', method: 'POST'),
    // ApiEndpoint(name: '获取主播相册和视频', path: '/user/anchor/getAnchorAlbumVideoVo', method: 'GET', params: {'anchorId': '123456'}),
    // ApiEndpoint(name: '试播视频观看完成', path: '/user/anchor/callbackByTrialVideo', method: 'POST', params: {'videoId': '123'}),
    // ApiEndpoint(name: '查看匹配主播繁忙程度', path: '/user/anchor/getMatchBusyLevel', method: 'GET'),
    // ApiEndpoint(name: '获取匹配收益排行榜', path: '/user/anchor/getMatchRanking', method: 'GET'),
    // ApiEndpoint(name: '获取所有收益排行榜', path: '/user/anchor/getCoinRanking', method: 'GET'),
    // ApiEndpoint(name: '获取匹配主播(aim不扣款)', path: '/user/anchor/tryGetMatchAnchor', method: 'POST'),
    // ApiEndpoint(name: 'aim扣款', path: '/user/anchor/deductByAim', method: 'POST', params: {'anchorId': '123456'}),
    // ApiEndpoint(name: '获取主播聊天图片', path: '/user/anchor/getAnchorChatImgVo', method: 'GET'),
    // ApiEndpoint(name: '刷新主播活跃时间', path: '/user/anchor/setActive', method: 'POST'),
    // ApiEndpoint(name: '虚拟视频播放结束回调', path: '/user/anchor/callbackByVideoEnd', method: 'POST', params: {'videoId': '123'}),
    // ApiEndpoint(name: '虚拟视频用户评分回调', path: '/user/anchor/callbackByVideoUserRate', method: 'POST', params: {'videoId': '123', 'rating': 5}),
    // ApiEndpoint(name: '获取我的雷达图数据', path: '/user/anchor/getAnchorRadarChart', method: 'GET'),
    // ApiEndpoint(name: '获取指定主播雷达图数据', path: '/user/anchor/getAnchorRadarChartNoLogin', method: 'GET', params: {'anchorId': '123456'}),
    // ApiEndpoint(name: '校验主播银行卡验证码', path: '/user/anchor/verifyBankCardCode', method: 'POST', params: {'code': '123456'}),
    // ApiEndpoint(name: '查询匹配限制信息', path: '/user/anchor/getMatchLimit', method: 'GET'),
    // ApiEndpoint(name: '获取标签推荐主播列表', path: '/user/anchor/getTagRecommendAnchors', method: 'GET'),
    // ApiEndpoint(name: '获取一键打招呼主播列表', path: '/user/anchor/getQuickGreetAnchors', method: 'GET'),
    // ApiEndpoint(name: '用户对主播一键打招呼', path: '/user/anchor/quickGreet', method: 'POST', params: {'anchorId': '123456'}),
    // ApiEndpoint(name: '获取自己的私密聊天图片', path: '/user/anchor/getAnchorPrivacyChatImg', method: 'GET'),
    // ApiEndpoint(name: '解锁私密聊天图片', path: '/user/anchor/unlockAnchorPrivacyChatImg', method: 'POST', params: {'imgId': '123'}),
    // ApiEndpoint(name: '查询私密聊天图片解锁记录', path: '/user/anchor/getPrivacyChatImgUnlock', method: 'GET'),
    // ApiEndpoint(name: '获取主播认证流程信息V2', path: '/user/anchor/getAnchorAuthV2', method: 'GET'),
    // ApiEndpoint(name: '获取我的星级相关数据V2', path: '/user/anchor/getAnchorLevelV2', method: 'GET'),
    // ApiEndpoint(name: '获取主播免费视频', path: '/user/anchor/getFreeVideo', method: 'GET'),
    // ApiEndpoint(name: '获取多账号主播', path: '/user/anchor/getMultiAnchor', method: 'GET'),
    // ApiEndpoint(name: '公会邀请码校验', path: '/user/anchor/guildCodeVerify', method: 'POST', params: {'guildCode': 'GUILD123'}),
    // ApiEndpoint(name: '发送绑定邮箱验证码', path: '/user/anchor/sendBindEmailVerifyCode', method: 'POST', params: {'email': 'test@example.com'}),
    // ApiEndpoint(name: '绑定邮箱', path: '/user/anchor/bindEmail', method: 'POST', params: {'email': 'test@example.com', 'code': '123456'}),
    // ApiEndpoint(name: '获取绑定公会登录信息', path: '/user/anchor/getGuildLoginInfo', method: 'GET'),
    // ApiEndpoint(name: '获取主播曝光度数据', path: '/user/anchor/getAnchorExposure', method: 'GET'),
    // ApiEndpoint(name: '试播答题完成', path: '/user/anchor/callbackByTrialExam', method: 'POST'),
    // ApiEndpoint(name: '获取免费匹配主播', path: '/user/anchor/getFreeMatchAnchors', method: 'GET'),
    // ApiEndpoint(name: '获取主播试播进度', path: '/user/anchor/getAnchorTrialProgress', method: 'GET'),
    // ApiEndpoint(name: '上报主播未露脸', path: '/user/anchor/reportAnchorOutScreen', method: 'POST', params: {'anchorId': '123456'}),
    // ApiEndpoint(name: '获取主播视频价格配置', path: '/user/anchor/getAnchorVideoPriceConfig', method: 'GET'),
    // ApiEndpoint(name: '设置主播在屏幕中', path: '/user/anchor/setInScreen', method: 'POST'),
    // ApiEndpoint(name: '设置主播不在屏幕中', path: '/user/anchor/setOutScreen', method: 'POST'),
    // ApiEndpoint(name: '获取匹配主播(屏幕筛选)', path: '/user/anchor/tryGetScreenMatchAnchor', method: 'POST'),
    // ApiEndpoint(name: '获取批量匹配主播', path: '/user/anchor/tryBatchMatchAnchor', method: 'POST'),
    //
    // // ========== 主播索要充值 ==========
    // ApiEndpoint(name: '主播索要充值', path: '/user/beg/begRecharge', method: 'POST', params: {'userId': '123456'}),
    //
    // // ========== 系统相关 ==========
    // ApiEndpoint(name: '获取应用配置', path: '/system/app/getConfig', method: 'GET'),
    // ApiEndpoint(name: '获取RTM Token', path: '/system/app/getRtmToken', method: 'GET'),
    // ApiEndpoint(name: '获取RTC Token', path: '/system/app/getRtcToken', method: 'GET'),
    // ApiEndpoint(name: '获取语言配置', path: '/system/app/getLanguageConfig', method: 'GET'),
    // ApiEndpoint(name: '获取Banner列表', path: '/system/banner/getBanners', method: 'GET'),
    //
    // // ========== 直播间相关 ==========
    // ApiEndpoint(name: '直播间列表', path: '/live/room/getList', method: 'POST', params: {'page': 1, 'pageSize': 20}),
    // ApiEndpoint(name: '直播间详情', path: '/live/room/getDetail', method: 'GET', params: {'roomId': 'room001'}),
    //
    // // ========== 分类相关 ==========
    // ApiEndpoint(name: '分类列表', path: '/category/list', method: 'GET'),
    //
    // // ========== 账号注销 ==========
    // ApiEndpoint(name: '通过密码注销账号', path: '/user/logoff/deleteUserByPassword', method: 'POST', params: {'password': '123456'}),
  ];
}

/// 测试单个 API
Future<ApiTestResult> testApi(HttpClient client, ApiEndpoint endpoint) async {
  final stopwatch = Stopwatch()..start();
  try {
    Response response;
    if (endpoint.method == 'GET') {
      response = await client.get(endpoint.path, queryParameters: endpoint.params);
    } else {
      response = await client.post(endpoint.path, data: endpoint.params);
    }
    stopwatch.stop();

    final data = response.data;
    int? code;
    String? message;
    dynamic responseData;

    if (data is Map<String, dynamic>) {
      code = data['code'] as int?;
      message = data['message'] as String?;
      responseData = data['data'];
    }

    return ApiTestResult(
      name: endpoint.name,
      path: endpoint.path,
      method: endpoint.method,
      params: endpoint.params,
      statusCode: response.statusCode ?? 0,
      code: code,
      message: message,
      data: responseData,
      duration: stopwatch.elapsedMilliseconds,
    );
  } catch (e) {
    stopwatch.stop();
    return ApiTestResult(
      name: endpoint.name,
      path: endpoint.path,
      method: endpoint.method,
      params: endpoint.params,
      statusCode: 0,
      error: e.toString(),
      duration: stopwatch.elapsedMilliseconds,
    );
  }
}

/// 生成 Markdown 报告
String generateMarkdownReport(List<ApiTestResult> results) {
  final successCount = results.where((r) => r.isSuccess).length;
  final failCount = results.length - successCount;
  final totalDuration = results.fold<int>(0, (sum, r) => sum + r.duration);

  final buffer = StringBuffer();

  buffer.writeln('# API 测试报告');
  buffer.writeln();
  buffer.writeln('**生成时间**: ${DateTime.now().toIso8601String()}');
  buffer.writeln();
  buffer.writeln('## 汇总统计');
  buffer.writeln();
  buffer.writeln('| 指标 | 数值 |');
  buffer.writeln('|:-----|-----:|');
  buffer.writeln('| 总接口数 | ${results.length} |');
  buffer.writeln('| 成功数 | $successCount |');
  buffer.writeln('| 失败数 | $failCount |');
  buffer.writeln('| 成功率 | ${(successCount / results.length * 100).toStringAsFixed(1)}% |');
  buffer.writeln('| 总耗时 | ${(totalDuration / 1000).toStringAsFixed(2)}s |');
  buffer.writeln();

  // 成功接口列表
  buffer.writeln('## 成功接口列表 (code=0)');
  buffer.writeln();
  for (final result in results.where((r) => r.isSuccess)) {
    buffer.writeln('### ${result.name}');
    buffer.writeln();
    buffer.writeln('| 项目 | 内容 |');
    buffer.writeln('|:-----|:-----|');
    buffer.writeln('| 接口路径 | `${result.path}` |');
    buffer.writeln('| 请求方式 | ${result.method} |');
    buffer.writeln('| 请求参数 | ${result.params != null ? jsonEncode(result.params) : "无"} |');
    buffer.writeln('| 响应状态 | 成功 |');
    buffer.writeln('| 响应码 | ${result.code} |');
    buffer.writeln('| 响应报文 | `${_truncateJson(result.data)}` |');
    buffer.writeln('| 耗时 | ${result.duration}ms |');
    buffer.writeln();
  }

  // 失败接口列表
  buffer.writeln('## 失败接口列表');
  buffer.writeln();
  for (final result in results.where((r) => !r.isSuccess)) {
    buffer.writeln('### ${result.name}');
    buffer.writeln();
    buffer.writeln('| 项目 | 内容 |');
    buffer.writeln('|:-----|:-----|');
    buffer.writeln('| 接口路径 | `${result.path}` |');
    buffer.writeln('| 请求方式 | ${result.method} |');
    buffer.writeln('| 请求参数 | ${result.params != null ? jsonEncode(result.params) : "无"} |');
    buffer.writeln('| HTTP状态码 | ${result.statusCode} |');
    buffer.writeln('| 业务响应码 | ${result.code ?? "N/A"} |');
    buffer.writeln('| 响应消息 | ${result.message ?? result.error ?? "N/A"} |');
    buffer.writeln('| 耗时 | ${result.duration}ms |');
    buffer.writeln();
  }

  return buffer.toString();
}

String _truncateJson(dynamic data, {int maxLength = 500}) {
  final json = jsonEncode(data);
  if (json.length <= maxLength) return json;
  return '${json.substring(0, maxLength)}...';
}

void main() async {
  // 生成 UUID 作为 deviceId
  final uuid = DateTime.now().millisecondsSinceEpoch.toRadixString(16) + 
               (DateTime.now().microsecondsSinceEpoch % 1000).toRadixString(16).padLeft(3, '0');
  AppConfig.debugDeviceId = uuid;

  print('=' * 60);
  print('SleaAUV API 全量测试脚本');
  print('=' * 60);
  print('');
  print('测试配置:');
  print('  Base URL: ${AppConfig.baseUrl}');
  print('  Device ID: $uuid');
  print('  Auth: ${AppConfig.debugAuth.substring(0, 20)}...');
  print('');

  final client = HttpClient();
  final endpoints = getAllEndpoints();

  print('共 ${endpoints.length} 个接口待测试');
  print('');

  final results = <ApiTestResult>[];
  var successCount = 0;
  var failCount = 0;

  for (var i = 0; i < endpoints.length; i++) {
    final endpoint = endpoints[i];
    stdout.write('\r[${i + 1}/${endpoints.length}] 测试中: ${endpoint.name}... ');

    final result = await testApi(client, endpoint);
    results.add(result);

    if (result.isSuccess) {
      successCount++;
      stdout.write('\x1b[32m成功\x1b[0m (${result.duration}ms)');
    } else {
      failCount++;
      stdout.write('\x1b[31m失败\x1b[0m [${result.statusCode}] ${result.message ?? result.error}');
    }
    stdout.write('\n');
  }

  print('');
  print('=' * 60);
  print('测试完成!');
  print('成功: $successCount, 失败: $failCount');
  print('=' * 60);
  print('');

  // 生成报告
  final report = generateMarkdownReport(results);

  // 保存报告
  final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-').split('.').first;
  final reportFile = 'api_full_test_report_$timestamp.md';
  await File(reportFile).writeAsString(report);
  print('报告已保存到: $reportFile');

  // 保存每个接口的详细文件
  final detailDir = Directory('api_detail_$timestamp');
  await detailDir.create();

  for (final result in results) {
    final safeName = result.name.replaceAll(RegExp(r'[^\w\u4e00-\u9fa5]'), '_');
    final detailFile = File('${detailDir.path}/${safeName}.md');

    final content = '''
# ${result.name}

## 接口信息

| 项目 | 内容 |
|:-----|:-----|
| 接口名称 | ${result.name} |
| 接口路径 | ${result.path} |
| 请求方式 | ${result.method} |

## 请求参数

```
${result.params != null ? const JsonEncoder.withIndent('  ').convert(result.params) : '(无)'}
```

## 响应结果

| 项目 | 内容 |
|:-----|:-----|
| HTTP状态码 | ${result.statusCode} |
| 业务响应码 | ${result.code ?? 'N/A'} |
| 响应消息 | ${result.message ?? result.error ?? 'N/A'} |
| 耗时 | ${result.duration}ms |
| 是否成功 | ${result.isSuccess ? '✅ 成功' : '❌ 失败'} |

## 完整响应报文

```
${const JsonEncoder.withIndent('  ').convert(result.data ?? {'error': result.error ?? result.message})}
```
''';

    await detailFile.writeAsString(content);
  }

  print('');
  print('接口详情已保存到: ${detailDir.path}/');
  print('');
  print('测试完成!');
}
