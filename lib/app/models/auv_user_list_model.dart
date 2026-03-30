import 'auv_user_model.dart';

/// 用户在线状态枚举
enum AuvUserOnlineStatus {
  offline(0, '离线'),
  online(1, '在线'),
  busy(2, '忙线');

  final int value;
  final String label;
  const AuvUserOnlineStatus(this.value, this.label);

  static AuvUserOnlineStatus fromValue(int value) {
    return AuvUserOnlineStatus.values
        .where((e) => e.value == value)
        .firstOrNull ?? AuvUserOnlineStatus.offline;
  }
}

/// 关注状态枚举
enum AuvFollowStatus {
  unknown(0, '未知'),
  notFollowed(1, '未关注'),
  followed(2, '已关注'),
  friends(3, '好友');

  final int value;
  final String label;
  const AuvFollowStatus(this.value, this.label);

  static AuvFollowStatus fromValue(int value) {
    return AuvFollowStatus.values
        .where((e) => e.value == value)
        .firstOrNull ?? AuvFollowStatus.unknown;
  }
}

/// 喜欢状态枚举
enum AuvLikeStatus {
  unknown(0, '未知'),
  notLiked(1, '未喜欢'),
  liked(2, '已喜欢');

  final int value;
  final String label;
  const AuvLikeStatus(this.value, this.label);

  static AuvLikeStatus fromValue(int value) {
    return AuvLikeStatus.values
        .where((e) => e.value == value)
        .firstOrNull ?? AuvLikeStatus.unknown;
  }
}

/// 用户列表项（主播首页）
/// 
/// 用于显示主播首页的用户列表
/// 
/// 对应接口: POST /user/user/getUsers
/// 
/// 响应示例:
/// ```json
/// {
///   "userId": 10000389,
///   "username": "10000389",
///   "countryCode": 840,
///   "userAuth": 0,
///   "isOnline": 1,
///   "nickname": "hlkbk",
///   "portrait": "https://...",
///   "vipEndTime": 0,
///   "remainDiamonds": 0,
///   "countryPath": "https://...",
///   "countryTitle": "America",
///   "followFlag": 1,
///   "likeFlag": 1,
///   "levelConfig": {...}
/// }
/// ```
class AuvUserListItem {
  /// 用户ID
  /// 类型: long
  /// 说明: 用户的唯一标识符
  final int userId;

  /// 用户名
  /// 类型: string
  /// 说明: 用于显示的用户ID，如"10000389"
  final String username;

  /// 国家编码
  /// 类型: int
  /// 说明: 用户的国家代码，如840代表美国
  final int countryCode;

  /// 认证状态
  /// 类型: int
  /// 说明: 0.男用户，1.待认证主播，2.已认证主播，3.认证失败主播，4.违规主播
  final int userAuth;

  /// 在线状态
  /// 类型: int
  /// 说明: 0.离线，1.在线，2.忙线
  final int isOnline;

  /// 勿扰标识
  /// 类型: int
  /// 说明: 0.关闭，1.开启
  final int disturbFlag;

  /// 用户昵称
  /// 类型: string
  /// 说明: 用户的显示昵称
  final String nickname;

  /// 用户头像
  /// 类型: string
  /// 说明: 用户头像的图片URL
  final String portrait;

  /// VIP结束时间
  /// 类型: long
  /// 说明: VIP会员到期的毫秒时间戳，0表示非VIP
  final int vipEndTime;

  /// 总充值金额
  /// 类型: int?
  /// 说明: 用户累计充值金额（单位：分）
  final int? totalRecharge;

  /// 剩余钻石
  /// 类型: int
  /// 说明: 用户当前剩余钻石数量（单位：个，非分）
  final int remainDiamonds;

  /// 国旗链接
  /// 类型: string
  /// 说明: 用户国家的国旗图片URL
  final String countryPath;

  /// 国家名称
  /// 类型: string
  /// 说明: 用户国家的显示名称，如"America"
  final String countryTitle;

  /// 国家子编码
  /// 类型: String?
  /// 说明: 国家的二位代码，如"US"、"CN"
  final String? countrySubCode;

