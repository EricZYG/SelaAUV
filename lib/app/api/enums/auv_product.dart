/// 商品类型枚举
///
/// 用于区分不同场景下的商品类型
enum AuvProductType {
  /// 充值中心商品
  recharge,

  /// 快捷弹窗商品
  quickPopup,

  /// 充值VIP商品
  vip;

  /// 获取枚举对应的整数值
  int get value {
    switch (this) {
      case AuvProductType.recharge:
        return 1;
      case AuvProductType.quickPopup:
        return 2;
      case AuvProductType.vip:
        return 3;
    }
  }

  /// 根据整数值获取枚举
  static AuvProductType fromValue(int value) {
    switch (value) {
      case 1:
        return AuvProductType.recharge;
      case 2:
        return AuvProductType.quickPopup;
      case 3:
        return AuvProductType.vip;
      default:
        return AuvProductType.recharge;
    }
  }
}
