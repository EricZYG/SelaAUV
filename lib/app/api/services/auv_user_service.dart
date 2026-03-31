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
  /// 
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
  /// [signDay] 签到天数（必填），表示连续签到的天数
  /// [dateStr] 签到日期字符串（可选），格式如 "2024-01-01"
  /// 
  /// 返回值: 签到奖励响应，包含奖励信息
  /// 
  /// 注意: 此接口需要签名验证
  Future<AuvBaseResponse<AuvSignRewardResponse>> signIn({
    required int signDay,
    String? dateStr,
  }) async {
    try {
      final data = {
        'signDay': signDay,
        if (dateStr != null) 'dateStr': dateStr,
      };

      final response = await post(
        AuvNetRoutes.signIn,
        data: data,
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
