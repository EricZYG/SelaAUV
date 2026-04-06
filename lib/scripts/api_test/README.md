# API 测试报文记录

> 本目录包含所有 API 接口的实际响应报文
>
> 执行时间: 2026-04-06
>
> 测试环境: testapi.selalive.com

## 测试摘要

- **成功**: 65 个接口
- **失败**: 17 个接口

## 文件夹结构

```
api_test/
├── README.md                    # 本文档
├── api_test_results_*.json      # 原始测试数据
├── user/                       # 用户相关接口
│   ├── user_user_getUserDetail_test.dart
│   ├── user_user_getUserSimple_test.dart
│   └── ...
├── system/                     # 系统相关接口
│   ├── system_app_getConfig_test.dart
│   └── ...
├── gift/                       # 礼物相关接口
│   ├── gift_list_test.dart
│   └── ...
├── product/                    # 商品/支付相关接口
│   ├── p_product_getProducts_test.dart
│   └── ...
└── call/                       # 通话相关接口
    ├── call_call_getCallRecordVoList_test.dart
    └── ...
```

## 用户模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /user/user/getUserDetail | [user_user_getUserDetail_test.dart](user/user_user_getUserDetail_test.dart) | ✅ |
| /user/prop/getUserPropVo | [user_prop_getUserPropVo_test.dart](user/user_prop_getUserPropVo_test.dart) | ✅ |
| /user/user/getUserUpdateDetailVo | [user_user_getUserUpdateDetailVo_test.dart](user/user_user_getUserUpdateDetailVo_test.dart) | ✅ |
| /user/user/getUserSimple | [user_user_getUserSimple_test.dart](user/user_user_getUserSimple_test.dart) | ✅ |
| /user/user/getRelationCount | [user_user_getRelationCount_test.dart](user/user_user_getRelationCount_test.dart) | ✅ |
| /user/user/getUserSeeVo | [user_user_getUserSeeVo_test.dart](user/user_user_getUserSeeVo_test.dart) | ✅ |
| /user/user/getUserDetail | [user_user_getUserDetail_test.dart](user/user_user_getUserDetail_test.dart) | ✅ |
| /user/info | [user_info_test.dart](user/user_info_test.dart) | ❌ |
| /user/level/getLevelInfoConfigs | [user_level_getLevelInfoConfigs_test.dart](user/user_level_getLevelInfoConfigs_test.dart) | ✅ |
| /user/advance/getDialogDetail | [user_advance_getDialogDetail_test.dart](user/user_advance_getDialogDetail_test.dart) | ✅ |
| /user/sticker/getCommonPackages | [user_sticker_getCommonPackages_test.dart](user/user_sticker_getCommonPackages_test.dart) | ✅ |
| /user/user/updateFirebaseToken | [user_user_updateFirebaseToken_test.dart](user/user_user_updateFirebaseToken_test.dart) | ✅ |
| /user/user/updateAdFlag | [user_user_updateAdFlag_test.dart](user/user_user_updateAdFlag_test.dart) | ✅ |
| /user/user/deleteUser | [user_user_deleteUser_test.dart](user/user_user_deleteUser_test.dart) | ✅ |
| /user/feedback/save | [user_feedback_save_test.dart](user/user_feedback_save_test.dart) | ✅ |

### Balance（余额/明细）模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /user/balance/getUserBalanceRecords | [user_balance_getUserBalanceRecords_test.dart](user/user_balance_getUserBalanceRecords_test.dart) | ✅ |

### 关注模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /user/follow/getFollowCount | [user_follow_getFollowCount_test.dart](user/user_follow_getFollowCount_test.dart) | ✅ |
| /user/follow/getFollowList | [user_follow_getFollowList_test.dart](user/user_follow_getFollowList_test.dart) | ✅ |
| /user/follow/getFollowListV2 | [user_follow_getFollowListV2_test.dart](user/user_follow_getFollowListV2_test.dart) | ✅ |

### 黑名单模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /user/blacklist/getBlackList | [user_blacklist_getBlackList_test.dart](user/user_blacklist_getBlackList_test.dart) | ✅ |

### 喜欢模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /user/like/getLikeList | [user_like_getLikeList_test.dart](user/user_like_getLikeList_test.dart) | ✅ |

### 消息模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /user/msg/getMsgRecords | [user_msg_getMsgRecords_test.dart](user/user_msg_getMsgRecords_test.dart) | ✅ |