  /// 关注状态
  /// 类型: int
  /// 说明: 1.未关注，2.已关注，3.好友
  final int followFlag;

  /// 喜欢状态
  /// 类型: int
  /// 说明: 1.未喜欢，2.已喜欢
  final int likeFlag;

  /// 喜欢我的人数
  /// 类型: int
  /// 说明: 有多少用户喜欢了该用户
  final int likeMeCount;

  /// 等级配置
  /// 类型: AuvUserLevelConfig?
  /// 说明: 用户的等级信息，包含等级、头像框等
  final AuvUserLevelConfig? levelConfig;

  AuvUserListItem({
    required this.userId,
    required this.username,
    required this.countryCode,
    required this.userAuth,
    required this.isOnline,
    required this.disturbFlag,
    required this.nickname,
    required this.portrait,
    required this.vipEndTime,
    this.totalRecharge,
    required this.remainDiamonds,
    required this.countryPath,
    required this.countryTitle,
    this.countrySubCode,
    required this.followFlag,
    required this.likeFlag,
    required this.likeMeCount,
    this.levelConfig,
  });

  /// 是否在线
  bool get isUserOnline => isOnline == AuvUserOnlineStatus.online.value;

  /// 是否忙碌
  bool get isUserBusy => isOnline == AuvUserOnlineStatus.busy.value;

  /// 是否离线
  bool get isOffline => isOnline == AuvUserOnlineStatus.offline.value;

  /// 是否好友
  bool get isFriend => followFlag == AuvFollowStatus.friends.value;

  /// 是否已关注
  bool get hasFollowed => followFlag == AuvFollowStatus.followed.value || isFriend;

  /// 是否已喜欢
  bool get hasLiked => likeFlag == AuvLikeStatus.liked.value;

  /// 是否勿扰
  bool get isDisturb => disturbFlag == 1;

  /// 是否VIP
  bool get isVip {
    if (vipEndTime <= 0) return false;
    return vipEndTime > DateTime.now().millisecondsSinceEpoch;
  }

  /// 获取在线状态枚举
  AuvUserOnlineStatus get onlineStatus => AuvUserOnlineStatus.fromValue(isOnline);

  /// 获取在线状态描述
  String get onlineStatusLabel => onlineStatus.label;

  /// 获取关注状态枚举
  AuvFollowStatus get followStatus => AuvFollowStatus.fromValue(followFlag);

  /// 获取喜欢状态枚举
  AuvLikeStatus get likeStatus => AuvLikeStatus.fromValue(likeFlag);

