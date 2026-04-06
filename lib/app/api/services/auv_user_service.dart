import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_net_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/models/user/user_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/api/models/auv_msg_model.dart';

import '../models/user/auv_relation_count_response.dart';
import '../models/user/auv_like_list_response.dart';
import '../models/user/auv_follow_list_response.dart';
import '../models/user/auv_follow_list_v2_response.dart';
import '../models/auv_invite_model.dart';
import '../models/auv_user_model.dart';

/// 用户服务
/// 
/// 处理用户相关接口：用户信息、签到、个人资料等
class AuvUserService extends AuvBaseService {
  /// 创建服务实例
  static AuvUserService create() {
    final service = AuvUserService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 获取用户详情（我的页面）

  /// 获取当前登录用户的详细信息，包含金币余额、VIP状态、粉丝数等

  ///

  /// 返回值: 用户详情响应，包含用户基本信息、账户数据、等级信息等
  Future<AuvBaseResponse<AuvUserDetailResponse>> getUserDetail() async {
    try {
      final response = await get(AuvNetRoutes.getUserDetail);
      return handleResponse<AuvUserDetailResponse>(
        response.data,
        (data) => AuvUserDetailResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserDetailResponse>(e);
    }
  }

  /// 不登录获取R信息
  ///
  /// 不登录状态下获取用户审核模式等信息
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 返回R信息:
  ///   - rFlag: 是否审核模式，0.否，1.是
  ///   - aFlag: 未知
  ///   - tFlag: 未知
  ///   - nickname: 用户昵称
  ///   - turl: h5地址
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getRInfo();
  /// if (result.success && result.data != null) {
  ///   print('是否审核模式: ${result.data!.isReviewMode}');
  ///   print('H5地址: ${result.data!.turl}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvRInfoResponse>> getRInfo() async {
    try {
      final response = await get(AuvNetRoutes.getRInfo);
      return handleResponse<AuvRInfoResponse>(
        response.data,
        (data) => AuvRInfoResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvRInfoResponse>(e);
    }
  }

  /// 获取邀请奖励配置列表
  ///
  /// 获取邀请奖励的配置列表
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 返回邀请奖励配置列表:
  ///   - countryCode: 国家编码
  ///   - countryName: 国家名称
  ///   - countryPath: 国旗地址
  ///   - femaleAuthCoins: 被邀请女用户认证奖励（金币）
  ///   - femaleIncomeCoins: 被邀请女用户收入达标奖励（金币）
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.queryInviteRewardConfig();
  /// if (result.success && result.data != null) {
  ///   for (final config in result.data!) {
  ///     print('${config.countryName}: 认证奖励 ${config.femaleAuthCoins}金币');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvInviteRewardConfigResponse>>> queryInviteRewardConfig() async {
    try {
      final response = await get(AuvNetRoutes.queryInviteRewardConfig);
      return handleListResponse<AuvInviteRewardConfigResponse>(
        response.data,
        (data) => AuvInviteRewardConfigResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvInviteRewardConfigResponse>>(e);
    }
  }

  /// 根据邀请码查询用户ID
  ///
  /// 根据邀请码查询对应的用户ID
  ///
  /// 【请求参数】
  /// [inviteCode] 邀请码（必填）
  ///
  /// 【返回值】
  /// 返回邀请人信息:
  ///   - userId: 邀请人用户id
  ///   - inviteCode: 邀请码
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getUserIdByInviteCode('ABC123');
  /// if (result.success && result.data != null) {
  ///   print('邀请人ID: ${result.data!.userId}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvUserIdByInviteCodeResponse>> getUserIdByInviteCode({
    required String inviteCode,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getUserIdByInviteCode,
        queryParameters: {'inviteCode': inviteCode},
      );
      return handleResponse<AuvUserIdByInviteCodeResponse>(
        response.data,
        (data) => AuvUserIdByInviteCodeResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserIdByInviteCodeResponse>(e);
    }
  }

  /// 获取昵称头像审核状态
  ///
  /// 获取用户昵称和头像的审核状态
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 返回审核状态:
  ///   - portraitStatus: 头像审核状态，0.待审核，1.审核通过，2.审核失败
  ///   - nicknameStatus: 昵称审核状态，0.待审核，1.审核通过，2.审核失败
  ///   - portraitUpdatedAt: 头像审核变更时间
  ///   - nicknameUpdatedAt: 昵称审核变更时间
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getNicknamePortraitStatus();
  /// if (result.success && result.data != null) {
  ///   print('头像状态: ${result.data!.portraitStatusDesc}');
  ///   print('昵称状态: ${result.data!.nicknameStatusDesc}');
  ///   if (result.data!.isPortraitPending) {
  ///     print('头像正在审核中');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvNicknamePortraitStatusResponse>> getNicknamePortraitStatus() async {
    try {
      final response = await get(AuvNetRoutes.getNicknamePortraitStatus);
      return handleResponse<AuvNicknamePortraitStatusResponse>(
        response.data,
        (data) => AuvNicknamePortraitStatusResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvNicknamePortraitStatusResponse>(e);
    }
  }

  /// 获取每日签到相关数据
  ///
  /// 获取每日签到的相关信息和奖励列表
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 返回签到数据:
  ///   - signDay: 此刻待签到的天数（=7时前6天全签；=0时7天全签）
  ///   - signFlag: 此刻是否需要签到
  ///   - nexTimes: 下一次倒计时时间
  ///   - rewardList: 奖励列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getSignInVo();
  /// if (result.success && result.data != null) {
  ///   print('待签到天数: ${result.data!.signDay}');
  ///   print('是否需要签到: ${result.data!.needsSignIn}');
  ///   for (final reward in result.data!.rewardList) {
  ///     print('第${reward.signDay}天: ${reward.rewardDesc}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvSignInVoResponse>> getSignInVo() async {
    try {
      final response = await get(AuvNetRoutes.getSignInVo);
      return handleResponse<AuvSignInVoResponse>(
        response.data,
        (data) => AuvSignInVoResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvSignInVoResponse>(e);
    }
  }

  /// 检查用户是否缺少某些数据
  ///
  /// 检查用户是否填写了必要的个人资料（签名、标签等）
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 返回用户资料检查结果:
  ///   - userId: 用户ID
  ///   - hasSignature: 是否有签名（0.否，1.是）
  ///   - hasTag: 是否有标签（0.否，1.是）
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.checkUserDetail();
  /// if (result.success && result.data != null) {
  ///   print('用户ID: ${result.data!.userId}');
  ///   print('是否有签名: ${result.data!.hasSetSignature}');
  ///   print('是否有标签: ${result.data!.hasSetTag}');
  ///   print('资料是否完整: ${result.data!.isProfileComplete}');
  ///   print('缺少: ${result.data!.missingItems}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvUserCheckDetail>> checkUserDetail() async {
    try {
      final response = await get(AuvNetRoutes.checkUserDetail);
      return handleResponse<AuvUserCheckDetail>(
        response.data,
        (data) => AuvUserCheckDetail.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserCheckDetail>(e);
    }
  }

