# API 测试脚本

SleaAUV项目API接口测试脚本，按模块组织，每个接口独立文件夹。

## 目录结构

```
lib/scripts/api_test/
├── README.md                    # 本文档
├── common/                      # 公共模块
│   ├── config.dart              # API配置、调试头
│   └── sign_util.dart           # 签名工具
├── auth/                        # 认证模块
│   ├── user_login_guest/        # 游客登录
│   ├── user_login_phone/        # 手机登录
│   ├── user_login_google/       # 谷歌登录
│   └── user_login_apple/         # 苹果登录
├── user/                        # 用户模块
│   ├── user_sign_signIn/        # 签到领奖励
│   ├── user_user_getUserDetail/ # 获取用户详情
│   └── ...
├── payment/                     # 支付模块
│   ├── p_order_createOrder/     # 创建订单（需签名）
│   ├── p_product_getProducts/   # 获取商品列表
│   └── ...
├── gift/                        # 送礼模块
│   ├── user_gift_sendReal/      # 赠送真实礼物（需签名）
│   └── user_gift_sendLucky/     # 赠送幸运礼物（需签名）
├── anchor/                      # 主播模块
├── msg/                         # 消息模块
├── call/                        # 通话模块
├── moment/                      # 动态模块
├── system/                      # 系统模块
│   └── system_app_getConfig/   # 获取应用配置（获取签名密钥）
├── charge/                      # 充值模块
└── match/                       # 匹配模块
```

## 使用方法

### 1. 安装依赖

```bash
dart pub add dio crypto
```

### 2. 修改配置

编辑 `common/config.dart` 中的调试配置：

```dart
class DebugConfig {
  static const bool debugMode = true;
  static const String deviceId = 'your_device_id';
  static const String userAgent = 'your_user_agent';
  static const String auth = 'your_auth_token';
}
```

### 3. 运行测试

```bash
# 测试获取应用配置（先获取签名密钥）
dart lib/scripts/api_test/system/system_app_getConfig/test.dart

# 测试签到接口
dart lib/scripts/api_test/user/user_sign_signIn/test.dart

# 测试下单接口
dart lib/scripts/api_test/payment/p_order_createOrder/test.dart
```

## 需要签名的接口

| 模块 | 接口 | 路径 | 说明 |
|------|------|------|------|
| 认证 | 游客登录 | `/user/login/guest` | 需签名 |
| 认证 | 手机登录 | `/user/login/phone` | 需签名 |
| 认证 | 谷歌登录 | `/user/login/google` | 需签名 |
| 认证 | 苹果登录 | `/user/login/apple` | 需签名 |
| 用户 | 签到领奖励 | `/user/sign/signIn` | 需签名 |
| 支付 | 充值（下单） | `/p/order/createOrder` | 需签名 |
| 送礼 | 赠送真实礼物 | `/user/gift/sendReal` | 需签名 |
| 送礼 | 赠送幸运礼物 | `/user/gift/sendLucky` | 需签名 |

## 签名规则

1. 将请求参数按照参数名ASCII码从小到大排序
2. 使用URL键值对格式拼接成字符串
3. 在末尾拼接 `time` 和 `key`
4. 对结果进行MD5运算，转小写得到sign

## 测试流程

1. **获取签名密钥**
   ```bash
   dart lib/scripts/api_test/system/system_app_getConfig/test.dart
   ```
   从输出中获取 `ok` 字段的值

2. **使用签名密钥测试其他接口**
   将获取的密钥填入需要签名的接口测试脚本中

## 接口文档

每个接口文件夹包含：
- `README.md` - 接口文档（请求参数、响应参数、示例）
- `test.dart` - 可独立运行的测试脚本

## 公共请求头

调试模式下会自动添加以下请求头：

```
Accept: */*
Accept-Encoding: gzip, deflate, br
Connection: keep-alive
authorization: {token}
content-type: application/json; charset=utf-8
device-id: {deviceId}
user-agent: {userAgent}
user-language: zh
```

需要签名的接口还需添加：
```
s-time: {timestamp}
s-sign: {signature}
```
