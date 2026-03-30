/// 充值服务
/// 
/// 处理金币充值、VIP购买、充值记录等相关接口
import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_api_routes.dart';
import 'package:slea_auv/app/models/auv_match_model.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/api/auv_api_result.dart';

class AuvChargeService extends GetxService {
  final AuvApiService _api = AuvApiService();

  /// 获取用户金币余额
  /// 
  /// 获取当前登录用户的金币余额
  /// 
  /// 返回值: 金币数量
  Future<AuvApiResult<int>> getCoinBalance() async {
    try {
      final response = await _api.get(AuvApiRoutes.coinBalance);

      if (response.data['code'] == 200) {
        return AuvApiResult.success(response.data['data']['coins']);
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to get balance',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 获取商品列表
  /// 
  /// 获取充值商品列表，包含各种金币档位
  /// 
  /// 返回值: 商品列表
  Future<AuvApiResult<List<AuvProduct>>> getProducts() async {
    try {
      final response = await _api.get(AuvApiRoutes.products);

      if (response.data['code'] == 200) {
        final List<AuvProduct> list = (response.data['data']['list'] as List)
            .map((e) => AuvProduct.fromJson(e))
            .toList();
        return AuvApiResult.success(list);
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to get products',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 创建充值订单
  /// 
  /// 创建一个新的充值订单，用于发起支付
  /// 
  /// [productId] 商品ID（必填），从商品列表中选择
  /// 
  /// 返回值: 订单ID
  Future<AuvApiResult<String>> createRechargeOrder(String productId) async {
    try {
      final response = await _api.post(
        AuvApiRoutes.coinRecharge,
        data: {'product_id': productId},
      );

      if (response.data['code'] == 200) {
        return AuvApiResult.success(response.data['data']['order_id']);
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to create order',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 获取充值记录
  /// 
  /// 分页获取用户的充值历史记录
  /// 
  /// [page] 页码（可选），默认1
  /// [pageSize] 每页数量（可选），默认20
  /// 
  /// 返回值: 充值记录列表
  Future<AuvApiResult<List<AuvRechargeRecord>>> getRechargeRecords({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _api.get(
        AuvApiRoutes.coinRecords,
        queryParameters: {'page': page, 'page_size': pageSize},
      );

      if (response.data['code'] == 200) {
        final List<AuvRechargeRecord> list = (response.data['data']['list'] as List)
            .map((e) => AuvRechargeRecord.fromJson(e))
            .toList();
        return AuvApiResult.success(list);
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to get records',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 获取 VIP 信息
  /// 
  /// 获取当前用户的VIP状态和VIP权益信息
  /// 
  /// 返回值: VIP信息
  Future<AuvApiResult<Map<String, dynamic>>> getVipInfo() async {
    try {
      final response = await _api.get(AuvApiRoutes.vipInfo);

      if (response.data['code'] == 200) {
        return AuvApiResult.success(response.data['data']);
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to get VIP info',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }

  /// 购买 VIP
  /// 
  /// 购买VIP会员
  /// 
  /// [planId] VIP套餐ID（必填）
  /// 
  /// 返回值: 订单ID
  Future<AuvApiResult<String>> purchaseVip(String planId) async {
    try {
      final response = await _api.post(
        AuvApiRoutes.vipPurchase,
        data: {'plan_id': planId},
      );

      if (response.data['code'] == 200) {
        return AuvApiResult.success(response.data['data']['order_id']);
      } else {
        return AuvApiResult.fail(
          response.data['message'] ?? 'Failed to purchase VIP',
          code: response.data['code'],
        );
      }
    } catch (e) {
      return AuvApiResult.fail('Network error: $e');
    }
  }
}
