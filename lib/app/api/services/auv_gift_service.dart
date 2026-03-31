import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_net_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';

/// 送礼服务
///
/// 处理送礼相关接口：赠送礼物、幸运礼物等
class AuvGiftService extends AuvBaseService {
  /// 创建服务实例
  static AuvGiftService create() {
    final service = AuvGiftService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 获取普通礼物列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getUserGiftList();
  /// if (result.success && result.data != null) {
  ///   for (final gift in result.data!.list ?? []) {
  ///     print('${gift.name}: ${gift.diamonds}钻石');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvUserGiftListDataResponse>> getUserGiftList() async {
    try {
      final response = await get(AuvNetRoutes.getGiftList);
      return handleObjectResponse<AuvUserGiftListDataResponse>(
        response.data,
        (data) => AuvUserGiftListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserGiftListDataResponse>(e);
    }
  }

  /// 获取普通+VIP礼物列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getAllGifts();
  /// if (result.success && result.data != null) {
  ///   for (final gift in result.data!.list ?? []) {
  ///     final type = gift.isVipGift ? 'VIP礼物' : '普通礼物';
  ///     print('${gift.name} [$type]: ${gift.diamonds}钻石');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvUserGiftListDataResponse>> getAllGifts() async {
    try {
      final response = await get(AuvNetRoutes.getAllGifts);
      return handleObjectResponse<AuvUserGiftListDataResponse>(
        response.data,
        (data) => AuvUserGiftListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserGiftListDataResponse>(e);
    }
  }

  /// 获取单个礼物详情
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getOneGift(gid: 1001);
  /// if (result.success && result.data != null) {
  ///   print('${result.data!.name}: ${result.data!.diamonds}钻石');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvGiftDetailResponse>> getOneGift({required int gid}) async {
    try {
      final response = await get(
        AuvNetRoutes.getOneGift,
        queryParameters: {'gid': gid},
      );
      return handleObjectResponse<AuvGiftDetailResponse>(
        response.data,
        (data) => AuvGiftDetailResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvGiftDetailResponse>(e);
    }
  }

  /// 获取礼物动作列表
  ///
  /// 示例:
  /// ```dart
  /// // 获取1v1动作
  /// final result1v1 = await giftService.getActions(type: AuvGiftActionType.oneVOne);
  ///
  /// // 获取直播间动作
  /// final resultLive = await giftService.getActions(type: AuvGiftActionType.liveRoom);
  ///
  /// if (result.success && result.data != null) {
  ///   for (final action in result.data!) {
  ///     print('${action.actionName}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvGiftActionResponse>>> getActions({
    AuvGiftActionType? type,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getActions,
        queryParameters: type != null ? {'type': type.value} : null,
      );
      return handleListResponse<AuvGiftActionResponse>(
        response.data,
        (data) => AuvGiftActionResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvGiftActionResponse>>(e);
    }
  }

  /// 获取自己的礼物秀列表
  ///
  /// 获取自己配置的礼物秀列表
  ///
  /// 【请求参数】
  /// [type] 类型（可选）
  ///   - 1: 1v1动作
  ///   - 2: 直播间动作
  ///   - 不传默认为1
  ///
  /// 【返回值】
  /// 返回礼物秀列表
  ///
  /// 示例:
  /// ```dart
  /// // 获取1v1礼物秀
  /// final result = await giftService.getGiftShows();
  ///
  /// // 获取直播间礼物秀
  /// final resultLive = await giftService.getGiftShows(
  ///   type: AuvGiftShowType.liveRoom,
  /// );
  ///
  /// if (result.success && result.data != null) {
  ///   for (final show in result.data!) {
  ///     print('${show.giftName}: ${show.actionName}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvGiftShowResponse>>> getGiftShows({
    AuvGiftShowType? type,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getGiftShows,
        queryParameters: type != null ? {'type': type.value} : null,
      );
      return handleListResponse<AuvGiftShowResponse>(
        response.data,
        (data) => AuvGiftShowResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvGiftShowResponse>>(e);
    }
  }

  /// 获取对方的礼物秀列表
  ///
  /// 获取指定主播的礼物秀列表
  ///
  /// 【请求参数】
  /// [userId] 主播id（必填）
  /// [type] 类型（可选）
  ///   - 1: 1v1动作
  ///   - 2: 直播间动作
  ///   - 不传默认为1
  ///
  /// 【返回值】
  /// 返回礼物秀列表
  ///
  /// 示例:
  /// ```dart
  /// // 获取主播的1v1礼物秀
  /// final result = await giftService.getAnchorGiftShows(userId: 123456);
  ///
  /// // 获取主播的直播间礼物秀
  /// final resultLive = await giftService.getAnchorGiftShows(
  ///   userId: 123456,
  ///   type: AuvGiftShowType.liveRoom,
  /// );
  ///
  /// if (result.success && result.data != null) {
  ///   for (final show in result.data!) {
  ///     print('${show.giftName}: ${show.actionName} - ${show.diamonds}钻石');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvAnchorGiftShowResponse>>> getAnchorGiftShows({
    required int userId,
    AuvGiftShowType? type,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'userId': userId,
      };
      if (type != null) {
        queryParams['type'] = type.value;
      }

      final response = await get(
        AuvNetRoutes.getAnchorGiftShows,
        queryParameters: queryParams,
      );
      return handleListResponse<AuvAnchorGiftShowResponse>(
        response.data,
        (data) => AuvAnchorGiftShowResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvAnchorGiftShowResponse>>(e);
    }
  }

  /// 设置1v1礼物秀
  ///
  /// 设置自己的1v1礼物秀列表
  ///
  /// 【请求参数】
  /// [giftShows] 礼物秀列表（必填），每项包含:
  ///   - gid: 礼物ID
  ///   - actionId: 动作id
  ///
  /// 【返回值】
  /// null表示成功
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.setGiftShows(
  ///   giftShows: [
  ///     AuvSetGiftShowItem(gid: 1001, actionId: 1),
  ///     AuvSetGiftShowItem(gid: 1002, actionId: 2),
  ///   ],
  /// );
  /// if (result.success) {
  ///   print('设置成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> setGiftShows({
    required List<AuvSetGiftShowItem> giftShows,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.setGiftShows,
        data: giftShows.map((e) => e.toJson()).toList(),
        needSign: true,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 增加直播间礼物秀
  ///
  /// 增加直播间礼物秀
  ///
  /// 【请求参数】
  /// [gid] 礼物ID（必填）
  /// [actionId] 动作id（必填）
  ///
  /// 【返回值】
  /// null表示成功
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.addLiveGiftShow(
  ///   gid: 1001,
  ///   actionId: 1,
  /// );
  /// if (result.success) {
  ///   print('添加成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> addLiveGiftShow({
    required int gid,
    required int actionId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.addLiveGiftShow,
        data: {
          'gid': gid,
          'actionId': actionId,
        },
        needSign: true,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 修改直播间礼物秀
  ///
  /// 修改直播间礼物秀
  ///
  /// 【请求参数】
  /// [showId] 主键id（必填）
  /// [gid] 礼物ID（可选）
  /// [actionId] 动作id（可选）
  ///
  /// 【返回值】
  /// null表示成功
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.updateLiveGiftShow(
  ///   showId: 123,
  ///   gid: 1002,
  ///   actionId: 2,
  /// );
  /// if (result.success) {
  ///   print('修改成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> updateLiveGiftShow({
    required int showId,
    int? gid,
    int? actionId,
  }) async {
    try {
      final data = <String, dynamic>{
        'showId': showId,
      };
      if (gid != null) data['gid'] = gid;
      if (actionId != null) data['actionId'] = actionId;

      final response = await post(
        AuvNetRoutes.updateLiveGiftShow,
        data: data,
        needSign: true,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 删除直播间礼物秀
  ///
  /// 删除直播间礼物秀
  ///
  /// 【请求参数】
  /// [showId] 主键id（必填）
  ///
  /// 【返回值】
  /// null表示成功
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.deleteLiveGiftShow(showId: 123);
  /// if (result.success) {
  ///   print('删除成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> deleteLiveGiftShow({
    required int showId,
  }) async {
    try {
      final response = await delete(
        AuvNetRoutes.deleteLiveGiftShow.replaceAll('{showId}', showId.toString()),
        needSign: true,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 设置直播间礼物秀开关
  ///
  /// 设置直播间礼物秀开关
  ///
  /// 【请求参数】
  /// [flag] 直播间礼物秀开关（必填），0.关闭，1.开启
  ///
  /// 【返回值】
  /// null表示成功
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.setLiveGiftShowFlag(flag: 1);
  /// if (result.success) {
  ///   print('设置成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> setLiveGiftShowFlag({
    required int flag,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.setLiveGiftShowFlag,
        data: {'flag': flag},
        needSign: true,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 获取直播间礼物秀开关
  ///
  /// 获取直播间礼物秀开关状态
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// flag: 直播间礼物秀开关，0.关闭，1.开启
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getLiveGiftShowFlag();
  /// if (result.success && result.data != null) {
  ///   print('礼物秀开关状态: ${result.data}');
  /// }
  /// ```
  Future<AuvBaseResponse<int>> getLiveGiftShowFlag() async {
    try {
      final response = await get(
        AuvNetRoutes.getLiveGiftShowFlag,
      );
      return handleSimpleResponse<int>(
        response.data,
        (data) => data as int,
      );
    } catch (e) {
      return handleError<int>(e);
    }
  }

  /// 主播索要礼物
  ///
  /// 主播向用户索要礼物
  ///
  /// 【请求参数】
  /// [userId] 用户id（必填）
  /// [gid] 礼物ID（必填）
  /// [type] 类型（必填），1.私信中索要，2.通话中索要
  /// [begId] 主播索要id（必填）
  ///
  /// 【返回值】
  /// content: 索要文案
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.begGift(
  ///   userId: 12345,
  ///   gid: 1001,
  ///   type: 1,
  ///   begId: 'beg_001',
  /// );
  /// if (result.success && result.data != null) {
  ///   print('索要文案: ${result.data!['content']}');
  /// }
  /// ```
  Future<AuvBaseResponse<Map<String, dynamic>>> begGift({
    required int userId,
    required int gid,
    required int type,
    required String begId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.begGift,
        data: {
          'userId': userId,
          'gid': gid,
          'type': type,
          'begId': begId,
        },
        needSign: true,
      );
      return handleSimpleResponse<Map<String, dynamic>>(
        response.data,
        (data) => Map<String, dynamic>.from(data as Map),
      );
    } catch (e) {
      return handleError<Map<String, dynamic>>(e);
    }
  }

  /// 获取送礼榜单
  ///
  /// 获取送礼榜单列表
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// List<AuvGiftRankItemResponse>:
  ///   - gid: 礼物ID
  ///   - senderId: 发送方ID
  ///   - receiverId: 接收方ID
  ///   - quantity: 礼物数量
  ///   - diamonds: 礼物价值钻石数
  ///   - time: 送礼时间
  ///   - senderNickname: 发送方昵称
  ///   - receiverNickname: 接收方昵称
  ///   - senderPortrait: 发送方头像
  ///   - receiverPortrait: 接收方头像
  ///   - icon: 礼物图标
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getGiftRank();
  /// if (result.success && result.data != null) {
  ///   for (final item in result.data!) {
  ///     print('${item.senderNickname} 送给 ${item.receiverNickname}: ${item.quantity}个礼物');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvGiftRankItemResponse>>> getGiftRank() async {
    try {
      final response = await get(
        AuvNetRoutes.getGiftRank,
      );
      return handleListResponse<AuvGiftRankItemResponse>(
        response.data,
        (data) => AuvGiftRankItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvGiftRankItemResponse>>(e);
    }
  }

  /// 客户端获取主播礼物榜单
  ///
  /// 获取指定主播的礼物榜单
  ///
  /// 【请求参数】
  /// [userId] 主播id（必填）
  /// [gid] 礼物id（必填）
  ///
  /// 【返回值】
  /// List<AuvAnchorGiftRankItemResponse>:
  ///   - gid: 礼物ID
  ///   - icon: 礼物图标
  ///   - quantity: 礼物数量
  ///   - userId: 用户id
  ///   - nickname: 用户昵称
  ///   - portrait: 用户头像
  ///   - vipFlag: 是否vip
  ///   - level: 用户等级
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getAnchorGiftRank(
  ///   userId: 123,
  ///   gid: 1001,
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final item in result.data!) {
  ///     print('${item.nickname}: ${item.quantity}个礼物');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvAnchorGiftRankItemResponse>>> getAnchorGiftRank({
    required int userId,
    required int gid,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getAnchorGiftRank,
        queryParameters: {
          'userId': userId,
          'gid': gid,
        },
      );
      return handleListResponse<AuvAnchorGiftRankItemResponse>(
        response.data,
        (data) => AuvAnchorGiftRankItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvAnchorGiftRankItemResponse>>(e);
    }
  }

  /// 主播端获取自己的送礼榜单
  ///
  /// 获取当前登录主播自己收到的指定礼物的送礼榜单
  ///
  /// 【请求参数】
  /// [gid] 礼物id（必填）
  ///
  /// 【返回值】
  /// List<AuvAnchorGiftRankItemResponse>:
  ///   - gid: 礼物ID
  ///   - icon: 礼物图标
  ///   - quantity: 礼物数量
  ///   - userId: 用户id
  ///   - nickname: 用户昵称
  ///   - portrait: 用户头像
  ///   - vipFlag: 是否vip
  ///   - level: 用户等级
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getMyGiftRank(gid: 1001);
  /// if (result.success && result.data != null) {
  ///   for (final item in result.data!) {
  ///     print('${item.nickname}: 送了${item.quantity}个礼物');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvAnchorGiftRankItemResponse>>> getMyGiftRank({
    required int gid,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getMyGiftRank,
        queryParameters: {
          'gid': gid,
        },
      );
      return handleListResponse<AuvAnchorGiftRankItemResponse>(
        response.data,
        (data) => AuvAnchorGiftRankItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvAnchorGiftRankItemResponse>>(e);
    }
  }

  /// 主播端获取自己的送礼top1
  ///
  /// 获取当前登录主播自己收到的所有礼物的Top1用户
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// List<AuvMyGiftTopOneItemResponse>:
  ///   - gid: 礼物ID
  ///   - topOneUserId: top1用户id
  ///   - topOneNickname: top1用户昵称
  ///   - topOnePortrait: top1用户头像
  ///   - topOneVipFlag: top1是否vip
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getMyGiftTopOne();
  /// if (result.success && result.data != null) {
  ///   for (final item in result.data!) {
  ///     print('礼物${item.gid}的Top1: ${item.topOneNickname}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvMyGiftTopOneItemResponse>>> getMyGiftTopOne() async {
    try {
      final response = await get(
        AuvNetRoutes.getMyGiftTopOne,
      );
      return handleListResponse<AuvMyGiftTopOneItemResponse>(
        response.data,
        (data) => AuvMyGiftTopOneItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvMyGiftTopOneItemResponse>>(e);
    }
  }

  /// 主播端获取自己收到的礼物墙
  ///
  /// 获取当前登录主播自己收到的礼物墙列表
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// List<AuvMyGiftWallItemResponse>:
  ///   - gid: 礼物ID
  ///   - name: 礼物名称
  ///   - diamonds: 钻石价格
  ///   - icon: 礼物图标
  ///   - receiveNum: 收到的总数
  ///   - topOneUserId: top1用户id
  ///   - topOneNickname: top1用户昵称
  ///   - topOnePortrait: top1用户头像
  ///   - topOneVipFlag: top1用户是否vip
  ///   - currDiffNum: 当前用户距离top1用户相差的送礼数量
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getMyGiftWall();
  /// if (result.success && result.data != null) {
  ///   for (final item in result.data!) {
  ///     print('${item.name}: 收到${item.receiveNum}个');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvMyGiftWallItemResponse>>> getMyGiftWall() async {
    try {
      final response = await get(
        AuvNetRoutes.getMyGiftWall,
      );
      return handleListResponse<AuvMyGiftWallItemResponse>(
        response.data,
        (data) => AuvMyGiftWallItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvMyGiftWallItemResponse>>(e);
    }
  }

  /// 获取钻石数达到试播成功的礼物列表
  ///
  /// 获取钻石数达到试播成功的礼物列表
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// AuvUserGiftListDataResponse:
  ///   - total: 总记录数
  ///   - list: 礼物列表
  ///     - gid: 礼物ID
  ///     - name: 礼物名称
  ///     - diamonds: 钻石价格
  ///     - coins: 金币价格
  ///     - giftType: 礼物类型
  ///     - icon: 图标
  ///     - animEffectUrl: 特效
  ///     - md5: md5
  ///   - pageNum: 当前页码
  ///   - pageSize: 每页数量
  ///   - pages: 总页数
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getTrialReachGifts();
  /// if (result.success && result.data != null) {
  ///   for (final gift in result.data!.list ?? []) {
  ///     print('${gift.name}: ${gift.diamonds}钻石');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvUserGiftListDataResponse>> getTrialReachGifts() async {
    try {
      final response = await get(
        AuvNetRoutes.getTrialReachGifts,
      );
      return handleObjectResponse<AuvUserGiftListDataResponse>(
        response.data,
        (data) => AuvUserGiftListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserGiftListDataResponse>(e);
    }
  }

  /// 获取幸运礼物列表
  ///
  /// 获取幸运礼物列表
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// List<AuvLuckyGiftItemResponse>:
  ///   - luckyId: 主键id
  ///   - probability: 礼物概率
  ///   - gid: 礼物ID
  ///   - name: 礼物名称
  ///   - diamonds: 钻石价格
  ///   - coins: 金币价格
  ///   - giftType: 礼物类型
  ///   - icon: 图标
  ///   - animEffectUrl: 特效
  ///   - md5: md5
  ///
  /// 示例:
  /// ```dart
  /// final result = await giftService.getLuckyGifts();
  /// if (result.success && result.data != null) {
  ///   for (final gift in result.data!) {
  ///     print('${gift.name}: ${gift.probabilityPercent}%概率');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvLuckyGiftItemResponse>>> getLuckyGifts() async {
    try {
      final response = await get(
        AuvNetRoutes.getLuckyGifts,
      );
      return handleListResponse<AuvLuckyGiftItemResponse>(
        response.data,
        (data) => AuvLuckyGiftItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvLuckyGiftItemResponse>>(e);
    }
  }

  /// 赠送礼物(真实礼物)
  ///
  /// 向用户/主播赠送真实礼物，消耗钻石
  ///
  /// 【请求参数】
  /// [receiverId] 接收方id（必填）
  /// [quantity] 数量（必填）
  /// [gid] 礼物id（必填）
  /// [channelName] 游戏房频道id（可选）
  /// [begId] 主播索要id（可选）
  /// [liveChannelName] 直播间频道号（可选）
  ///
  /// 【返回值】
  /// 返回送礼结果:
  ///   - gid: 礼物id
  ///   - deposit: 剩余钻石
  ///   - becomeTopOne: 是否从非top1变成了top1
  ///
  /// 注意: 此接口需要签名验证
  Future<AuvBaseResponse<AuvGiftSendResultResponse>> sendRealGift({
    required int receiverId,
    required int quantity,
    required int gid,
    String? channelName,
    String? begId,
    String? liveChannelName,
  }) async {
    try {
      final data = {
        'receiverId': receiverId,
        'quantity': quantity,
        'gid': gid,
        if (channelName != null) 'channelName': channelName,
        if (begId != null) 'begId': begId,
        if (liveChannelName != null) 'liveChannelName': liveChannelName,
      };

      final response = await post(
        AuvNetRoutes.sendRealGift,
        data: data,
        needSign: true,
      );
      return handleResponse<AuvGiftSendResultResponse>(
        response.data,
        (data) => AuvGiftSendResultResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvGiftSendResultResponse>(e);
    }
  }

  /// 赠送幸运礼物
  /// 
  /// 向主播赠送幸运礼物，有概率触发额外奖励
  /// 
  /// [giftId] 礼物ID（必填）
  /// [anchorId] 主播ID（必填）
  /// [roomId] 房间ID（必填）
  /// [num] 礼物数量（必填）
  /// 
  /// 返回值: 送礼结果响应
  /// 
  /// 注意: 此接口需要签名验证
  Future<AuvBaseResponse<AuvGiftSendResultResponse>> sendLuckyGift({
    required String giftId,
    required String anchorId,
    required String roomId,
    required int num,
  }) async {
    try {
      final data = {
        'gift_id': giftId,
        'anchor_id': anchorId,
        'room_id': roomId,
        'num': num,
      };

      final response = await post(
        AuvNetRoutes.sendLuckyGift,
        data: data,
        needSign: true,
      );
      return handleResponse<AuvGiftSendResultResponse>(
        response.data,
        (data) => AuvGiftSendResultResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvGiftSendResultResponse>(e);
    }
  }
}
