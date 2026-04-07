import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_net_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';

/// 系统服务
/// 
/// 处理系统相关接口：应用配置等
class AuvSystemService extends AuvBaseService {
  /// 创建服务实例
  static AuvSystemService create() {
    final service = AuvSystemService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 获取应用配置 - 完整版（用户端）
  /// 
  /// GET /system/app/getConfig
  /// 
  /// 可登录可不登录，登录返回数据可能有变化
  /// 
  /// 返回完整的应用配置数据，包含礼包、道具价格、隐私聊天价格等全部字段
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.getAppConfig();
  /// if (result.success && result.data?.ok != null) {
  ///   // 声网appId
  ///   print('agoraAppId: ${result.data!.agoraAppId}');
  ///   // 新手礼包
  ///   final reward = result.data!.registerReward;
  ///   print('videoCard: ${reward?.callCardNum}');
  ///   print('diamonds: ${reward?.diamonds}');
  ///   // 设置签名密钥
  ///   setSignKey(result.data!.ok!);
  /// }
  /// ```
  Future<AuvBaseResponse<AuvAppConfigUserResponse>> getAppConfig() async {
    try {
      final response = await get(AuvNetRoutes.appConfig);
      return handleResponse<AuvAppConfigUserResponse>(
        response.data,
        (data) => AuvAppConfigUserResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvAppConfigUserResponse>(e);
    }
  }

  /// 获取翻译文案V2
  /// 
  /// GET /system/app/getTranslatesV2
  /// 
  /// 可登录可不登录，返回翻译文案版本号和JSON文件URL
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.getTranslatesV2();
  /// if (result.success && result.data != null) {
  ///   print('version: ${result.data!.version}');
  ///   print('url: ${result.data!.url}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvTranslatesV2Response>> getTranslatesV2() async {
    try {
      final response = await get(AuvNetRoutes.getTranslatesV2);
      return handleResponse<AuvTranslatesV2Response>(
        response.data,
        (data) => AuvTranslatesV2Response.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvTranslatesV2Response>(e);
    }
  }

  /// 获取S3上传链接V2
  ///
  /// 获取S3预签名上传URL，用于文件上传
  ///
  /// 【请求参数】
  /// [suffix] 文件后缀（必填），如 png、jpg、mp4 等
  ///
  /// 【返回值】
  /// 返回上传链接信息:
  ///   - uploadUrl: 上传用的链接
  ///   - publicUrl: 访问用的链接
  ///   - filePath: 文件相对路径
  ///
  /// 示例:
  /// ```dart
  /// final result = await systemService.getS3UploadUrlV2(suffix: 'jpg');
  /// if (result.success && result.data != null) {
  ///   print('上传链接: ${result.data!.uploadUrl}');
  ///   print('访问链接: ${result.data!.publicUrl}');
  ///   print('文件路径: ${result.data!.filePath}');
  /// }
  /// ```
  Future<AuvBaseResponse<AuvS3UploadUrlResponse>> getS3UploadUrlV2({
    required String suffix,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getS3UploadUrlV2,
        queryParameters: {'suffix': suffix},
      );
      return handleResponse<AuvS3UploadUrlResponse>(
        response.data,
        (data) => AuvS3UploadUrlResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvS3UploadUrlResponse>(e);
    }
  }

  /// 获取地区列表
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.getAreas();
  /// if (result.success && result.data != null) {
  ///   for (final area in result.data!) {
  ///     print('${area.title}: ${area.anchorCount} anchors');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvAreaResponse>>> getAreas() async {
    try {
      final response = await get(AuvNetRoutes.getAreas);
      return handleListResponse<AuvAreaResponse>(
        response.data,
        (data) => AuvAreaResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvAreaResponse>>(e);
    }
  }

  /// 获取AI配置
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.getAiConfigs();
  /// if (result.success && result.data != null) {
  ///   for (final config in result.data!) {
  ///     print('${config.configTypeDesc}: aivSwitch=${config.aivSwitch}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvAiConfigResponse>>> getAiConfigs() async {
    try {
      final response = await get(AuvNetRoutes.getAiConfigs);
      return handleListResponse<AuvAiConfigResponse>(
        response.data,
        (data) => AuvAiConfigResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvAiConfigResponse>>(e);
    }
  }

  /// 按国家获取银行渠道列表
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.getPayoutChannels(countryCode: 123);
  /// if (result.success && result.data != null) {
  ///   for (final channel in result.data!) {
  ///     print('${channel.channelName}: ${channel.channelType}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvPayoutChannelResponse>>> getPayoutChannels({
    required int countryCode,
  }) async {
    try {
      final response = await get(
        AuvNetRoutes.getPayoutChannels,
        queryParameters: {'countryCode': countryCode},
      );
      return handleListResponse<AuvPayoutChannelResponse>(
        response.data,
        (data) => AuvPayoutChannelResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvPayoutChannelResponse>>(e);
    }
  }

  /// 获取标签配置
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.getTagConfigs();
  /// if (result.success && result.data != null) {
  ///   for (final category in result.data!) {
  ///     print('${category.title}: ${category.tags?.length} tags');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvTagCategoryResponse>>> getTagConfigs() async {
    try {
      final response = await get(AuvNetRoutes.getTagConfigs);
      return handleListResponse<AuvTagCategoryResponse>(
        response.data,
        (data) => AuvTagCategoryResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvTagCategoryResponse>>(e);
    }
  }

  /// 获取广告列表
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.getAdvertisement();
  /// if (result.success && result.data != null) {
  ///   for (final ad in result.data!.list ?? []) {
  ///     print('${ad.id}: ${ad.jumpUrl}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<AuvAdvertisementListResponse>> getAdvertisement() async {
    try {
      final response = await get(AuvNetRoutes.getAdvertisement);
      return handleObjectResponse<AuvAdvertisementListResponse>(
        response.data,
        (data) => AuvAdvertisementListResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvAdvertisementListResponse>(e);
    }
  }

  /// IP和语言检测
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.checkRegion();
  /// if (result.success) {
  ///   final passed = result.data == 1;
  ///   print('Region check: ${passed ? "passed" : "failed"}');
  /// }
  /// ```
  Future<AuvBaseResponse<int>> checkRegion() async {
    try {
      final response = await get(AuvNetRoutes.checkRegion);
      return handleSingleValueResponse<int>(
        response.data,
        (data) => data is int ? data : int.tryParse(data.toString()) ?? 0,
      );
    } catch (e) {
      return handleError<int>(e);
    }
  }

  /// 获取招呼话术列表
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.getAigConfigs();
  /// if (result.success && result.data != null) {
  ///   for (final phrase in result.data!) {
  ///     print(phrase);
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<String>>> getAigConfigs() async {
    try {
      final response = await get(AuvNetRoutes.getAigConfigs);
      return handleListResponse<String>(
        response.data,
        (data) => data.toString(),
      );
    } catch (e) {
      return handleError<List<String>>(e);
    }
  }

  /// 获取敏感词库V2
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.getSensitiveWordsV2();
  /// if (result.success && result.data != null) {
  ///   for (final word in result.data!) {
  ///     print('${word.words}: ${word.typeDesc}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvSensitiveWordResponse>>> getSensitiveWordsV2() async {
    try {
      final response = await get(AuvNetRoutes.getSensitiveWordsV2);
      return handleListResponse<AuvSensitiveWordResponse>(
        response.data,
        (data) => AuvSensitiveWordResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvSensitiveWordResponse>>(e);
    }
  }

  /// 获取AI Help菜单列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await systemService.getAiHelpConfigList(lang: 'zh');
  /// if (result.success && result.data != null) {
  ///   for (final menu in result.data!) {
  ///     print('${menu.title}: ${menu.contentTypeDesc}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvAiHelpMenuItemResponse>>> getAiHelpConfigList({
    String? lang,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getAiHelpConfigList,
        queryParameters: lang != null ? {'lang': lang} : null,
      );
      return handleListResponse<AuvAiHelpMenuItemResponse>(
        response.data,
        (data) => AuvAiHelpMenuItemResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvAiHelpMenuItemResponse>>(e);
    }
  }

  /// 获取AI Help记录列表
  ///
  /// 示例:
  /// ```dart
  /// final result = await systemService.getAiHelpRecords(
  ///   lang: 'zh',
  ///   userId: 1698902146478649346,
  /// );
  /// if (result.success && result.data != null) {
  ///   for (final record in result.data!) {
  ///     print('${record.id}: ${record.statusDesc}');
  ///   }
  /// }
  /// ```
  Future<AuvBaseResponse<List<AuvAiHelpRecordResponse>>> getAiHelpRecords({
    String? lang,
    required int userId,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.getAiHelpRecords,
        queryParameters: lang != null ? {'lang': lang} : null,
        data: {'userId': userId},
      );
      return handleListResponse<AuvAiHelpRecordResponse>(
        response.data,
        (data) => AuvAiHelpRecordResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvAiHelpRecordResponse>>(e);
    }
  }

  /// 保存AI Help表单或聊天数据
  ///
  /// 示例:
  /// ```dart
  /// final result = await systemService.saveAiHelpRecord(
  ///   userId: 1698902146478649346,
  ///   contentType: 1,
  ///   content: 'Hello, I need help',
  /// );
  /// if (result.success) {
  ///   print('保存成功');
  /// }
  /// ```
  Future<AuvBaseResponse<bool>> saveAiHelpRecord({
    required int userId,
    required int contentType,
    required String content,
  }) async {
    try {
      final response = await post(
        AuvNetRoutes.saveAiHelpRecord,
        data: {
          'userId': userId,
          'contentType': contentType,
          'content': content,
        },
      );
      return handleSingleValueResponse<bool>(
        response.data,
        (data) => data == true,
      );
    } catch (e) {
      return handleError<bool>(e);
    }
  }
}