  factory AuvUserListItem.fromJson(Map<String, dynamic> json) {
    return AuvUserListItem(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      userAuth: json['userAuth'] ?? 0,
      isOnline: json['isOnline'] ?? 0,
      disturbFlag: json['disturbFlag'] ?? 0,
      nickname: json['nickname'] ?? '',
      portrait: json['portrait'] ?? '',
      vipEndTime: json['vipEndTime'] ?? 0,
      totalRecharge: json['totalRecharge'],
      remainDiamonds: json['remainDiamonds'] ?? 0,
      countryPath: json['countryPath'] ?? '',
      countryTitle: json['countryTitle'] ?? '',
      countrySubCode: json['countrySubCode'],
      followFlag: json['followFlag'] ?? 1,
      likeFlag: json['likeFlag'] ?? 1,
      likeMeCount: json['likeMeCount'] ?? 0,
      levelConfig: json['levelConfig'] != null
          ? AuvUserLevelConfig.fromJson(json['levelConfig'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'countryCode': countryCode,
      'userAuth': userAuth,
      'isOnline': isOnline,
      'disturbFlag': disturbFlag,
      'nickname': nickname,
      'portrait': portrait,
      'vipEndTime': vipEndTime,
      'totalRecharge': totalRecharge,
      'remainDiamonds': remainDiamonds,
      'countryPath': countryPath,
      'countryTitle': countryTitle,
      'countrySubCode': countrySubCode,
      'followFlag': followFlag,
      'likeFlag': likeFlag,
      'likeMeCount': likeMeCount,
      'levelConfig': levelConfig?.toJson(),
    };
  }
}

/// 用户列表查询条件
/// 
/// 用于筛选用户列表的条件
class AuvUserListCondition {
  /// 国家编码
  /// 类型: int?
  /// 说明: 按国家筛选，不传表示全部国家
  final int? countryCode;

  AuvUserListCondition({this.countryCode});

  Map<String, dynamic> toJson() {
    return {
      if (countryCode != null) 'countryCode': countryCode,
    };
  }
}

/// 用户列表请求
/// 
/// 用于分页查询用户列表
class AuvUserListRequest {
  /// 页码
  final int pageNum;

  /// 每页数量
  final int pageSize;

  /// 查询条件
  final AuvUserListCondition condition;

  AuvUserListRequest({
    required this.pageNum,
    required this.pageSize,
    required this.condition,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNum': pageNum,
      'pageSize': pageSize,
      'condition': condition.toJson(),
    };
  }
}

/// 用户列表响应
/// 
/// 用户列表分页查询返回的完整数据
class AuvUserListResponse {
  /// 用户列表
  final List<AuvUserListItem> list;

  /// 总记录数
  final int total;

  /// 当前页码
  final int pageNum;

  /// 每页数量
  final int pageSize;

  /// 当前页记录数
  final int size;

  /// 当前页起始行
  final int startRow;

  /// 当前页结束行
  final int endRow;

  /// 总页数
  final int pages;

  /// 上一页页码
  final int prePage;

  /// 下一页页码
  final int nextPage;

  /// 是否第一页
  final bool isFirstPage;

  /// 是否最后一页
  final bool isLastPage;

  /// 是否存在上一页
  final bool hasPreviousPage;

  /// 是否存在下一页
  final bool hasNextPage;

  /// 导航页码数
  final int navigatePages;

  /// 导航页码数组
  final List<int>? navigatepageNums;

  /// 导航首页码
  final int navigateFirstPage;

  /// 导航末页码
  final int navigateLastPage;

  AuvUserListResponse({
    required this.list,
    required this.total,
    required this.pageNum,
    required this.pageSize,
    this.size = 0,
    this.startRow = 0,
    this.endRow = 0,
    this.pages = 1,
    this.prePage = 0,
    this.nextPage = 0,
    this.isFirstPage = false,
    this.isLastPage = false,
    this.hasPreviousPage = false,
    this.hasNextPage = false,
    this.navigatePages = 0,
    this.navigatepageNums,
    this.navigateFirstPage = 0,
    this.navigateLastPage = 0,
  });

  /// 是否为空列表
  bool get isEmpty => list.isEmpty;

  /// 是否有更多数据
  bool get hasMore => pageNum < pages;

  factory AuvUserListResponse.fromJson(Map<String, dynamic> json) {
    final listData = json['list'] ?? [];
    return AuvUserListResponse(
      list: (listData as List)
          .map((e) => AuvUserListItem.fromJson(e))
          .toList(),
      total: int.tryParse(json['total']?.toString() ?? '0') ?? 0,
      pageNum: json['pageNum'] ?? 1,
      pageSize: json['pageSize'] ?? 10,
      size: json['size'] ?? 0,
      startRow: json['startRow'] ?? 0,
      endRow: json['endRow'] ?? 0,
      pages: json['pages'] ?? 1,
      prePage: json['prePage'] ?? 0,
      nextPage: json['nextPage'] ?? 0,
      isFirstPage: json['isFirstPage'] ?? false,
      isLastPage: json['isLastPage'] ?? false,
      hasPreviousPage: json['hasPreviousPage'] ?? false,
      hasNextPage: json['hasNextPage'] ?? true,
      navigatePages: json['navigatePages'] ?? 0,
      navigatepageNums: json['navigatepageNums'] != null
          ? List<int>.from(json['navigatepageNums'])
          : null,
      navigateFirstPage: json['navigateFirstPage'] ?? 0,
      navigateLastPage: json['navigateLastPage'] ?? 0,
    );
  }
}

/// 主播认证状态枚举
enum AuvAnchorAuthStatus {
  maleUser(0, '男用户'),
  pending(1, '待认证主播'),
  certified(2, '已认证主播'),
  rejected(3, '认证失败主播'),
  violated(4, '违规主播');

  final int value;
  final String label;
  const AuvAnchorAuthStatus(this.value, this.label);

  static AuvAnchorAuthStatus fromValue(int value) {
    return AuvAnchorAuthStatus.values
        .where((e) => e.value == value)
        .firstOrNull ?? AuvAnchorAuthStatus.maleUser;
  }
}

/// 合规用户/主播列表项
/// 
/// 用于显示合规用户或认证主播的列表
class AuvFKUserItem {
  /// 用户ID
  final int userId;

  /// 用户名
  final String username;

  /// 国家编码
  final int countryCode;

  /// 认证状态
  /// 说明: 0.男用户，1.待认证主播，2.已认证主播，3.认证失败主播，4.违规主播
  final int userAuth;

  /// 在线状态
  /// 说明: 0.离线，1.在线，2.忙线
  final int isOnline;

  /// 用户昵称
  final String nickname;

  /// 个性签名
  final String signature;

  /// 性别
  /// 说明: 1男，2女
  final int sex;

  /// 生日
  final int birthday;

  /// 头像
  final String portrait;

  /// 显示封面
  final String cover;

  /// 相册视频
  final String videoUrl;

  /// 主播每分钟通话钻石数
  final double callPrice;

  /// 国旗链接
  final String countryPath;

  /// 国家名称
  final String countryTitle;

  /// 多语言代码
  final String manyLanguage;

  /// 语言显示名
  final String manyLanguageName;

  /// 关注状态
  /// 说明: 1未关注，2已关注，3好友
  final int followFlag;

  /// 是否是新主播
  /// 说明: 认证时间3天内为新主播
  final bool newAnchor;

  AuvFKUserItem({
    required this.userId,
    required this.username,
    required this.countryCode,
    required this.userAuth,
    required this.isOnline,
    required this.nickname,
    required this.signature,
    required this.sex,
    required this.birthday,
    required this.portrait,
    required this.cover,
    required this.videoUrl,
    required this.callPrice,
    required this.countryPath,
    required this.countryTitle,
    required this.manyLanguage,
    required this.manyLanguageName,
    required this.followFlag,
    required this.newAnchor,
  });

  /// 是否在线
  bool get isUserOnline => isOnline == 1;

  /// 是否忙线
  bool get isBusy => isOnline == 2;

  /// 是否已认证主播
  bool get isCertifiedAnchor => userAuth == 2;

  /// 获取认证状态枚举
  AuvAnchorAuthStatus get authStatus => AuvAnchorAuthStatus.fromValue(userAuth);

  /// 获取关注状态枚举
  AuvFollowStatus get followStatus => AuvFollowStatus.fromValue(followFlag);

  /// 关注状态名称
  String get followStatusName => followStatus.label;

  /// 获取年龄
  int? get age {
    if (birthday <= 0) return null;
    final birthDate = DateTime.fromMillisecondsSinceEpoch(birthday);
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  factory AuvFKUserItem.fromJson(Map<String, dynamic> json) {
    return AuvFKUserItem(
      userId: json['userId'] ?? 0,
      username: json['username'] ?? '',
      countryCode: json['countryCode'] ?? 0,
      userAuth: json['userAuth'] ?? 0,
      isOnline: json['isOnline'] ?? 0,
      nickname: json['nickname'] ?? '',
      signature: json['signature'] ?? '',
      sex: json['sex'] ?? 0,
      birthday: json['birthday'] ?? 0,
      portrait: json['portrait'] ?? '',
      cover: json['cover'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      callPrice: (json['callPrice'] ?? 0).toDouble(),
      countryPath: json['countryPath'] ?? '',
      countryTitle: json['countryTitle'] ?? '',
      manyLanguage: json['manyLanguage'] ?? '',
      manyLanguageName: json['manyLanguageName'] ?? '',
      followFlag: json['followFlag'] ?? 1,
      newAnchor: json['newAnchor'] ?? false,
    );
  }
}
