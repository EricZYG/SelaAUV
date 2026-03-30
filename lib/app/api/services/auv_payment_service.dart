import 'package:get/get.dart';
import 'package:slea_auv/app/api/auv_showdoc_routes.dart';
import 'package:slea_auv/app/api/models/auv_models.dart';
import 'package:slea_auv/app/api/services/auv_base_service.dart';
import 'package:slea_auv/app/services/auv_api_service.dart';
import 'package:slea_auv/app/models/auv_msg_model.dart';

/// 支付服务
/// 
/// 处理支付相关接口：订单、优惠券、降档营销，金币商城等
class AuvPaymentService extends AuvBaseService {
  /// 创建服务实例
  static AuvPaymentService create() {
    final service = AuvPaymentService();
    service.init(Get.find<AuvApiService>());
    return service;
  }

  /// 获取商品列表
  /// 
  /// 获取指定类型的商品列表
  /// 
  /// [type] 商品类型（必填），如充值商品、VIP商品等
  /// 
  /// 返回值: 商品列表
  Future<AuvShowDocResponse<List<AuvProduct>>> getProducts({
    required AuvProductType type,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getProducts,
        queryParameters: {'type': type.value},
      );
      return handleListResponse<AuvProduct>(
        response.data,
        (data) => AuvProduct.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvProduct>>(e);
    }
  }

  /// 按国家获取单个商品
  /// 
  /// 获取特定国家的商品价格信息
  /// 
  /// [productId] 商品ID（必填）
  /// [countryCode] 国家代码（必填），用于获取当地价格
  /// 
  /// 返回值: 商品信息
  Future<AuvShowDocResponse<AuvProduct>> getCountryProduct({
    required int productId,
    required int countryCode,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getCountryProduct,
        queryParameters: {
          'productId': productId,
          'countryCode': countryCode,
        },
      );
      return handleResponse<AuvProduct>(
        response.data,
        (data) => AuvProduct.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvProduct>(e);
    }
  }

  /// 获取官方支付商品id列表
  /// 
  /// 获取官方支持的支付商品ID列表，用于支付校验
  /// 
  /// 返回值: 商品ID列表
  Future<AuvShowDocResponse<List<String>>> getProductCodes() async {
    try {
      final response = await get(AuvShowDocRoutes.getProductCodes);
      return handleListResponse<String>(
        response.data,
        (data) => data.toString(),
      );
    } catch (e) {
      return handleError<List<String>>(e);
    }
  }

  /// 获取订单列表
  /// 
  /// 分页获取用户的订单历史列表
  /// 
  /// [params] 订单查询参数（必填），包含分页信息、订单状态筛选等
  /// 
  /// 返回值: 订单列表响应
  Future<AuvShowDocResponse<AuvOrderListResponse>> getOrderList({
    required AuvOrderListParams params,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.getOrderList,
        data: params.toJson(),
        needSign: false,
      );
      return handleResponse<AuvOrderListResponse>(
        response.data,
        (data) => AuvOrderListResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvOrderListResponse>(e);
    }
  }

  /// 批量获取订单状态
  /// 
  /// 批量查询多个订单的状态
  /// 
  /// [orderNos] 订单号列表（必填）
  /// 
  /// 返回值: 订单状态列表
  Future<AuvShowDocResponse<List<AuvOrderStatusItem>>> getOrderStatusBatch({
    required List<String> orderNos,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.getOrderStatusBatch,
        data: {'orderNos': orderNos},
        needSign: false,
      );
      return handleListResponse<AuvOrderStatusItem>(
        response.data,
        (data) => AuvOrderStatusItem.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvOrderStatusItem>>(e);
    }
  }

  /// 充值（下单）
  /// 
  /// 创建一个新的充值订单
  /// 
  /// [params] 创建订单参数（必填），包含商品ID、支付方式等
  /// 
  /// 返回值: 创建的订单响应
  /// 
  /// 注意: 此接口需要签名验证
  Future<AuvShowDocResponse<AuvCreateOrderResponse>> createOrder({
    required AuvCreateOrderParams params,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.createOrder,
        data: params.toJson(),
        needSign: true,
      );
      return handleResponse<AuvCreateOrderResponse>(
        response.data,
        (data) => AuvCreateOrderResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<AuvCreateOrderResponse>(e);
    }
  }

