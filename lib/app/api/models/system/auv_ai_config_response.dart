/// AI配置模型
///
/// 表示AI配置信息
///
/// 字段说明:
/// - configType: 类型，1.未付费用户，2.付费有接听能力，3.付费无接听能力
/// - minDelay: AI最小间隔，秒数
/// - typeDelay: 类型变更后首次aib间隔，秒数
/// - idleDelay: 无操作触发aib：aib间隔，秒数
/// - idleReset: 无操作触发aib：重新触发条件，秒数
/// - slideUnit: 滑动列表触发aib：滑动列表次数
/// - slideLimit: 滑动列表触发aib：当日次数
/// - scanStay: 连续看主播触发aib：停留时间，秒数
/// - scanDelay: 连续看主播触发aib：aib触发时间，秒数
/// - scanLimit: 连续看主播触发aib：进入主页次数
/// - scanReset: 连续看主播触发aib：重新触发条件，秒数
/// - refuseUnit: 挂断屏蔽aib：连续挂断次数
/// - refuseLimit: 挂断屏蔽aib：总挂断次数
/// - refuseReset: 挂断屏蔽aib：屏蔽时间，秒数
/// - aivDailyLimit: 每天触发aiv次数
/// - aivTotalLimit: 累计触发aiv次数
/// - aivSwitch: aiv开关，0.关闭，1.开启
class AuvAiConfigResponse {
  /// 类型，1.未付费用户，2.付费有接听能力，3.付费无接听能力
  final int? configType;

  /// AI最小间隔，秒数
  final int? minDelay;

  /// 类型变更后首次aib间隔，秒数
  final int? typeDelay;

  /// 无操作触发aib：aib间隔，秒数
  final int? idleDelay;

  /// 无操作触发aib：重新触发条件，秒数
  final int? idleReset;

  /// 滑动列表触发aib：滑动列表次数
  final int? slideUnit;

  /// 滑动列表触发aib：当日次数
  final int? slideLimit;

  /// 连续看主播触发aib：停留时间，秒数
  final int? scanStay;

  /// 连续看主播触发aib：aib触发时间，秒数
  final int? scanDelay;

  /// 连续看主播触发aib：进入主页次数
  final int? scanLimit;

  /// 连续看主播触发aib：重新触发条件，秒数
  final int? scanReset;

  /// 挂断屏蔽aib：连续挂断次数
  final int? refuseUnit;

  /// 挂断屏蔽aib：总挂断次数
  final int? refuseLimit;

  /// 挂断屏蔽aib：屏蔽时间，秒数
  final int? refuseReset;

  /// 每天触发aiv次数
  final int? aivDailyLimit;

  /// 累计触发aiv次数
  final int? aivTotalLimit;

  /// aiv开关，0.关闭，1.开启
  final int? aivSwitch;

  AuvAiConfigResponse({
    this.configType,
    this.minDelay,
    this.typeDelay,
    this.idleDelay,
    this.idleReset,
    this.slideUnit,
    this.slideLimit,
    this.scanStay,
    this.scanDelay,
    this.scanLimit,
    this.scanReset,
    this.refuseUnit,
    this.refuseLimit,
    this.refuseReset,
    this.aivDailyLimit,
    this.aivTotalLimit,
    this.aivSwitch,
  });

  factory AuvAiConfigResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return AuvAiConfigResponse();
    return AuvAiConfigResponse(
      configType: json['configType'],
      minDelay: json['minDelay'],
      typeDelay: json['typeDelay'],
      idleDelay: json['idleDelay'],
      idleReset: json['idleReset'],
      slideUnit: json['slideUnit'],
      slideLimit: json['slideLimit'],
      scanStay: json['scanStay'],
      scanDelay: json['scanDelay'],
      scanLimit: json['scanLimit'],
      scanReset: json['scanReset'],
      refuseUnit: json['refuseUnit'],
      refuseLimit: json['refuseLimit'],
      refuseReset: json['refuseReset'],
      aivDailyLimit: json['aivDailyLimit'],
      aivTotalLimit: json['aivTotalLimit'],
      aivSwitch: json['aivSwitch'],
    );
  }

  /// 获取配置类型描述
  String get configTypeDesc {
    switch (configType) {
      case 1:
        return '未付费用户';
      case 2:
        return '付费有接听能力';
      case 3:
        return '付费无接听能力';
      default:
        return '未知';
    }
  }

  /// aiv是否开启
  bool get isAivEnabled => aivSwitch == 1;
}