### 动态模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /user/anchorMoment/publish | [user_anchorMoment_publish_test.dart](user/user_anchorMoment_publish_test.dart) | ❌ |
| /user/anchorMoment/getOneMoment | [user_anchorMoment_getOneMoment_test.dart](user/user_anchorMoment_getOneMoment_test.dart) | ✅ |
| /user/anchorMoment/hasNewFollowMoment | [user_anchorMoment_hasNewFollowMoment_test.dart](user/user_anchorMoment_hasNewFollowMoment_test.dart) | ✅ |
| /user/anchorMoment/anchorGetOtherMoment | [user_anchorMoment_anchorGetOtherMoment_test.dart](user/user_anchorMoment_anchorGetOtherMoment_test.dart) | ❌ |
| /user/anchorMoment/userGetMoment | [user_anchorMoment_userGetMoment_test.dart](user/user_anchorMoment_userGetMoment_test.dart) | ❌ |
| /user/anchorMoment/getComments | [user_anchorMoment_getComments_test.dart](user/user_anchorMoment_getComments_test.dart) | ❌ |

### 心动等级模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /user/heartbeatLevel/getLevelInfoConfigs | [user_heartbeatLevel_getLevelInfoConfigs_test.dart](user/user_heartbeatLevel_getLevelInfoConfigs_test.dart) | ✅ |
| /user/heartbeatLevel/getRuleList | [user_heartbeatLevel_getRuleList_test.dart](user/user_heartbeatLevel_getRuleList_test.dart) | ❌ |
| /user/heartbeatLevel/getConfig | [user_heartbeatLevel_getConfig_test.dart](user/user_heartbeatLevel_getConfig_test.dart) | ✅ |
| /user/heartbeatLevel/getFixHeartbeatAnchors | [user_heartbeatLevel_getFixHeartbeatAnchors_test.dart](user/user_heartbeatLevel_getFixHeartbeatAnchors_test.dart) | ✅ |
| /user/heartbeatLevel/getHeartbeatList | [user_heartbeatLevel_getHeartbeatList_test.dart](user/user_heartbeatLevel_getHeartbeatList_test.dart) | ✅ |
| /user/heartbeatLevel/batchGetHeartbeatValues | [user_heartbeatLevel_batchGetHeartbeatValues_test.dart](user/user_heartbeatLevel_batchGetHeartbeatValues_test.dart) | ❌ |

### 礼物模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /user/gift/getGiftList | [user_gift_getGiftList_test.dart](user/user_gift_getGiftList_test.dart) | ✅ |
| /user/gift/getAllGifts | [user_gift_getAllGifts_test.dart](user/user_gift_getAllGifts_test.dart) | ✅ |
| /user/gift/getOne | [user_gift_getOne_test.dart](user/user_gift_getOne_test.dart) | ✅ |
| /user/gift/getActions | [user_gift_getActions_test.dart](user/user_gift_getActions_test.dart) | ✅ |
| /user/gift/getGiftShows | [user_gift_getGiftShows_test.dart](user/user_gift_getGiftShows_test.dart) | ✅ |
| /user/gift/getAnchorGiftShows | [user_gift_getAnchorGiftShows_test.dart](user/user_gift_getAnchorGiftShows_test.dart) | ✅ |
| /user/gift/getGiftRank | [user_gift_getGiftRank_test.dart](user/user_gift_getGiftRank_test.dart) | ✅ |
| /user/anchor/getLiveGiftShowFlag | [user_anchor_getLiveGiftShowFlag_test.dart](user/user_anchor_getLiveGiftShowFlag_test.dart) | ✅ |
| /user/gift/getTrialReachGifts | [user_gift_getTrialReachGifts_test.dart](user/user_gift_getTrialReachGifts_test.dart) | ✅ |
| /user/gift/getLuckyGifts | [user_gift_getLuckyGifts_test.dart](user/user_gift_getLuckyGifts_test.dart) | ✅ |

### 主播模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /anchor/list | [anchor_list_test.dart](user/anchor_list_test.dart) | ❌ |
| /anchor/detail | [anchor_detail_test.dart](user/anchor_detail_test.dart) | ❌ |

## 系统模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /system/app/getConfig | [system_app_getConfig_test.dart](system/system_app_getConfig_test.dart) | ✅ |
| /system/app/getTranslatesV2 | [system_app_getTranslatesV2_test.dart](system/system_app_getTranslatesV2_test.dart) | ✅ |
| /system/country/getAreas | [system_country_getAreas_test.dart](system/system_country_getAreas_test.dart) | ✅ |
| /system/ai/getAiConfigs | [system_ai_getAiConfigs_test.dart](system/system_ai_getAiConfigs_test.dart) | ✅ |
| /system/bank/getPayoutChannels | [system_bank_getPayoutChannels_test.dart](system/system_bank_getPayoutChannels_test.dart) | ✅ |
| /system/app/getTagConfigs | [system_app_getTagConfigs_test.dart](system/system_app_getTagConfigs_test.dart) | ✅ |
| /system/app/getAdvertisement | [system_app_getAdvertisement_test.dart](system/system_app_getAdvertisement_test.dart) | ✅ |
| /system/app/checkRegion | [system_app_checkRegion_test.dart](system/system_app_checkRegion_test.dart) | ✅ |
| /system/ai/getAigConfigs | [system_ai_getAigConfigs_test.dart](system/system_ai_getAigConfigs_test.dart) | ✅ |
| /system/sensitive/getSensitiveWordsV2 | [system_sensitive_getSensitiveWordsV2_test.dart](system/system_sensitive_getSensitiveWordsV2_test.dart) | ✅ |
| /system/aiHelp/getConfigList | [system_aiHelp_getConfigList_test.dart](system/system_aiHelp_getConfigList_test.dart) | ✅ |