  /// 获取待领取的优惠券
  /// 
  /// 获取用户可领取的优惠券列表
  /// 
  /// 返回值: 优惠券列表
  Future<AuvShowDocResponse<List<AuvCoupon>>> getNewCoupon() async {
    try {
      final response = await get(AuvShowDocRoutes.getNewCoupon);
      return handleListResponse<AuvCoupon>(
        response.data,
        (data) => AuvCoupon.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvCoupon>>(e);
    }
  }

  /// 领取优惠券
  /// 
  /// 领取指定优惠券
  /// 
  /// [couponId] 优惠券ID（必填）
  /// 
  /// 返回值: 空响应
  Future<AuvShowDocResponse<void>> takeCoupon({
    required int couponId,
  }) async {
    try {
      final response = await post(
        '${AuvShowDocRoutes.takeCoupon}/$couponId',
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 查询用户优惠券
  /// 
  /// 查询用户持有的优惠券列表
  /// 
  /// [available] 是否只查询可用优惠券（必填），1-只查可用，0-全部
  /// 
  /// 返回值: 用户优惠券列表
  Future<AuvShowDocResponse<List<AuvUserCoupon>>> getUserCoupons({
    required int available,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getUserCoupons,
        queryParameters: {'available': available},
      );
      return handleListResponse<AuvUserCoupon>(
        response.data,
        (data) => AuvUserCoupon.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvUserCoupon>>(e);
    }
  }

  /// 获取商品列表附带优惠券
  /// 
  /// 获取商品列表，同时返回可用的优惠券信息
  /// 
  /// [type] 商品类型（必填）
  /// 
  /// 返回值: 带优惠券的商品列表
  Future<AuvShowDocResponse<List<AuvProductWithCouponResponse>>> getProductsWithCoupon({
    required AuvProductType type,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getProductsWithCoupon,
        queryParameters: {'type': type.value},
      );
      return handleListResponse<AuvProductWithCouponResponse>(
        response.data,
        (data) => AuvProductWithCouponResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvProductWithCouponResponse>>(e);
    }
  }

  /// 获取中奖商品
  /// 
  /// 获取幸运抽奖的中奖商品信息
  /// 
  /// [whichOne] 抽奖序号（必填），用于区分不同轮次的抽奖
  /// 
  /// 返回值: 中奖商品信息
  Future<AuvShowDocResponse<AuvLotteryProductResponse?>> getLotteryProduct({
    required int whichOne,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getLotteryProduct,
        queryParameters: {'whichOne': whichOne},
      );
      return handleResponse<AuvLotteryProductResponse?>(
        response.data,
        (data) => data != null ? AuvLotteryProductResponse.fromJson(data) : null,
      );
    } catch (e) {
      return handleError<AuvLotteryProductResponse?>(e);
    }
  }

  /// 获取分次订单领取记录
  /// 
  /// 获取分次订单的领取状态和记录
  /// 
  /// 返回值: 分次订单响应
  Future<AuvShowDocResponse<AuvSplitOrderResponse?>> getSplitOrder() async {
    try {
      final response = await get(AuvShowDocRoutes.getSplitOrder);
      return handleResponse<AuvSplitOrderResponse?>(
        response.data,
        (data) => data != null ? AuvSplitOrderResponse.fromJson(data) : null,
      );
    } catch (e) {
      return handleError<AuvSplitOrderResponse?>(e);
    }
  }

  /// 领取分次订单奖励
  /// 
  /// 领取分次订单的下一期奖励
  /// 
  /// 返回值: 空响应
  Future<AuvShowDocResponse<void>> takeSplitReward() async {
    try {
      final response = await post(
        AuvShowDocRoutes.takeSplitReward,
        needSign: false,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// 主播索要充值
  /// 
  /// 主播向用户发起充值请求
  /// 
  /// [userId] 用户ID（必填），被索要的用户
  /// 
  /// 返回值: 索要充值响应
  Future<AuvShowDocResponse<AuvBegRechargeResponse?>> begRecharge({
    required int userId,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.begRecharge,
        data: {'userId': userId},
        needSign: false,
      );
      return handleResponse<AuvBegRechargeResponse?>(
        response.data,
        (data) => data != null ? AuvBegRechargeResponse.fromJson(data) : null,
      );
    } catch (e) {
      return handleError<AuvBegRechargeResponse?>(e);
    }
  }

  /// 获取降档营销配置
  /// 
  /// 获取降档营销活动的配置信息
  /// 
  /// 返回值: 降档营销配置
  Future<AuvShowDocResponse<AuvDowngradeConfigResponse?>> getDowngradeConfig() async {
    try {
      final response = await get(AuvShowDocRoutes.getDowngradeConfig);
      return handleResponse<AuvDowngradeConfigResponse?>(
        response.data,
        (data) => data != null ? AuvDowngradeConfigResponse.fromJson(data) : null,
      );
    } catch (e) {
      return handleError<AuvDowngradeConfigResponse?>(e);
    }
  }

  /// 获取降档营销商品
  /// 
  /// 获取指定轮次的降档营销商品
  /// 
  /// [roundNo] 轮次编号（必填）
  /// 
  /// 返回值: 降档营销商品
  Future<AuvShowDocResponse<AuvDowngradeProductResponse?>> getDowngradeProduct({
    required int roundNo,
  }) async {
    try {
      final response = await get(
        AuvShowDocRoutes.getDowngradeProduct,
        queryParameters: {'roundNo': roundNo},
      );
      return handleResponse<AuvDowngradeProductResponse?>(
        response.data,
        (data) => data != null ? AuvDowngradeProductResponse.fromJson(data) : null,
      );
    } catch (e) {
      return handleError<AuvDowngradeProductResponse?>(e);
    }
  }

  /// 获取金币商城
  /// 
  /// 获取可兑换的商品商城列表
  /// 
  /// 返回值: 商城列表
  Future<AuvShowDocResponse<List<AuvExchangeStoreResponse>?>> getStores() async {
    try {
      final response = await get(AuvShowDocRoutes.getStores);
      return handleListResponse<AuvExchangeStoreResponse>(
        response.data,
        (data) => AuvExchangeStoreResponse.fromJson(data),
      );
    } catch (e) {
      return handleError<List<AuvExchangeStoreResponse>?>(e);
    }
  }

  /// 兑换钻石
  /// 
  /// 使用金币兑换钻石
  /// 
  /// [storeId] 商城商品ID（必填）
  /// 
  /// 返回值: 空响应
  Future<AuvShowDocResponse<void>> exchangeDiamonds({
    required int storeId,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.exchangeDiamonds,
        data: {'storeId': storeId,
      );
      return handleVoidResponse(response.data);
    } catch (e) {
      return handleError<void>(e);
    }
  }

  /// payerMax前置组件初始化
  /// 
  /// payerMax支付前置初始化，获取加密key
  /// 
  /// [uid] 用户ID（必填）
  /// [orderNo] 订单号（必填）
  /// 
  /// 返回值: payerMax密钥响应
  Future<AuvShowDocResponse<AuvPayerMaxKeyResponse?>> createPayerMaxKey({
    required int uid,
    required String orderNo,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.createPayerMaxKey,
        data: {
          'uid': uid,
          'orderNo': orderNo,
        },
        needSign: false,
      );
      return handleResponse<AuvPayerMaxKeyResponse?>(
        response.data,
        (data) => data != null ? AuvPayerMaxKeyResponse.fromJson(data) : null,
      );
    } catch (e) {
      return handleError<AuvPayerMaxKeyResponse?>(e);
    }
  }

  /// h5页面payerMax充值
  /// 
  /// 在H5页面使用payerMax进行充值
  /// 
  /// [uid] 用户ID（必填）
  /// [orderNo] 订单号（必填）
  /// [paymentToken] 支付令牌（必填）
  /// [sessionKey] 会话密钥（必填）
  /// 
  /// 返回值: payerMax订单响应
  Future<AuvShowDocResponse<AuvPayerMaxKeyResponse?>> createPayerMaxOrder({
    required int uid,
    required String orderNo,
    required String paymentToken,
    required String sessionKey,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.createPayerMaxOrder,
        data: {
          'uid': uid,
          'orderNo': orderNo,
          'paymentToken': paymentToken,
          'sessionKey': sessionKey,
        },
        needSign: false,
      );
      return handleResponse<AuvPayerMaxKeyResponse?>(
        response.data,
        (data) => data != null ? AuvPayerMaxKeyResponse.fromJson(data) : null,
      );
    } catch (e) {
      return handleError<AuvPayerMaxKeyResponse?>(e);
    }
  }

  /// 查询订单简要信息
  /// 
  /// 批量查询订单的简要信息
  /// 
  /// [request] 订单查询请求（必填），包含订单号列表等
  /// 
  /// 返回值: 订单简要信息列表
  Future<AuvShowDocResponse<AuvOrderSimpleListDataResponse?>> getOrderSimpleList({
    required AuvGetOrderSimpleListRequest request,
  }) async {
    try {
      final response = await post(
        AuvShowDocRoutes.getOrderSimpleList,
        data: request.toJson(),
        needSign: false,
      );
      return handleResponse<AuvOrderSimpleListDataResponse?>(
        response.data,
        (data) => data != null ? AuvOrderSimpleListDataResponse.fromJson(data) : null,
      );
    } catch (e) {
      return handleError<AuvOrderSimpleListDataResponse?>(e);
    }
  }
}
