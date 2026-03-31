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

  /// 获取应用配置
  /// 
  /// 示例:
  /// ```dart
  /// final result = await systemService.getAppConfig();
  /// if (result.success && result.data?.ok != null) {
  ///   // 设置签名密钥
  ///   setSignKey(result.data!.ok!);
  /// }
  /// ```
  Future<AuvBaseResponse<AuvAppConfigResponse>> getAppConfig() async {
    try {
      final response = await get(AuvNetRoutes.appConfig);
      return handleResponse<AuvAppConfigResponse>(
        response.data,
        (data) => AuvAppConfigResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvAppConfigResponse>(e);
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