  /// 获取多账号用户
  ///
  /// 存在多个账号时返回余额最多和最新登录的一个账号，与游客登录逻辑一致
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 返回多账号用户信息:
  ///   - userId: 用户ID
  ///   - username: 用于显示的UID
  ///   - nickname: 用户昵称
  ///   - portrait: 头像
  ///   - email: 邮箱
  ///   - sex: 性别，1.男，2.女
  ///   - oauthTypes: 登录方式列表，0.谷歌登录，4.账号密码登录
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getMultiUser();
  /// if (result.success && result.data != null) {
  ///   final user = result.data!;
  ///   print('用户ID: ${user.userId}');
  ///   print('昵称: ${user.nickname}');
  ///   print('登录方式: ${user.oauthTypeDescs}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvMultiUserResponse>> getMultiUser() async {
    try {
      final response = await get(AuvNetRoutes.getMultiUser);
      return handleResponse<AuvMultiUserResponse>(
        response.data,
        (data) => AuvMultiUserResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvMultiUserResponse>(e);
    }
  }

  /// 获取用户钻石排行
  ///
  /// 【请求参数】
  /// - timeLevel: 排行榜类型，1.当日，2.本周
  ///
  /// 【返回值】
  /// 返回用户钻石排行列表:
  ///   - userId: 用户ID
  ///   - username: 用于显示的UID
  ///   - nickname: 用户昵称
  ///   - portrait: 头像
  ///   - vipFlag: 是否VIP
  ///   - level: 等级值
  ///   - diamonds: 钻石数，小数点后两位
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getDiamondRanking(timeLevel: 1);
  /// if (result.success && result.data != null) {
  ///   for (final item in result.data!) {
  ///     print('${item.nickname}: ${item.diamonds}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvDiamondRankingItem>>> getDiamondRanking({
    required int timeLevel,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getDiamondRanking,
        queryParameters: {'timeLevel': timeLevel},
      );
      return handleListResponse<AuvDiamondRankingItem>(
        response.data,
        (data) => AuvDiamondRankingItem.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvDiamondRankingItem>>(e);
    }
  }

  /// 获取我的背包
  ///
  /// 获取当前用户的道具背包列表，包含视频卡、钻石加成卡、礼物卡等
  ///
  /// 【返回值】
  /// 返回用户道具列表
  ///   - userId: 用户id
  ///   - propType: 道具类型，1.视频卡，2.钻石加成卡，3.礼物卡，4.聊天卡，5.匹配卡，6.头像框
  ///   - propValue: 视频卡时长（毫秒数）/钻石加成/礼物id
  ///   - propNum: 道具数量
  ///   - name: 礼物卡 的 礼物名称
  ///   - icon: 礼物卡 的礼物图标
  ///   - animEffectUrl: 礼物卡 的礼物特效
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getUserPropVo();
  /// if (result.success && result.data != null) {
  ///   for (final prop in result.data!) {
  ///     print('道具类型: ${prop.propTypeLabel}');
  ///     print('数量: ${prop.propNum}');
  ///     if (prop.propType == AuvPropType.videoCard) {
  ///       print('视频卡时长: ${prop.videoCardSeconds}秒');
  ///     }
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvUserPropModel>>> getUserPropVo() async {
    try {
      final response = await get(AuvNetRoutes.getUserPropVo);
      return handleListResponse<AuvUserPropModel>(
        response.data,
        (data) => AuvUserPropModel.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvUserPropModel>>(e);
    }
  }

  /// 用户端-获取钻石/金币明细
  ///
  /// 分页查询用户的钻石或金币变动明细记录
  ///
  /// 【请求参数】
  /// [pageNum] 页码（必填）
  /// [pageSize] 每页条数（必填）
  /// [condition] 查询条件（必填）
  ///   - action: 变动类型，1.收入，2.支出
  ///   - startTimes: 开始时间毫秒时间戳
  ///   - endTimes: 结束时间毫秒时间戳
  ///   - isGame: 是否查看游戏明细
  ///
  /// 【返回值】
  /// 返回分页明细数据
  ///   - total: 总记录数
  ///   - list: 明细列表
  ///     - userId: 用户id
  ///     - recordType: 消费代码
  ///     - recordTypeStr: 类型描述
  ///     - action: 变动类型，1.收入，2.支出
  ///     - createTimes: 时间戳
  ///     - value: 钻石数or金币数（负数表示支出）
  ///   - pageNum: 当前页码
  ///   - pageSize: 每页条数
  ///   - pages: 总页数
  ///   - hasNextPage: 是否有下一页
  ///   - isFirstPage: 是否第一页
  ///   - isLastPage: 是否最后一页
  ///
  /// 示例:
  /// ```dart
  /// // 查询支出明细
  /// final result = await userService.getUserBalanceRecords(
  ///   pageNum: 1,
  ///   pageSize: 20,
  ///   condition: AuvBalanceRecordCondition(
  ///     action: 2,
  ///     startTimes: DateTime.now().subtract(Duration(days: 30)).millisecondsSinceEpoch,
  ///     endTimes: DateTime.now().millisecondsSinceEpoch,
  ///   ),
  /// );
  /// if (result.success && result.data != null) {
  ///   print('总共 ${result.data!.total} 条记录');
  ///   for (final record in result.data!.list ?? []) {
  ///     print('${record.recordTypeStr}: ${record.value}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvBalanceRecordDataResponse>> getUserBalanceRecords({
    required int pageNum,
    required int pageSize,
    required AuvBalanceRecordCondition condition,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getUserBalanceRecords,
        data: {
          'condition': condition.toJson(),
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
        needSign: false,
      );
      return handleObjectResponse<AuvBalanceRecordDataResponse>(
        response.data,
        (data) => AuvBalanceRecordDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvBalanceRecordDataResponse>(e);
    }
  }

  /// 设置用户推送token
  ///
  /// 设置用户的Firebase推送token，用于接收推送通知
  ///
  /// 【请求参数】
  /// [firebaseToken] 推送token（必填）
  ///
  /// 【返回值】
  /// 无
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.updateFirebaseToken(
  ///   firebaseToken: 'your-firebase-token-here',
  /// );
  /// ```
  Future<AuvBaseResponse<void>> updateFirebaseToken({
    required String firebaseToken,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.updateFirebaseToken,
        data: {'firebaseToken': firebaseToken},
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 设置用户广告归因
  ///
  /// 设置用户的广告归因信息，用于渠道统计
  ///
  /// 【请求参数】
  /// [network] 归因渠道名称（必填）
  /// [campaign] 推广活动名称（可选）
  /// [clickLabel] 安装被标记的点击标签（可选）
  /// [trackerToken] 设备当前归因跟踪链接的跟踪码（可选）
  /// [trackerName] 设备当前归因跟踪链接的名称（可选）
  /// [adgroup] 设备当前归因广告组的名称（可选）
  /// [creative] 设备当前归因素材的名称（可选）
  /// [adid] 设备的唯一 Adjust ID（可选）
  /// [costType] 推广活动定价模型，如 cpi（可选）
  /// [costAmount] 安装成本（可选）
  /// [costCurrency] 成本相关的货币代码，ISO 4217标准，3字符（可选）
  ///
  /// 【返回值】
  /// 无
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.updateAdFlag(
  ///   network: 'google',
  ///   campaign: 'summer_promo',
  ///   adid: 'abc123',
  /// );
  /// ```
  Future<AuvBaseResponse<void>> updateAdFlag({
    required String network,
    String? campaign,
    String? clickLabel,
    String? trackerToken,
    String? trackerName,
    String? adgroup,
    String? creative,
    String? adid,
    String? costType,
    String? costAmount,
    String? costCurrency,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.updateAdFlag,
        data: {
          'network': network,
          if (campaign != null) 'campaign': campaign,
          if (clickLabel != null) 'clickLabel': clickLabel,
          if (trackerToken != null) 'trackerToken': trackerToken,
          if (trackerName != null) 'trackerName': trackerName,
          if (adgroup != null) 'adgroup': adgroup,
          if (creative != null) 'creative': creative,
          if (adid != null) 'adid': adid,
          if (costType != null) 'costType': costType,
          if (costAmount != null) 'costAmount': costAmount,
          if (costCurrency != null) 'costCurrency': costCurrency,
        },
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 注销账号
  ///
  /// 注销当前登录用户账号，注销后不可恢复
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 无
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.deleteUser();
  /// if (result.success) {
  ///   // 账号已注销，跳转到登录页
  /// }
  /// ```
  Future<AuvBaseResponse<void>> deleteUser() async {
    try {
      final response = await post(
        AuvNetRoutes.deleteUser,
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 根据账号密码注销账号
  ///
  /// 根据用户名和密码注销账号，注销后不可恢复
  ///
  /// 【请求参数】
  /// [username] 用户名（必填）
  /// [password] 明文密码（必填）
  ///
  /// 【返回值】
  /// 无
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.deleteUserByPassword(
  ///   username: 'user@example.com',
  ///   password: 'your_password',
  /// );
  /// if (result.success) {
  ///   // 账号已注销，跳转到登录页
  /// }
  /// ```
  Future<AuvBaseResponse<void>> deleteUserByPassword({
    required String username,
    required String password,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.deleteUserByPassword,
        data: {
          'username': username,
          'password': password,
        },
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 更新App分数
  ///
  /// 更新用户对App的评价分数
  ///
  /// 【请求参数】
  /// [recordId] 记录id（必填）
  /// [score] 分数（必填）
  /// [remark] 备注（可选）
  ///
  /// 【返回值】
  /// 无
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.updateAppRateScore(
  ///   recordId: 12345,
  ///   score: 4.5,
  ///   remark: 'Great app!',
  /// );
  /// if (result.success) {
  ///   // 分数更新成功
  /// }
  /// ```
  Future<AuvBaseResponse<void>> updateAppRateScore({
    required int recordId,
    required double score,
    String? remark,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.updateAppRateScore,
        data: {
          'recordId': recordId,
          'score': score,
          if (remark != null) 'remark': remark,
        },
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 任务领取
  ///
  /// 领取任务奖励
  ///
  /// 【请求参数】
  /// [taskUnique] 任务唯一标识（必填）
  /// [round] 轮次（可选），默认1
  ///
  /// 【返回值】
  /// 返回任务奖励信息:
  ///   - rewardJson: 奖励JSON列表
  ///   - rewardVo: 奖励详情
  ///   - taskUnique: 任务唯一标识
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.userDraw(
  ///   taskUnique: 'first_recharge',
  ///   round: 1,
  /// );
  /// if (result.success && result.data != null) {
  ///   print('钻石奖励: ${result.data!.rewardVo?.diamondNum}');
  ///   print('任务标识: ${result.data!.taskUnique}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvTaskDrawResponse>> userDraw({
    required String taskUnique,
    int? round,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.userDraw,
        data: {
          'taskUnique': taskUnique,
          if (round != null) 'round': round,
        },
        needSign: false,
      );
      return handleResponse<AuvTaskDrawResponse>(
        response.data,
        (data) => AuvTaskDrawResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvTaskDrawResponse>(e);
    }
  }

  /// 是否有过填写邀请码
  ///
  /// 检查用户是否填写过邀请码
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// true: 有邀请记录
  /// false: 没有邀请记录
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.isHasInviteRecord();
  /// if (result.success) {
  ///   final hasRecord = result.data ?? false;
  ///   print('是否有邀请记录: $hasRecord');
  /// }
  /// ```
  Future<AuvBaseResponse<bool>> isHasInviteRecord() async {
    try {
      final response = await post(
        AuvNetRoutes.isHasInviteRecord,
        needSign: false,
      );
      final data = response.data['data'];
      return AuvBaseResponse<bool>(
        code: response.data['code'],
        message: response.data['message'],
        timestamp: response.data['timestamp'],
        data: data == true,
      );
    } catch (e) {
      return handleError<bool>(e);
    }
  }

  /// 获取邀请奖励记录列表
  ///
  /// 获取用户的邀请奖励记录列表
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 返回邀请用户列表:
  ///   - inviteeUserId: 被邀请用户ID
  ///   - nickname: 昵称
  ///   - portrait: 头像
  ///   - createdAt: 创建时间
  ///   - type: 类型（1注册奖励 2充值奖励）
  ///   - reward: 奖励钻石数（×100）
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getInviteUserVoList();
  /// if (result.success && result.data != null) {
  ///   for (final user in result.data!) {
  ///     print('被邀请用户: ${user.nickname}');
  ///     print('奖励类型: ${user.rewardTypeStr}');
  ///     print('奖励钻石: ${user.reward}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvInviteUserVoResponse>>> getInviteUserVoList() async {
    try {
      final response = await get(
        AuvNetRoutes.getInviteUserVoList,
        needSign: false,
      );
      return handleListResponse<AuvInviteUserVoResponse>(
        response.data,
        (data) => AuvInviteUserVoResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvInviteUserVoResponse>>(e);
    }
  }

  /// 邀请者获取邀请信息
  ///
  /// 获取当前用户的邀请信息，包括邀请码、总收入、奖励等
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 返回邀请信息:
  ///   - inviteCode: 邀请码
  ///   - awardIncome: 总收入
  ///   - inviteAward: 注册邀请奖励
  ///   - rechargeAward: 充值邀请奖励
  ///   - shareUrl: 分享链接
  ///   - inviteDailyCount: 每日邀请最大人数
  ///   - inviteCount: 当天已邀请人数
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getInviteInfo();
  /// if (result.success && result.data != null) {
  ///   print('邀请码: ${result.data!.inviteCode}');
  ///   print('总收入: ${result.data!.awardIncome}');
  ///   print('分享链接: ${result.data!.shareUrl}');
  ///   print('剩余可邀请: ${result.data!.remainingInviteCount}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvInviteInfo>> getInviteInfo() async {
    try {
      final response = await get(
        AuvNetRoutes.getInviteInfo,
        needSign: false,
      );
      return handleResponse<AuvInviteInfo>(
        response.data,
        (data) => AuvInviteInfo.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvInviteInfo>(e);
    }
  }

  /// 绑定邀请码
  ///
  /// 用户绑定邀请码，用于邀请奖励
  ///
  /// 【请求参数】
  /// [inviteCode] 邀请码（必填）
  ///
  /// 【返回值】
  /// 成功返回null，失败返回错误信息
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.bindInviteCode('0e412b7d');
  /// if (result.success) {
  ///   print('邀请码绑定成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> bindInviteCode(String inviteCode) async {
    try {
      final response = await post(
        '${AuvNetRoutes.bindInviteCode}/$inviteCode',
        needSign: false,
      );
      return handleResponse<void>(
        response.data,
        (_) {},
      );
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 获取邀请绑定记录
  ///
  /// 获取当前用户的邀请绑定记录信息
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 返回邀请绑定记录:
  ///   - createdAt: 注册时间戳
  ///   - hasBindInviteCode: 是否绑定邀请码
  ///   - canBindInviteCode: 是否可以绑定邀请码
  ///   - inviteCode: 邀请码
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getInviteRecord();
  /// if (result.success && result.data != null) {
  ///   print('是否已绑定: ${result.data!.hasBindInviteCode}');
  ///   print('是否可以绑定: ${result.data!.canBindInviteCode}');
  ///   print('邀请码: ${result.data!.inviteCode}');
  ///   print('注册时间: ${result.data!.registrationTime}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvInviteRecord>> getInviteRecord() async {
    try {
      final response = await post(
        AuvNetRoutes.getInviteRecord,
        needSign: false,
      );
      return handleResponse<AuvInviteRecord>(
        response.data,
        (data) => AuvInviteRecord.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvInviteRecord>(e);
    }
  }

  /// 举报/反馈
  ///
  /// 提交用户举报或反馈
  ///
  /// 【请求参数】
  /// [request] 举报/反馈请求对象（必填）
  ///   - type: 举报类型，1.反馈，2.举报，3.官方回复
  ///   - topicType: 举报主题（必填）
  ///     * 1.广告骚扰，2.对话懒散，3.主播不露脸，4.攻击谩骂
  ///     * 5.虚假信息，6.诈骗，7.政治，8.淫秽色情，9.其他，10.虐待儿童
  ///   - content: 内容（必填）
  ///   - anchorUserId: 主播的用户ID（可选）
  ///   - linkId: 关联id，如举报通话则传入频道id（可选）
  ///   - path: 图片地址，多个图片用逗号分开（可选）
  ///
  /// 【返回值】
  /// 无
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.feedbackSave(
  ///   request: AuvFeedbackRequest(
  ///     type: AuvFeedbackType.report,
  ///     topicType: AuvFeedbackTopicType.abuse,
  ///     content: '该用户多次进行人身攻击',
  ///     anchorUserId: 12345,
  ///     linkId: 67890,
  ///     path: 'https://example.com/img1.jpg',
  ///   ),
  /// );
  /// ```
  Future<AuvBaseResponse<void>> feedbackSave({
    required AuvFeedbackRequest request,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.feedbackSave,
        data: request.toJson(),
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 获取用户信息
  /// 
  /// 获取当前登录用户的基本信息
  /// 
  /// 返回值: 用户信息响应
  Future<AuvBaseResponse<AuvUserInfoResponse>> getUserInfo() async {
    try {
      final response = await get(AuvNetRoutes.userInfo);
      return handleResponse<AuvUserInfoResponse>(
        response.data,
        (data) => AuvUserInfoResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserInfoResponse>(e);
    }
  }

  /// 更新用户信息
  /// 
  /// 更新当前用户的基本信息
  /// 
  /// [data] 要更新的用户信息，键值对形式
  /// 
  /// 返回值: 更新后的用户信息
  Future<AuvBaseResponse<AuvUserInfoResponse>> updateUserInfo(Map<String, dynamic> data) async {
    try {
      final response = await post(AuvNetRoutes.updateUserInfo, data: data, needSign: false);
      return handleResponse<AuvUserInfoResponse>(
        response.data,
        (data) => AuvUserInfoResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserInfoResponse>(e);
    }
  }

  /// 签到领奖励
  /// 
  /// 用户每日签到领取奖励
  /// 
  /// 【请求参数】
  /// [signDay] 签到天数（必填），表示连续签到的天数，作为路径参数
  /// [dateStr] 签到日期字符串（可选），格式如 "2024-01-01"，用于测试
  /// 
  /// 【请求头】
  /// - s-time: 请求时间戳（自动添加）
  /// - s-sign: 请求签名（自动添加，needSign: true）
  /// 
  /// 【返回值】
  /// 返回签到奖励响应:
  ///   - id: 奖品id
  ///   - name: 奖品名称
  ///   - icon: 奖品图标
  ///   - countryCode: 国家编码
  ///   - rewardType: 签到奖品类型（1.钻石，2.视频卡，3.匹配卡，4.聊天卡）
  ///   - rewardValue: 奖品数量
  ///   - signDay: 签到天数
  /// 
  /// 【注意】此接口需要签名验证
  /// 
  /// 示例:
  /// ```dart
  /// final result = await userService.signIn(signDay: 1);
  /// if (result.success && result.data != null) {
  ///   print('获得: ${result.data!.name} x${result.data!.rewardValue}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvSignRewardResponse>> signIn({
    required int signDay,
    String? dateStr,
  }) async {
    try {
      final url = dateStr != null
          ? '${AuvNetRoutes.signIn}/$signDay?dateStr=$dateStr'
          : '${AuvNetRoutes.signIn}/$signDay';

      final response = await post(
        url,
        needSign: true,
      );
      return handleResponse<AuvSignRewardResponse>(
        response.data,
        (data) => AuvSignRewardResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvSignRewardResponse>(e);
    }
  }

  /// VIP特权每日领取
  ///
  /// VIP用户每日领取特权奖励
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 返回空（data为null）
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.vipSignIn();
  /// if (result.success) {
  ///   print('VIP每日奖励领取成功');
  /// }
  /// ```
  Future<AuvBaseResponse<void>> vipSignIn() async {
    try {
      final response = await post(AuvNetRoutes.vipSignIn);
      return handleResponse<void>(
        response.data,
        (_) {},
      );
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 获取用户编辑资料信息
  /// 
  /// 获取用户编辑资料页面所需的选项数据，如国家列表、性别选项等
  /// 
  /// 返回值: 用户编辑资料信息响应
  Future<AuvBaseResponse<AuvUserUpdateDetailResponse>> getUserUpdateDetail() async {
    try {
      final response = await get(AuvNetRoutes.getUserUpdateDetail);
      return handleResponse<AuvUserUpdateDetailResponse>(
        response.data,
        (data) => AuvUserUpdateDetailResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserUpdateDetailResponse>(e);
    }
  }

  /// 更新用户相册
  /// 
  /// 更新用户的相册图片列表
  /// 
  /// [userId] 用户ID（必填）
  /// [albumUrlList] 相册URL列表（必填），包含图片的媒体信息
  /// 
  /// 返回值: 空响应，表示更新成功
  Future<AuvBaseResponse<void>> updateAlbumUrlList({
    required int userId,
    required List<AuvUserMediaInfoResponse> albumUrlList,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.updateAlbumUrlList,
        data: {
          'userId': userId,
          'albumUrlList': albumUrlList.map((e) => e.toJson()).toList(),
        },
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 修改个人信息
  /// 
  /// 修改当前用户的个人详细信息
  /// 
  /// [request] 用户详情更新请求对象（必填），包含昵称、性别、生日等信息
  /// 
  /// 返回值: 更新结果响应
  Future<AuvBaseResponse<Map<String, dynamic>>> updateUserDetail({
    required AuvUpdateUserDetailRequest request,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.updateUserDetail,
        data: request.toJson(),
        needSign: false,
      );
      return handleResponse<Map<String, dynamic>>(
        response.data,
        (data) => data,
      );
    } catch (e) {
      return handleError<Map<String, dynamic>>(e);
    }
  }

  /// 查看对方主页埋点
  /// 
  /// 记录用户查看他人主页的行为，用于数据分析
  /// 
  /// [userId] 被查看用户的ID（必填）
  /// 
  /// 返回值: 空响应
  Future<AuvBaseResponse<void>> saveSeeHome({
    required int userId,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.saveSeeHome,
        queryParameters: {'userId': userId},
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 获取访客列表
  /// 
  /// 获取访问过当前用户主页的访客列表
  /// 
  /// [size] 返回数量限制（可选），不传则返回全部
  /// 
  /// 返回值: 访客列表
  Future<AuvBaseResponse<List<AuvUserSeeVo>>> getUserSeeVo({
    int? size,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getUserSeeVo,
        queryParameters: {
          if (size != null) 'size': size,
        },
      );
      return handleListResponse<AuvUserSeeVo>(
        response.data,
        (data) => AuvUserSeeVo.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvUserSeeVo>>(e);
    }
  }

  /// 随机获取头像列表
  ///
  /// 随机获取指定数量的用户头像列表
  ///
  /// [size] 头像个数（必填）
  ///
  /// 返回值: 头像列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getPortraits(size: 10);
  /// if (result.success && result.data != null) {
  ///   for (final portrait in result.data!) {
  ///     print('用户 ${portrait.userId}: ${portrait.portrait}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvPortraitItemResponse>>> getPortraits({
    required int size,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getPortraits,
        queryParameters: {'size': size},
      );
      return handleListResponse<AuvPortraitItemResponse>(
        response.data,
        (data) => AuvPortraitItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvPortraitItemResponse>>(e);
    }
  }

  /// 获取对方的简要信息
  ///
  /// 获取指定用户的简要信息，包含昵称、头像、在线状态、是否好友等
  ///
  /// [userId] 用户ID（必填）
  ///
  /// 返回值: 用户简要信息响应
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getUserSimple(userId: 10000389);
  /// if (result.success && result.data != null) {
  ///   print('Nickname: ${result.data!.nickname}');
  ///   print('Is online: ${result.data!.isUserOnline}');
  ///   print('Is friend: ${result.data!.isFriend}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvUserSimpleResponse>> getUserSimple({
    required int userId,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getUserSimple,
        queryParameters: {'userId': userId},
      );
      return handleResponse<AuvUserSimpleResponse>(
        response.data,
        (data) => AuvUserSimpleResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvUserSimpleResponse>(e);
    }
  }

  /// 获取用户是否在线
  ///
  /// 批量查询指定用户的在线状态
  ///
  /// [userIds] 用户ID列表（必填），支持批量查询
  ///
  /// 返回值: 用户在线状态列表，包含每个用户的在线状态描述
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getIsOnlines(userIds: [10000389, 10000390]);
  /// if (result.success && result.data != null) {
  ///   for (final status in result.data!) {
  ///     print('User ${status.userId}: ${status.onlineStatusDesc}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvUserOnlineStatusResponse>>> getIsOnlines({
    required List<int> userIds,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getIsOnlines,
        data: {'userIds': userIds},
        needSign: false,
      );
      return handleListResponse<AuvUserOnlineStatusResponse>(
        response.data,
        (data) => AuvUserOnlineStatusResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvUserOnlineStatusResponse>>(e);
    }
  }

  /// 获取等级区间详情
  ///
  /// 获取用户等级配置信息，包含各等级的经验值要求和称号
  ///
  /// 返回值: 等级区间配置数据响应
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getLevelInfoConfigs();
  /// if (result.success && result.data != null) {
  ///   print('当前总经验值: ${result.data!.total}');
  ///   for (final config in result.data!.configs ?? []) {
  ///     print('等级${config.level}: ${config.title}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvLevelInfoDataResponse>> getLevelInfoConfigs() async {
    try {
      final response = await get(AuvNetRoutes.getLevelInfoConfigs);
      return handleObjectResponse<AuvLevelInfoDataResponse>(
        response.data,
        (data) => AuvLevelInfoDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvLevelInfoDataResponse>(e);
    }
  }

  /// 获取高级用户弹窗接口
  ///
  /// 获取成为大客户时的弹窗内容，包含奖励信息等
  ///
  /// 返回值: 高级用户弹窗数据响应
  ///
  /// 注意: WebSocket 消息 messageType=57 代表成为大客户，
  /// 此时需要拉取此接口请求弹窗显示的内容
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getDialogDetail();
  /// if (result.success && result.data != null) {
  ///   if (result.data!.shouldShowDialog) {
  ///     // 显示弹窗
  ///     print('钻石奖励: ${result.data!.rewardVo?.diamondNum}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvAdvanceDialogDataResponse>> getDialogDetail() async {
    try {
      final response = await get(AuvNetRoutes.getDialogDetail);
      return handleObjectResponse<AuvAdvanceDialogDataResponse>(
        response.data,
        (data) => AuvAdvanceDialogDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvAdvanceDialogDataResponse>(e);
    }
  }

  /// 关注对方
  ///
  /// 关注指定用户，建立关注关系
  ///
  /// 【路径参数】
  /// [followUserId] 被关注的用户ID（必填）
  ///
  /// 【Body参数】
  /// [inLiveRoom] 是否直播间内关注（可选）
  ///   - 0.否
  ///   - 1.是
  ///
  /// 【返回值】
  /// 返回关注后的关系状态:
  ///   - 0: 双方都未关注
  ///   - 1: 我未关注&对方已回关
  ///   - 2: 我已关注&对方未回关
  ///   - 3: 好友
  ///
  /// 示例:
  /// ```dart
  /// // 普通关注
  /// final result = await userService.saveUserFollow(followUserId: 123456);
  /// if (result.success && result.data != null) {
  ///   print('关系状态: ${result.data!.followStatusDesc}');
  ///   if (result.data!.isFriend) {
  ///     print('已成为好友');
  ///   }
  /// }
  ///
  /// // 直播间内关注
  /// final result = await userService.saveUserFollow(
  ///   followUserId: 123456,
  ///   inLiveRoom: 1,
  /// );
  /// ```
  Future<AuvBaseResponse<AuvFollowResponse>> saveUserFollow({
    required int followUserId,
    int? inLiveRoom,
  }) async {
    try {
      final response = await post(
        '${AuvNetRoutes.saveUserFollow}/$followUserId',
        data: AuvFollowRequest(
          inLiveRoom: inLiveRoom,
        ).toJson(),
        needSign: false,
      );
      return handleObjectResponse<AuvFollowResponse>(
        response.data,
        (data) => AuvFollowResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvFollowResponse>(e);
    }
  }

  /// 取消关注
  ///
  /// 取消对指定用户的关注
  ///
  /// 【路径参数】
  /// [followUserId] 被取消关注的用户ID（必填）
  ///
  /// 【返回值】
  ///   - true: 取消成功
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.removeUserFollow(followUserId: 123456);
  /// if (result.success && result.data == true) {
  ///   print('取消关注成功');
  /// }
  /// ```
  Future<AuvBaseResponse<bool>> removeUserFollow({
    required int followUserId,
  }) async {
    try {
      final response = await post(
        '${AuvNetRoutes.removeUserFollow}/$followUserId',
        needSign: false,
      );
      return handleSingleValueResponse<bool>(
        response.data,
        (data) => data == true,
      );
    } catch (e) {
      return handleError<bool>(e);
    }
  }

  /// 获取好友/好友请求/我的关注列表
  ///
  /// 分页获取用户的好友、好友请求或关注列表
  ///
  /// 【请求参数】
  /// [type] 列表类型（必填）
  ///   - 1: 好友列表
  ///   - 2: 好友请求列表
  ///   - 3: 我的关注列表
  /// [pageNum] 页码（必填）
  /// [pageSize] 每页条数（必填）
  ///
  /// 【返回值】
  /// 返回分页用户列表，包含用户详细信息（昵称、头像、在线状态、等级等）
  ///
  /// 示例:
  /// ```dart
  /// // 获取好友列表
  /// final friends = await userService.getFollowList(
  ///   type: AuvFollowListType.friend,
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  /// if (friends.success && friends.data != null) {
  ///   for (final user in friends.data!.list ?? []) {
  ///     print('${user.nickname}: ${user.onlineStatusDesc}');
  ///   }
  /// }
  ///
  /// // 获取好友请求列表
  /// final requests = await userService.getFollowList(
  ///   type: 2,
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  ///
  /// // 获取我的关注列表
  /// final following = await userService.getFollowList(
  ///   type: AuvFollowListType.following,
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  /// ```
  Future<AuvBaseResponse<AuvFollowListDataResponse>> getFollowList({
    required int type,
    required int pageNum,
    required int pageSize,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getFollowList,
        data: {
          'condition': AuvFollowListRequest(type: type).toJson(),
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
        needSign: false,
      );
      return handleObjectResponse<AuvFollowListDataResponse>(
        response.data,
        (data) => AuvFollowListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvFollowListDataResponse>(e);
    }
  }

  /// 获取好友/好友请求/我的关注列表V2版本
  ///
  /// 分页获取用户的好友、好友请求或关注列表V2版本
  /// V2版本增加了inLiveRoom、roomId、followUserId字段
  ///
  /// 【请求参数】
  /// [type] 列表类型（必填）
  ///   - 1: 好友列表
  ///   - 2: 好友请求列表
  ///   - 3: 我的关注列表（关注&&粉丝 => 自己没关注对方）
  /// [pageNum] 页码（必填）
  /// [pageSize] 每页条数（必填）
  ///
  /// 【返回值】
  /// 返回分页用户列表V2，包含用户详细信息及直播状态
  ///
  /// 示例:
  /// ```dart
  /// // 获取好友列表V2
  /// final friends = await userService.getFollowListV2(
  ///   type: AuvFollowListType.friend.value,
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  /// if (friends.success && friends.data != null) {
  ///   for (final user in friends.data!.list ?? []) {
  ///     print('${user.nickname}: ${user.onlineStatusDesc}');
  ///     if (user.isInLiveRoom) {
  ///       print('正在直播: ${user.roomId}');
  ///     }
  ///   }
  /// }
  ///
  /// // 获取好友请求列表V2
  /// final requests = await userService.getFollowListV2(
  ///   type: 2,
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  ///
  /// // 获取我的关注列表V2
  /// final following = await userService.getFollowListV2(
  ///   type: AuvFollowListType.following.value,
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  /// ```
  Future<AuvBaseResponse<AuvFollowListV2DataResponse>> getFollowListV2({
    required int type,
    required int pageNum,
    required int pageSize,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getFollowListV2,
        data: {
          'condition': AuvFollowListV2Request(type: type).toJson(),
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
        needSign: false,
      );
      return handleObjectResponse<AuvFollowListV2DataResponse>(
        response.data,
        (data) => AuvFollowListV2DataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvFollowListV2DataResponse>(e);
    }
  }

  /// 获取我的喜欢列表
  ///
  /// 获取我喜欢的人或喜欢我的人的列表
  ///
  /// 【请求参数】
  /// [type] 列表类型: 1 我喜欢的, 2 喜欢我的
  /// [pageNum] 页码
  /// [pageSize] 每页条数
  ///
  /// 【返回值】
  /// 返回喜欢列表分页数据
  ///
  /// 示例:
  /// ```dart
  /// // 获取喜欢我的人列表
  /// final likedMe = await userService.getLikeList(
  ///   type: AuvLikeListType.likedMe.value,
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  /// if (likedMe.success && likedMe.data != null) {
  ///   for (final user in likedMe.data!.list ?? []) {
  ///     print('${user.nickname}: ${user.statDesc}');
  ///   }
  /// }
  ///
  /// // 获取我喜欢的人列表
  /// final myLikes = await userService.getLikeList(
  ///   type: AuvLikeListType.like.value,
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  /// ```
  Future<AuvBaseResponse<AuvLikeListDataResponse>> getLikeList({
    required int type,
    required int pageNum,
    required int pageSize,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getLikeList,
        data: {
          'condition': AuvLikeListRequest(type: type).toJson(),
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
        needSign: false,
      );
      return handleObjectResponse<AuvLikeListDataResponse>(
        response.data,
        (data) => AuvLikeListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvLikeListDataResponse>(e);
    }
  }

  /// 更新喜欢状态
  ///
  /// 批量更新喜欢我的人的状态（忽略或回喜欢）
  ///
  /// 【请求参数】
  /// [likeMeUserIds] 喜欢我的人用户ID列表
  /// [stat] 状态: 1忽略, 2回喜欢
  ///
  /// 【返回值】
  /// 返回更新结果
  ///
  /// 示例:
  /// ```dart
  /// // 忽略喜欢我的人
  /// final result = await userService.updateLikeStat(
  ///   likeMeUserIds: [10053278, 10052120],
  ///   stat: AuvUpdateLikeStatType.ignore.value,
  /// );
  ///
  /// // 回喜欢喜欢我的人
  /// final result = await userService.updateLikeStat(
  ///   likeMeUserIds: [10053278],
  ///   stat: AuvUpdateLikeStatType.likeBack.value,
  /// );
  /// ```
  Future<AuvBaseResponse<int>> updateLikeStat({
    required List<int> likeMeUserIds,
    required int stat,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.updateLikeStat,
        data: AuvUpdateLikeStatRequest(
          likeMeUserIds: likeMeUserIds,
          stat: stat,
        ).toJson(),
        needSign: false,
      );
      return handleSingleValueResponse<int>(
        response.data,
        (data) => data as int? ?? 0,
      );
    } catch (e) {
      return handleError<int>(e);
    }
  }

  /// 拉黑用户
  ///
  /// 将指定用户加入黑名单
  ///
  /// 【路径参数】
  /// [blackUserId] 被拉黑的用户ID（必填）
  ///
  /// 【返回值】
  ///   - true: 拉黑成功
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.saveBlack(blackUserId: 123456);
  /// if (result.success && result.data == true) {
  ///   print('拉黑成功');
  /// }
  /// ```
  Future<AuvBaseResponse<bool>> saveBlack({
    required int blackUserId,
  }) async {
    try {
      final response = await post(
        '${AuvNetRoutes.saveBlack}/$blackUserId',
        needSign: false,
      );
      return handleSingleValueResponse<bool>(
        response.data,
        (data) => data == true,
      );
    } catch (e) {
      return handleError<bool>(e);
    }
  }

  /// 取消拉黑
  ///
  /// 将指定用户从黑名单中移除
  ///
  /// 【路径参数】
  /// [blackUserId] 被取消拉黑的用户ID（必填）
  ///
  /// 【返回值】
  ///   - true: 取消拉黑成功
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.removeBlack(blackUserId: 123456);
  /// if (result.success && result.data == true) {
  ///   print('取消拉黑成功');
  /// }
  /// ```
  Future<AuvBaseResponse<bool>> removeBlack({
    required int blackUserId,
  }) async {
    try {
      final response = await post(
        '${AuvNetRoutes.removeBlack}/$blackUserId',
        needSign: false,
      );
      return handleSingleValueResponse<bool>(
        response.data,
        (data) => data == true,
      );
    } catch (e) {
      return handleError<bool>(e);
    }
  }

  /// 获取拉黑列表
  ///
  /// 分页获取当前用户的黑名单列表
  ///
  /// 【请求参数】
  /// [pageNum] 页码（必填）
  /// [pageSize] 每页条数（必填）
  ///
  /// 【返回值】
  /// 返回分页黑名单用户列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getBlackList(
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final user in result.data!.list ?? []) {
  ///     print('${user.nickname}: 拉黑时间 ${user.blacklistedAt}');
  ///   }
  ///   print('总共 ${result.data!.total} 人');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvBlackListDataResponse>> getBlackList({
    required int pageNum,
    required int pageSize,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getBlackList,
        data: {
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
        needSign: false,
      );
      return handleObjectResponse<AuvBlackListDataResponse>(
        response.data,
        (data) => AuvBlackListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvBlackListDataResponse>(e);
    }
  }

  /// 获取好友请求数值
  ///
  /// 获取当前用户未处理的好友请求数量
  ///
  /// 【请求参数】
  /// 无
  ///
  /// 【返回值】
  /// 好友请求数量
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getFollowCount();
  /// if (result.success) {
  ///   print('待处理好友请求: ${result.data}');
  /// }
  /// ```
  Future<AuvBaseResponse<int>> getFollowCount() async {
    try {
      final response = await get(
        AuvNetRoutes.getFollowCount,
      );
      return handleSingleValueResponse<int>(
        response.data,
        (data) => data is int ? data : int.tryParse(data.toString()) ?? 0,
      );
    } catch (e) {
      return handleError<int>(e);
    }
  }

  /// 喜欢对方
  ///
  /// 对指定用户表示喜欢
  ///
  /// 【路径参数】
  /// [likeUserId] 被喜欢的用户ID（必填）
  ///
  /// 【返回值】
  ///   - 0: 喜欢成功
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.saveUserLike(likeUserId: 123456);
  /// if (result.success && result.data == 0) {
  ///   print('喜欢成功');
  /// }
  /// ```
  Future<AuvBaseResponse<int>> saveUserLike({
    required int likeUserId,
  }) async {
    try {
      final response = await post(
        '${AuvNetRoutes.saveUserLike}/$likeUserId',
        needSign: false,
      );
      return handleSingleValueResponse<int>(
        response.data,
        (data) => data is int ? data : int.tryParse(data.toString()) ?? 0,
      );
    } catch (e) {
      return handleError<int>(e);
    }
  }

  /// 取消喜欢对方
  ///
  /// 取消对指定用户的喜欢
  ///
  /// 【路径参数】
  /// [likeUserId] 被取消喜欢的用户ID（必填）
  ///
  /// 【返回值】
  ///   - 0: 取消成功
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.removeUserLike(likeUserId: 123456);
  /// if (result.success && result.data == 0) {
  ///   print('取消喜欢成功');
  /// }
  /// ```
  Future<AuvBaseResponse<int>> removeUserLike({
    required int likeUserId,
  }) async {
    try {
      final response = await post(
        '${AuvNetRoutes.removeUserLike}/$likeUserId',
        needSign: false,
      );
      return handleSingleValueResponse<int>(
        response.data,
        (data) => data is int ? data : int.tryParse(data.toString()) ?? 0,
      );
    } catch (e) {
      return handleError<int>(e);
    }
  }

  /// 获取关系请求数值
  ///
  /// 获取指定用户的关系数据，包括关注数、被关注数、喜欢数等
  ///
  /// 【query参数】
  /// [userId] 用户ID（必填）
  ///
  /// 【返回值】
  /// 返回用户的关系数据
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getRelationCount(userId: 123456);
  /// if (result.success && result.data != null) {
  ///   final data = result.data!;
  ///   print('关注数: ${data.followCount}');
  ///   print('被关注数: ${data.followedCount}');
  ///   print('喜欢数: ${data.likeCount}');
  ///   print('喜欢我的数: ${data.likeMeCount}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvRelationCountResponse>> getRelationCount({
    required int userId,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getRelationCount,
        queryParameters: {'userId': userId},
      );
      return handleObjectResponse<AuvRelationCountResponse>(
        response.data,
        (data) => AuvRelationCountResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvRelationCountResponse>(e);
    }
  }

  /// 获取系统表情包
  ///
  /// 获取表情包列表，每个表情包包含解锁等级和表情列表
  ///
  /// 【返回值】
  /// 返回表情包列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getCommonPackages();
  /// if (result.success && result.data != null) {
  ///   for (final package in result.data!) {
  ///     print('表情包: ${package.name}');
  ///     print('解锁等级: ${package.heartbeatLevel}');
  ///     for (final sticker in package.stickers) {
  ///       print('表情: ${sticker.stickerId}');
  ///     }
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvStickerPackageResponse>>> getCommonPackages() async {
    try {
      final response = await get(AuvNetRoutes.getCommonPackages);
      return handleListResponse<AuvStickerPackageResponse>(
        response.data,
        (data) => AuvStickerPackageResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvStickerPackageResponse>>(e);
    }
  }

  /// 获取心动等级区间详情
  ///
  /// 获取与指定用户的心动等级详情，包含当前心动值、等级、勋章等
  ///
  /// 【query参数】
  /// [otherUserId] 对方用户ID（必填）
  ///
  /// 【返回值】
  /// 返回心动等级详情
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getHeartbeatLevelInfo(otherUserId: 10074438);
  /// if (result.success && result.data != null) {
  ///   print('当前心动值: ${result.data!.total / 100}'); // 需除以100显示
  ///   print('心动等级: ${result.data!.level}');
  ///   print('对方昵称: ${result.data!.otherUserNickname}');
  ///   print('礼物比例: ${result.data!.heartbeatGiftRate}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvHeartbeatLevelInfoDataResponse>> getHeartbeatLevelInfo({
    required int otherUserId,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getHeartbeatLevelInfo,
        queryParameters: {'otherUserId': otherUserId},
      );
      return handleObjectResponse<AuvHeartbeatLevelInfoDataResponse>(
        response.data,
        (data) => AuvHeartbeatLevelInfoDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvHeartbeatLevelInfoDataResponse>(e);
    }
  }

  /// 主播获取心动用户列表
  ///
  /// 分页获取对自己有心动值的用户列表
  ///
  /// 【请求参数】
  /// [pageNum] 页码（必填）
  /// [pageSize] 每页条数（必填）
  ///
  /// 【返回值】
  /// 返回分页心动用户列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getHeartbeatUsers(
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final user in result.data!.list) {
  ///     print('${user.nickname}: 心动值 ${user.score}, 等级 ${user.level}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvHeartbeatUsersDataResponse>> getHeartbeatUsers({
    required int pageNum,
    required int pageSize,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getHeartbeatUsers,
        data: {
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
        needSign: false,
      );
      return handleObjectResponse<AuvHeartbeatUsersDataResponse>(
        response.data,
        (data) => AuvHeartbeatUsersDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvHeartbeatUsersDataResponse>(e);
    }
  }

  /// 批量查询主播心动信息
  ///
  /// 批量查询多个主播的心动值、在线状态、直播状态
  ///
  /// 【请求参数】
  /// [anchorIds] 主播ID列表（必填）
  ///
  /// 【返回值】
  /// 返回主播心动信息列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getHeartbeatAnchorsV2(
  ///   anchorIds: [10074438, 10074439],
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final anchor in result.data!) {
  ///     print('主播${anchor.anchorId}: 心动值${anchor.score}, 在线${anchor.isOnline}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvHeartbeatAnchorItemResponse>>> getHeartbeatAnchorsV2({
    required List<int> anchorIds,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getHeartbeatAnchorsV2,
        data: {'otherUserIdList': anchorIds},
        needSign: false,
      );
      return handleListResponse<AuvHeartbeatAnchorItemResponse>(
        response.data,
        (data) => AuvHeartbeatAnchorItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvHeartbeatAnchorItemResponse>>(e);
    }
  }

  /// 获取心动等级规则列表
  ///
  /// 获取心动等级的规则说明列表
  ///
  /// 【返回值】
  /// 返回心动等级规则列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getHeartbeatRuleList();
  /// if (result.success && result.data != null) {
  ///   print('语言: ${result.data!.language}');
  ///   for (final rule in result.data!.rules) {
  ///     print('规则: $rule');
  ///   }
  ///   print('总规则: ${result.data!.masterRule}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvHeartbeatRuleListResponse>> getHeartbeatRuleList() async {
    try {
      final response = await get(AuvNetRoutes.getHeartbeatRuleList);
      return handleObjectResponse<AuvHeartbeatRuleListResponse>(
        response.data,
        (data) => AuvHeartbeatRuleListResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvHeartbeatRuleListResponse>(e);
    }
  }

  /// 批量获取主播心动值
  ///
  /// 批量查询多个主播的心动值和心动等级
  ///
  /// 【请求参数】
  /// [anchorIds] 主播ID列表（必填）
  ///
  /// 【返回值】
  /// 返回主播心动值列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.batchGetHeartbeatValues(
  ///   anchorIds: [10074438, 10074439],
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final item in result.data!) {
  ///     print('主播${item.anchorId}: 心动值${item.score}, 等级${item.level}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvHeartbeatValueItemResponse>>> batchGetHeartbeatValues({
    required List<int> anchorIds,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.batchGetHeartbeatValues,
        data: {'otherUserIdList': anchorIds},
        needSign: false,
      );
      return handleListResponse<AuvHeartbeatValueItemResponse>(
        response.data,
        (data) => AuvHeartbeatValueItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvHeartbeatValueItemResponse>>(e);
    }
  }

  /// 用户获取心动主播列表
  ///
  /// 获取用户关注的主播中，有心动值的主播列表
  ///
  /// 【请求参数】
  /// [pageNum] 页码（必填）
  /// [pageSize] 每页条数（必填）
  ///
  /// 【返回值】
  /// 返回分页心动主播列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getHeartbeatList(
  ///   pageNum: 1,
  ///   pageSize: 20,
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final anchor in result.data!.list) {
  ///     print('${anchor.nickname}: 心动值${anchor.score}, 等级${anchor.level}');
  ///     print('在线: ${anchor.isOnline == 1}, 直播中: ${anchor.inLiveRoom == 1}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvHeartbeatListDataResponse>> getHeartbeatList({
    required int pageNum,
    required int pageSize,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getHeartbeatList,
        data: {
          'pageNum': pageNum,
          'pageSize': pageSize,
        },
        needSign: false,
      );
      return handleObjectResponse<AuvHeartbeatListDataResponse>(
        response.data,
        (data) => AuvHeartbeatListDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvHeartbeatListDataResponse>(e);
    }
  }

  /// 获取心动等级配置
  ///
  /// 获取心动等级的配置信息，包含礼物比例和等级配置列表
  ///
  /// 【返回值】
  /// 返回心动等级配置
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getHeartbeatConfig();
  /// if (result.success && result.data != null) {
  ///   print('礼物比例: ${result.data!.heartbeatGiftRate}');
  ///   for (final config in result.data!.configs) {
  ///     print('等级${config.level}: ${config.begin}-${config.end}');
  ///     print('勋章: ${config.modalFrame}');
  ///     print('图标: ${config.icon}');
  ///     if (config.stickerPackage != null) {
  ///       print('表情包: ${config.stickerPackage!.name}');
  ///     }
  ///     if (config.giftInfo != null) {
  ///       print('礼物: ${config.giftInfo!.name}');
  ///     }
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvHeartbeatConfigResponse>> getHeartbeatConfig() async {
    try {
      final response = await get(AuvNetRoutes.getHeartbeatConfig);
      return handleObjectResponse<AuvHeartbeatConfigResponse>(
        response.data,
        (data) => AuvHeartbeatConfigResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvHeartbeatConfigResponse>(e);
    }
  }

  /// 用户获取常驻心动主播
  ///
  /// 获取用户关注的常驻心动主播列表
  ///
  /// 【返回值】
  /// 返回常驻心动主播列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getFixHeartbeatAnchors();
  /// if (result.success && result.data != null) {
  ///   for (final anchor in result.data!) {
  ///     print('${anchor.nickname}: 心动值${anchor.score}');
  ///     print('在线: ${anchor.isOnline == 1}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvFixHeartbeatAnchorItemResponse>>> getFixHeartbeatAnchors() async {
    try {
      final response = await get(AuvNetRoutes.getFixHeartbeatAnchors);
      return handleListResponse<AuvFixHeartbeatAnchorItemResponse>(
        response.data,
        (data) => AuvFixHeartbeatAnchorItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvFixHeartbeatAnchorItemResponse>>(e);
    }
  }

  /// 主播获取常驻心动用户
  ///
  /// 主播视角获取对自己有心动值的常驻用户列表
  ///
  /// 【返回值】
  /// 返回常驻心动用户列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await userService.getFixHeartbeatUsers();
  /// if (result.success && result.data != null) {
  ///   for (final user in result.data!) {
  ///     print('${user.nickname}: 心动值${user.score}');
  ///     print('在线: ${user.isOnline == 1}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvFixHeartbeatAnchorItemResponse>>> getFixHeartbeatUsers() async {
    try {
      final response = await get(AuvNetRoutes.getFixHeartbeatUsers);
      return handleListResponse<AuvFixHeartbeatAnchorItemResponse>(
        response.data,
        (data) => AuvFixHeartbeatAnchorItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvFixHeartbeatAnchorItemResponse>>(e);
    }
  }
}
