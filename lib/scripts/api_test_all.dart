#!/usr/bin/env dart
/// 综合 API 测试脚本
///
/// 执行所有 API 接口并记录响应数据
library;

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:slea_auv/scripts/api_test/common/config.dart';

const String API_NAME = '综合API测试';
const String API_METHOD = 'GET';

void main() async {
  print('========================================');
  print('  $API_NAME');
  print('  执行时间: ${DateTime.now()}');
  print('========================================\n');

  final dio = createDioClient();
  final results = <String, Map<String, dynamic>>{};

  // 定义所有需要测试的 API
  final apis = <Map<String, dynamic>>[
    // ============ 系统相关 ============
    // {'name': '获取应用配置', 'path': '/system/app/getConfig', 'method': 'GET', 'needSign': false},
    // {'name': '获取翻译文案V2', 'path': '/system/app/getTranslatesV2', 'method': 'GET', 'needSign': false},
    // {'name': '获取地区列表', 'path': '/system/country/getAreas', 'method': 'GET', 'needSign': false},
    // {'name': '获取AI配置', 'path': '/system/ai/getAiConfigs', 'method': 'GET', 'needSign': false},
    // {'name': '按国家获取银行渠道列表', 'path': '/system/bank/getPayoutChannels', 'method': 'GET', 'params': {'countryCode': 840}, 'needSign': false},
    // {'name': '获取标签配置', 'path': '/system/app/getTagConfigs', 'method': 'GET', 'needSign': false},
    // {'name': '获取广告列表', 'path': '/system/app/getAdvertisement', 'method': 'GET', 'needSign': false},
    // {'name': 'IP和语言检测', 'path': '/system/app/checkRegion', 'method': 'GET', 'needSign': false},
    // {'name': '获取招呼话术列表', 'path': '/system/ai/getAigConfigs', 'method': 'GET', 'needSign': false},
    // {'name': '获取敏感词库V2', 'path': '/system/sensitive/getSensitiveWordsV2', 'method': 'GET', 'needSign': false},
    //
    // // ============ 用户相关 ============
    // {'name': '获取我的页面信息', 'path': '/user/user/getUserDetail', 'method': 'GET', 'needSign': false},
    // {'name': '获取用户信息', 'path': '/user/info', 'method': 'GET', 'needSign': false},
    // {'name': '编辑资料获取信息', 'path': '/user/user/getUserUpdateDetailVo', 'method': 'GET', 'needSign': false},
    // {'name': '获取好友请求数值', 'path': '/user/follow/getFollowCount', 'method': 'GET', 'needSign': false},
    // {'name': '获取用户简要信息', 'path': '/user/user/getUserSimple', 'method': 'GET', 'params': {'userId': 10000389}, 'needSign': false},
    // {'name': '获取用户关系数值', 'path': '/user/user/getRelationCount', 'method': 'GET', 'params': {'userId': 10000389}, 'needSign': false},
    // {'name': '获取等级区间详情', 'path': '/user/level/getLevelInfoConfigs', 'method': 'GET', 'needSign': false},
    // {'name': '获取高级用户弹窗接口', 'path': '/user/advance/getDialogDetail', 'method': 'GET', 'needSign': false},
    // {'name': '获取系统表情包', 'path': '/user/sticker/getCommonPackages', 'method': 'GET', 'needSign': false},
    // {'name': '获取访客列表', 'path': '/user/user/getUserSeeVo', 'method': 'GET', 'needSign': false},
    //
    // // ============ 礼物相关 ============
    // {'name': '获取普通礼物列表', 'path': '/user/gift/getGiftList', 'method': 'GET', 'needSign': false},
    // {'name': '获取普通+VIP礼物列表', 'path': '/user/gift/getAllGifts', 'method': 'GET', 'needSign': false},
    // {'name': '获取单个礼物详情', 'path': '/user/gift/getOne', 'method': 'GET', 'params': {'gid': 1001}, 'needSign': false},
    // {'name': '获取礼物动作列表', 'path': '/user/gift/getActions', 'method': 'GET', 'needSign': false},
    // {'name': '获取自己的礼物秀列表', 'path': '/user/gift/getGiftShows', 'method': 'GET', 'needSign': false},
    // {'name': '获取对方的礼物秀列表', 'path': '/user/gift/getAnchorGiftShows', 'method': 'GET', 'params': {'userId': 10000389}, 'needSign': false},
    // {'name': '获取送礼榜单', 'path': '/user/gift/getGiftRank', 'method': 'GET', 'needSign': false},
    // {'name': '获取直播间礼物秀开关', 'path': '/user/anchor/getLiveGiftShowFlag', 'method': 'GET', 'needSign': false},
    // {'name': '获取钻石数达到试播成功的礼物列表', 'path': '/user/gift/getTrialReachGifts', 'method': 'GET', 'needSign': false},
    // {'name': '获取幸运礼物列表', 'path': '/user/gift/getLuckyGifts', 'method': 'GET', 'needSign': false},
    //
    // // ============ 分类/商品 ============
    // {'name': '获取分类列表', 'path': '/category/list', 'method': 'GET', 'needSign': false},
    // {'name': '获取礼物列表', 'path': '/gift/list', 'method': 'GET', 'needSign': false},
    // {'name': '获取商品列表(充值中心)', 'path': '/p/product/getProducts', 'method': 'GET', 'params': {'type': 1}, 'needSign': false},
    // {'name': '获取商品列表(快捷弹窗)', 'path': '/p/product/getProducts', 'method': 'GET', 'params': {'type': 2}, 'needSign': false},
    // {'name': '获取商品列表(充值VIP)', 'path': '/p/product/getProducts', 'method': 'GET', 'params': {'type': 3}, 'needSign': false},
    // {'name': '按国家获取单个商品', 'path': '/p/product/getCountryProduct', 'method': 'GET', 'params': {'productId': 1, 'countryCode': 840}, 'needSign': false},
    // {'name': '获取官方支付商品id列表', 'path': '/p/product/getProductCodes', 'method': 'GET', 'needSign': false},
    // {'name': '获取商品列表附带优惠券', 'path': '/p/product/getProductsWithCoupon', 'method': 'GET', 'params': {'type': 1}, 'needSign': false},
    // {'name': '获取金币商城', 'path': '/p/exchangeStore/getStores', 'method': 'GET', 'needSign': false},
    // {'name': '获取降档营销配置', 'path': '/p/downgrade/getConfig', 'method': 'GET', 'needSign': false},
    //
    // // ============ 订单/支付 ============
    // {'name': '获取订单列表', 'path': '/p/order/getOrderList', 'method': 'POST', 'params': {'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    // {'name': '获取待领取的优惠券', 'path': '/p/coupon/getNewCoupon', 'method': 'GET', 'needSign': false},
    // {'name': '查询用户优惠券', 'path': '/p/coupon/getUserCoupons', 'method': 'GET', 'params': {'available': 1}, 'needSign': false},
    // {'name': '获取分次订单领取记录', 'path': '/p/order/getSplitOrder', 'method': 'GET', 'needSign': false},
    // {'name': '查询订单简要信息', 'path': '/p/order/getOrderSimpleList', 'method': 'POST', 'params': {'orderNos': ['TEST123']}, 'needSign': false},
    //
    // // ============ 关注相关 ============
    // {'name': '获取好友/好友请求/我的关注列表(好友)', 'path': '/user/follow/getFollowList', 'method': 'POST', 'params': {'condition': {'type': 1}, 'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    // {'name': '获取好友/好友请求/我的关注列表(请求)', 'path': '/user/follow/getFollowList', 'method': 'POST', 'params': {'condition': {'type': 2}, 'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    // {'name': '获取好友/好友请求/我的关注列表(关注)', 'path': '/user/follow/getFollowList', 'method': 'POST', 'params': {'condition': {'type': 3}, 'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    // {'name': '获取好友/好友请求/我的关注列表V2(好友)', 'path': '/user/follow/getFollowListV2', 'method': 'POST', 'params': {'condition': {'type': 1}, 'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    //
    // // ============ 黑名单相关 ============
    // {'name': '获取拉黑列表', 'path': '/user/blacklist/getBlackList', 'method': 'POST', 'params': {'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    //
    // // ============ 喜欢相关 ============
    // {'name': '获取我的喜欢列表(我喜欢的)', 'path': '/user/like/getLikeList', 'method': 'POST', 'params': {'condition': {'type': 1}, 'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    // {'name': '获取我的喜欢列表(喜欢我的)', 'path': '/user/like/getLikeList', 'method': 'POST', 'params': {'condition': {'type': 2}, 'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    //
    // // ============ 动态相关 ============
    // {'name': '发布动态', 'path': '/user/anchorMoment/publish', 'method': 'POST', 'params': {'content': 'Test', 'topicIds': []}, 'needSign': false},
    // {'name': '获取单个主播动态', 'path': '/user/anchorMoment/getOneMoment', 'method': 'GET', 'params': {'momentId': 1}, 'needSign': false},
    // {'name': '关注主播是否有新的动态', 'path': '/user/anchorMoment/hasNewFollowMoment', 'method': 'GET', 'needSign': false},
    //
    // // ============ 主播相关 ============
    // {'name': '获取主播列表', 'path': '/anchor/list', 'method': 'GET', 'params': {'page': 1, 'page_size': 10}, 'needSign': false},
    // {'name': '获取主播详情', 'path': '/anchor/detail', 'method': 'GET', 'params': {'anchor_id': 10000389}, 'needSign': false},
    // {'name': '主播端查其他主播动态', 'path': '/user/anchorMoment/anchorGetOtherMoment', 'method': 'POST', 'params': {'pageNum': 1, 'pageSize': 10, 'anchorId': 10000389}, 'needSign': false},
    // {'name': '用户端查主播动态', 'path': '/user/anchorMoment/userGetMoment', 'method': 'POST', 'params': {'pageNum': 1, 'pageSize': 10, 'anchorId': 10000389}, 'needSign': false},
    // {'name': '获取动态评论', 'path': '/user/anchorMoment/getComments', 'method': 'POST', 'params': {'momentId': 1, 'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    //
    // // ============ 消息相关 ============
    // {'name': '分页查询聊天记录', 'path': '/user/msg/getMsgRecords', 'method': 'GET', 'params': {'userId': 10000389, 'pageNum': 1, 'pageSize': 20}, 'needSign': false},
    //
    // // ============ Topia相关 ============
    // {'name': '获取标签列表', 'path': '/topia/listTopicTag', 'method': 'POST', 'needSign': false},
    // {'name': '获取话题列表', 'path': '/topia/pageTopic', 'method': 'POST', 'params': {'condition': {'tagId': 0, 'order': 0}, 'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    //
    // // ============ 心动等级相关 ============
    // {'name': '获取心动等级区间详情', 'path': '/user/heartbeatLevel/getLevelInfoConfigs', 'method': 'GET', 'params': {'otherUserId': 10000389}, 'needSign': false},
    // {'name': '获取心动等级规则列表', 'path': '/user/heartbeatLevel/getRuleList', 'method': 'GET', 'needSign': false},
    // {'name': '获取心动等级配置', 'path': '/user/heartbeatLevel/getConfig', 'method': 'GET', 'needSign': false},
    // {'name': '用户获取常驻心动主播', 'path': '/user/heartbeatLevel/getFixHeartbeatAnchors', 'method': 'GET', 'needSign': false},
    // {'name': '用户获取心动主播列表', 'path': '/user/heartbeatLevel/getHeartbeatList', 'method': 'POST', 'params': {'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    // {'name': '批量获取主播心动值', 'path': '/user/heartbeatLevel/batchGetHeartbeatValues', 'method': 'POST', 'params': {'otherUserIdList': [10000389]}, 'needSign': false},
    //
    // // ============ 直播间相关 ============
    // {'name': '获取直播间列表', 'path': '/live/room/getList', 'method': 'POST', 'params': {'page': 1, 'pageSize': 10}, 'needSign': false},
    // {'name': '获取直播间详情', 'path': '/live/room/getDetail', 'method': 'GET', 'params': {'roomId': 1}, 'needSign': false},
    // {'name': '获取直播间topN用户', 'path': '/live/room/getTopUsers', 'method': 'GET', 'params': {'roomId': 1, 'size': 10}, 'needSign': false},
    //
    // // ============ 通话相关 ============
    // {'name': '获取通话记录', 'path': '/call/call/getCallRecordVoList', 'method': 'POST', 'params': {'pageNum': 1, 'pageSize': 10}, 'needSign': false},
    // {'name': '获取违规处罚配置', 'path': '/call/violate/getConfig', 'method': 'GET', 'needSign': false},
    // {'name': '获取挂机检测配置', 'path': '/call/hangup/getConfigs', 'method': 'GET', 'needSign': false},
    // {'name': '查询对方免费邀请通话相关信息', 'path': '/call/call/getFreeInviteCallInfo', 'method': 'GET', 'params': {'userId': 10000389}, 'needSign': false},
    //
    // // ============ AI Help相关 ============
    // {'name': '获取AI Help菜单列表', 'path': '/system/aiHelp/getConfigList', 'method': 'POST', 'needSign': false},
  ];

  int successCount = 0;
  int failCount = 0;

  for (final api in apis) {
    final name = api['name'] as String;
    final path = api['path'] as String;
    final method = api['method'] as String;
    final params = api['params'] as Map<String, dynamic>?;
    final needSign = api['needSign'] as bool;

    try {
      Response response;
      if (method == 'GET') {
        response = await dio.get(path, queryParameters: params);
      } else {
        response = await dio.post(path, data: params);
      }

      final result = response.data as Map<String, dynamic>;
      results[path] = result;

      final code = result['code'];
      final success = code == 0;
      
      if (success) {
        successCount++;
        print('✅ $name ($path)');
      } else {
        failCount++;
        print('❌ $name ($path) - code: $code, msg: ${result['message']}');
      }
    } catch (e) {
      failCount++;
      print('❌ $name ($path) - 异常: $e');
    }

    // 添加延迟避免请求过快
    await Future.delayed(const Duration(milliseconds: 300));
  }

  print('\n========================================');
  print('  测试完成');
  print('  成功: $successCount');
  print('  失败: $failCount');
  print('  总计: ${apis.length}');
  print('========================================\n');

  // 保存结果到文件
  final outputFile = File('api_test_results_${DateTime.now().millisecondsSinceEpoch}.json');
  await outputFile.writeAsString(
    const JsonEncoder.withIndent('  ').convert({
      'timestamp': DateTime.now().toIso8601String(),
      'summary': {
        'total': apis.length,
        'success': successCount,
        'fail': failCount,
      },
      'results': results,
    }),
  );
  print('结果已保存到: ${outputFile.path}\n');

  exit(0);
}
