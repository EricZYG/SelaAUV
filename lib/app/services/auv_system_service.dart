import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_api_routes.dart';
import 'package:slea_auv/app/api/auv_api_result.dart';
import 'package:slea_auv/app/models/auv_app_config.dart';
import 'package:slea_auv/app/models/auv_banner_model.dart';
import 'package:slea_auv/app/models/auv_language_config.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';

/// 系统服务
class AuvSystemService extends GetxService {
  final AuvApiService _api = Get.find<AuvApiService>();

  AuvAppConfigUser? _userConfig;
  AuvAppConfigAnchor? _anchorConfig;

  AuvAppConfigUser? get userConfig => _userConfig;
  AuvAppConfigAnchor? get anchorConfig => _anchorConfig;

  /// 获取应用配置
  Future<AuvApiResult<AuvAppConfigUser>> getAppConfigForUser() async {
    try {
      final response = await _api.get(AuvApiRoutes.appConfig);
      final result = AuvApiResult.fromResponse(response.data);

      if (result.success) {
        _userConfig = AuvAppConfigUser.fromJson(result.data);
        return AuvApiResult.success(_userConfig!);
      }
      return AuvApiResult.fail(result.errorMessage);
    } catch (e) {
      return AuvApiResult.fail(e.toString());
    }
  }

  Future<AuvApiResult<AuvAppConfigAnchor>> getAppConfigForAnchor() async {
    try {
      final response = await _api.get(AuvApiRoutes.appConfig);
      final result = AuvApiResult.fromResponse(response.data);

      if (result.success) {
        _anchorConfig = AuvAppConfigAnchor.fromJson(result.data);
        return AuvApiResult.success(_anchorConfig!);
      }
      return AuvApiResult.fail(result.errorMessage);
    } catch (e) {
      return AuvApiResult.fail(e.toString());
    }
  }

  /// 获取 Agora AppId
  String? get agoraAppId {
    return _userConfig?.agoraAppId ?? _anchorConfig?.agoraAppId;
  }

  /// 获取金币兑换钻石比例
  int get coinsToDiamondsRate => _userConfig?.coins2Diamonds ?? 10;

  /// 获取通话价格（每分钟钻石数）
  double get callPricePerMinute => _userConfig?.callPrice ?? 0;

  /// 检查直播是否开启
  bool get isLiveEnabled => _anchorConfig?.isLiveEnabled ?? false;

  /// 获取 RTM Token
  Future<AuvApiResult<String>> getRtmToken() async {
    try {
      final response = await _api.get(AuvApiRoutes.rtmToken);
      final result = AuvApiResult.fromResponse(response.data);

      if (result.success) {
        final token = result.data?.toString() ?? '';
        return AuvApiResult.success(token);
      }
      return AuvApiResult.fail(result.errorMessage);
    } catch (e) {
      return AuvApiResult.fail(e.toString());
    }
  }

  /// 获取 RTC Token
  Future<AuvApiResult<String>> getRtcToken() async {
    try {
      final response = await _api.get(AuvApiRoutes.rtcToken);
      final result = AuvApiResult.fromResponse(response.data);

      if (result.success) {
        final token = result.data?.toString() ?? '';
        return AuvApiResult.success(token);
      }
      return AuvApiResult.fail(result.errorMessage);
    } catch (e) {
      return AuvApiResult.fail(e.toString());
    }
  }

  /// 获取语言配置列表
  Future<AuvApiResult<List<AuvLanguageConfig>>> getLanguageConfig() async {
    try {
      final response = await _api.get(AuvApiRoutes.languageConfig);
      final result = AuvApiResult.fromResponse(response.data);

      if (result.success && result.data is List) {
        final list = (result.data as List)
            .map((e) => AuvLanguageConfig.fromJson(e))
            .toList();
        return AuvApiResult.success(list);
      }
      return AuvApiResult.fail(result.errorMessage);
    } catch (e) {
      return AuvApiResult.fail(e.toString());
    }
  }

  /// 获取 Banner 列表
  Future<AuvApiResult<List<AuvBannerModel>>> getBanners() async {
    try {
      final response = await _api.get(AuvApiRoutes.banners);
      final result = AuvApiResult.fromResponse(response.data);

      if (result.success && result.data is List) {
        final list = (result.data as List)
            .map((e) => AuvBannerModel.fromJson(e))
            .toList();
        return AuvApiResult.success(list);
      }
      return AuvApiResult.fail(result.errorMessage);
    } catch (e) {
      return AuvApiResult.fail(e.toString());
    }
  }
}
