import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_showdoc_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/models/auv_msg_model.dart';

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
  Future<AuvShowDocResponse<AuvUserDetailResponse>> getUserDetail() async {
    try {
      final response = await get(AuvShowDocRoutes.getUserDetail);
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
  Future<AuvShowDocResponse<AuvUserInfoResponse>> getUserInfo() async {
    try {
      final response = await get(AuvShowDocRoutes.userInfo);
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
  Future<AuvShowDocResponse<AuvUserInfoResponse>> updateUserInfo(Map<String, dynamic> data) async {
    try {
      final response = await post(AuvShowDocRoutes.updateUserInfo, data: data, needSign: false);
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
  Future<AuvShowDocResponse<AuvSignRewardResponse>> signIn({
    required int signDay,
    String? dateStr,
  }) async {
    try {
      final data = {
        'signDay': signDay,
        if (dateStr != null) 'dateStr': dateStr,
      };

      final response = await post(
        AuvShowDocRoutes.signIn,
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
  Future<AuvShowDocResponse<AuvUserUpdateDetailResponse>> getUserUpdateDetail() async {
    try {
      final response = await get(AuvShowDocRoutes.getUserUpdateDetail);
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
  Future<AuvShowDocResponse<void>> updateAlbumUrlList({
    required int userId,
    required List<AuvUserMediaInfoResponse> albumUrlList,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.updateAlbumUrlList,
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
  Future<AuvShowDocResponse<Map<String, dynamic>>> updateUserDetail({
    required AuvUpdateUserDetailRequest request,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.updateUserDetail,
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
  Future<AuvShowDocResponse<void>> saveSeeHome({
    required int userId,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.saveSeeHome,
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
  Future<AuvShowDocResponse<List<AuvUserSeeVo>>> getUserSeeVo({
    int? size,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getUserSeeVo,
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
  Future<AuvShowDocResponse<AuvUserSimpleResponse>> getUserSimple({
    required int userId,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getUserSimple,
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
  Future<AuvShowDocResponse<List<AuvUserOnlineStatusResponse>>> getIsOnlines({
    required List<int> userIds,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.getIsOnlines,
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
  Future<AuvShowDocResponse<AuvLevelInfoDataResponse>> getLevelInfoConfigs() async {
    try {
      final response = await get(AuvShowDocRoutes.getLevelInfoConfigs);
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
  Future<AuvShowDocResponse<AuvAdvanceDialogDataResponse>> getDialogDetail() async {
    try {
      final response = await get(AuvShowDocRoutes.getDialogDetail);
      return handleObjectResponse<AuvAdvanceDialogDataResponse>(
        response.data,
        (data) => AuvAdvanceDialogDataResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvAdvanceDialogDataResponse>(e);
    }
  }
}