### Topia模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /topia/listTopicTag | [topia_listTopicTag_test.dart](system/topia_listTopicTag_test.dart) | ❌ |
| /topia/pageTopic | [topia_pageTopic_test.dart](system/topia_pageTopic_test.dart) | ❌ |

### 直播间模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /live/room/getList | [live_room_getList_test.dart](system/live_room_getList_test.dart) | ❌ |
| /live/room/getDetail | [live_room_getDetail_test.dart](system/live_room_getDetail_test.dart) | ✅ |
| /live/room/getTopUsers | [live_room_getTopUsers_test.dart](system/live_room_getTopUsers_test.dart) | ✅ |

## 商品/支付模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /p/product/getProducts | [p_product_getProducts_test.dart](product/p_product_getProducts_test.dart) | ✅ |
| /p/product/getCountryProduct | [p_product_getCountryProduct_test.dart](product/p_product_getCountryProduct_test.dart) | ✅ |
| /p/product/getProductCodes | [p_product_getProductCodes_test.dart](product/p_product_getProductCodes_test.dart) | ✅ |
| /p/product/getProductsWithCoupon | [p_product_getProductsWithCoupon_test.dart](product/p_product_getProductsWithCoupon_test.dart) | ✅ |
| /p/exchangeStore/getStores | [p_exchangeStore_getStores_test.dart](product/p_exchangeStore_getStores_test.dart) | ✅ |
| /p/downgrade/getConfig | [p_downgrade_getConfig_test.dart](product/p_downgrade_getConfig_test.dart) | ✅ |

### 订单/优惠券

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /p/order/getOrderList | [p_order_getOrderList_test.dart](product/p_order_getOrderList_test.dart) | ❌ |
| /p/order/getSplitOrder | [p_order_getSplitOrder_test.dart](product/p_order_getSplitOrder_test.dart) | ✅ |
| /p/order/getOrderSimpleList | [p_order_getOrderSimpleList_test.dart](product/p_order_getOrderSimpleList_test.dart) | ❌ |
| /p/coupon/getNewCoupon | [p_coupon_getNewCoupon_test.dart](product/p_coupon_getNewCoupon_test.dart) | ❌ |
| /p/coupon/getUserCoupons | [p_coupon_getUserCoupons_test.dart](product/p_coupon_getUserCoupons_test.dart) | ✅ |

## 通话模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /call/call/getCallRecordVoList | [call_call_getCallRecordVoList_test.dart](call/call_call_getCallRecordVoList_test.dart) | ✅ |
| /call/violate/getConfig | [call_violate_getConfig_test.dart](call/call_violate_getConfig_test.dart) | ✅ |
| /call/hangup/getConfigs | [call_hangup_getConfigs_test.dart](call/call_hangup_getConfigs_test.dart) | ✅ |
| /call/call/getFreeInviteCallInfo | [call_call_getFreeInviteCallInfo_test.dart](call/call_call_getFreeInviteCallInfo_test.dart) | ✅ |

## 礼物模块

| 接口路径 | 文件 | 状态 |
|---------|------|------|
| /gift/list | [gift_list_test.dart](gift/gift_list_test.dart) | ❌ |

## 失败接口汇总

| 接口路径 | 错误码 | 错误信息 |
|---------|--------|---------|
| /user/info | None | 无响应 |
| /category/list | None | 无响应 |
| /gift/list | None | 无响应 |
| /p/order/getOrderList | 1001 | 系统错误 |
| /p/coupon/getNewCoupon | None | 无响应 |
| /p/order/getOrderSimpleList | 1006 | 参数错误 |
| /user/anchorMoment/publish | 1006 | 参数错误 |
| /anchor/list | None | 无响应 |
| /anchor/detail | None | 无响应 |
| /user/anchorMoment/anchorGetOtherMoment | 1001 | 系统错误 |
| /user/anchorMoment/userGetMoment | 1001 | 系统错误 |
| /user/anchorMoment/getComments | 1001 | 系统错误 |
| /topia/listTopicTag | None | 无响应 |
| /topia/pageTopic | None | 无响应 |
| /user/heartbeatLevel/getRuleList | None | 无响应 |
| /user/heartbeatLevel/batchGetHeartbeatValues | 1001 | 系统错误 |
| /live/room/getList | 1006 | 参数错误 |
