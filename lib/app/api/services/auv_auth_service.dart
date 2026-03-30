import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_showdoc_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/models/user/auv_guild_login_response.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';

/// 认证服务
/// 
/// 处理登录注册相关接口
class AuvAuthService extends AuvBaseService {
  /// 创建服务实例
  static AuvAuthService create() {
    final service = AuvAuthService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 游客登录
  /// 
  /// 无需验证码的登录方式
  /// 
  /// [password] 加密后的密码（必填）
  /// [aidLimit] 是否限制广告id获取，0.未限制，1.限制获取（可选）
  /// [aid] 广告id（可选）
  /// [useVpn] 是否使用了vpn，0.未使用，1.使用了（可选）
  /// 
  /// 返回值: 包含userId和authorization的登录响应
  /// 
  /// 注意: 此接口需要签名验证
  Future<AuvShowDocResponse<AuvLoginResponse>> guestLogin({
    required String password,
    int? aidLimit,
    String? aid,
    int? useVpn,
  }) async {
    try {
      final data = {
        'password': password,
        if (aidLimit != null) 'aidLimit': aidLimit,
        if (aid != null) 'aid': aid,
        if (useVpn != null) 'useVpn': useVpn,
      };

      final response = await post(
        AuvShowDocRoutes.guestLogin,
        data: data,
        needSign: true,
      );
      return handleResponse<AuvLoginResponse>(
        response.data,
        (data) => AuvLoginResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvLoginResponse>(e);
    }
  }

  /// 手机号登录
  /// 
  /// 使用手机号和验证码进行登录
  /// 
  /// [phone] 手机号
  /// [code] 验证码
  /// 
  /// 返回值: 包含userId和token的登录响应
  /// 
  /// 注意: 此接口需要签名验证
  Future<AuvShowDocResponse<AuvLoginResponse>> phoneLogin({
    required String phone,
    required String code,
  }) async {
    try {
      final data = {
        'phone': phone,
        'code': code,
      };

      final response = await post(
        AuvShowDocRoutes.phoneLogin,
        data: data,
        needSign: true,
      );
      return handleResponse<AuvLoginResponse>(
        response.data,
        (data) => AuvLoginResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvLoginResponse>(e);
    }
  }

  /// 谷歌登录
  /// 
  /// 使用Google ID Token进行登录
  /// 
  /// [idToken] Google ID Token，从Google Sign-In获取
  /// 
  /// 返回值: 包含userId和token的登录响应
  /// 
  /// 注意: 此接口需要签名验证
  Future<AuvShowDocResponse<AuvLoginResponse>> googleLogin({
    required String idToken,
  }) async {
    try {
      final data = {'id_token': idToken};

      final response = await post(
        AuvShowDocRoutes.googleLogin,
        data: data,
        needSign: true,
      );
      return handleResponse<AuvLoginResponse>(
        response.data,
        (data) => AuvLoginResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvLoginResponse>(e);
    }
  }

  /// 苹果登录
  /// 
  /// 使用Apple Identity Token进行登录
  /// 
  /// [identityToken] Apple Identity Token
  /// [authorizationCode] 苹果授权码（可选）
  /// [name] 用户显示名称（可选）
  /// 
  /// 返回值: 包含userId和token的登录响应
  /// 
  /// 注意: 此接口需要签名验证
  Future<AuvShowDocResponse<AuvLoginResponse>> appleLogin({
    required String identityToken,
    String? authorizationCode,
    String? name,
  }) async {
    try {
      final data = {
        'identity_token': identityToken,
        if (authorizationCode != null) 'authorization_code': authorizationCode,
        if (name != null) 'name': name,
      };

      final response = await post(
        AuvShowDocRoutes.appleLogin,
        data: data,
        needSign: true,
      );
      return handleResponse<AuvLoginResponse>(
        response.data,
        (data) => AuvLoginResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvLoginResponse>(e);
    }
  }

  /// 公会后台邀请码密码登录
  /// 
  /// 分配的客户端账号设置了密码后不能再用邀请码登录，只能用账号登录
  /// 
  /// [username] 邀请码
  /// [password] 明文密码
  /// 
  /// 返回值:
  /// - code=0: 成功，返回authorization (JWT token)
  /// - code=1031: 不能再用邀请码登录，此时返回的data为账号id
  /// 
  /// 注意: 此接口需要签名验证
  Future<AuvShowDocResponse<AuvGuildLoginResponse>> guildLogin({
    required String username,
    required String password,
  }) async {
    try {
      final data = {
        'username': username,
        'password': password,
      };

      final response = await post(
        AuvShowDocRoutes.guildLogin,
        data: data,
        needSign: true,
      );

      // 解析响应
      final code = response.data['code'] as int? ?? 1001;
      final isSuccess = code == 0;
      final responseData = response.data['data'];

      // 根据响应码构建不同类型的响应
      final guildLoginResponse = AuvGuildLoginResponse.fromData(responseData, isSuccess);

      return AuvShowDocResponse(
        success: isSuccess,
        code: code,
        message: response.data['message'] ?? (isSuccess ? 'Operation succeeded' : 'Operation failed'),
        data: guildLoginResponse,
      );
    } catch (e) {
      return handleError<AuvGuildLoginResponse>(e);
    }
  }
}
