/// 全局静态配置
class AuvConfig {
  static const String appName = 'SleaAUV';
  static const String appVersion = '1.0.0';
  
  // API 配置
  static const String baseUrl = 'https://testapi.selalive.com';
  
  // Debug 模式配置
  static const bool debugMode = true;
  static const String debugDeviceId = 'd89793035d98c48f-Xiaomi';
  static const String debugUserAgent = 'sela,3.0.8,android Mi Note 3,9,sela100,40';
  static const String debugAuth = 'DSTEST-eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxMDIwODk4MiIsInN1YiI6IjEwMjA4OTgyIiwiaWF0IjoxNzc0NTEwMDcxLCJpc3MiOiJzZWxhIiwidXNlciI6IntcImFwcENoYW5uZWxcIjpcInNlbGExMDBcIixcImFwcE5hbWVcIjpcInNlbGFcIixcImNvdW50cnlDb2RlXCI6ODQwLFwiY3JlYXRlZEF0XCI6MTc3NDUxMDA3MTcyMCxcImRldmljZUlkXCI6XCJkODk3OTMwMzVkOThjNDhmLVhpYW9taVwiLFwibG9naW5UaW1lXCI6MTc3NDUxMDA3MTgwOCxcIm9wZW5JZFwiOlwiejc0NDQ0ODc1NVwiLFwicmVnaXN0ZXJGbGFnXCI6dHJ1ZSxcInR5cGVcIjowLFwidXNlcklkXCI6MTAyMDg5ODIsXCJ1c2VybmFtZVwiOlwiMTAyMDg5ODJcIn0ifQ.zf-DGsTg29bgvszLM62ZdndTXIDA3Q5CHiRij41lYKw0dovjurKc82seI2KML_0Nhp_6ehoxj11ePsxgXbBx2Q';
  
  // 存储 Keys
  static const String tokenKey = 'auth_token';
  static const String userInfoKey = 'user_info';
  static const String isVisitorKey = 'is_visitor';

  // 翻译文案存储 Keys
  static const String translateDataKey = 'translate_data';
  static const String translateVersionKey = 'translate_version';


  // curl --request GET \
  // --url 'https://testapi.selalive.com/user/user/getUserExpand?userId=10163057' \
  // --header 'Accept: */*' \
  // --header 'Accept-Encoding: gzip, deflate, br' \
  // --header 'Connection: keep-alive' \
  // --header 'authorization: DSTEST-eyJhbGciOiJIUzUxMiJ9.eyJqdGkiOiIxMDIwODk4MiIsInN1YiI6IjEwMjA4OTgyIiwiaWF0IjoxNzc0NTEwMDcxLCJpc3MiOiJzZWxhIiwidXNlciI6IntcImFwcENoYW5uZWxcIjpcInNlbGExMDBcIixcImFwcE5hbWVcIjpcInNlbGFcIixcImNvdW50cnlDb2RlXCI6ODQwLFwiY3JlYXRlZEF0XCI6MTc3NDUxMDA3MTcyMCxcImRldmljZUlkXCI6XCJkODk3OTMwMzVkOThjNDhmLVhpYW9taVwiLFwibG9naW5UaW1lXCI6MTc3NDUxMDA3MTgwOCxcIm9wZW5JZFwiOlwiejc0NDQ0ODc1NVwiLFwicmVnaXN0ZXJGbGFnXCI6dHJ1ZSxcInR5cGVcIjowLFwidXNlcklkXCI6MTAyMDg5ODIsXCJ1c2VybmFtZVwiOlwiMTAyMDg5ODJcIn0ifQ.zf-DGsTg29bgvszLM62ZdndTXIDA3Q5CHiRij41lYKw0dovjurKc82seI2KML_0Nhp_6ehoxj11ePsxgXbBx2Q' \
  // --header 'content-type: application/json; charset=utf-8' \
  // --header 'device-id: d89793035d98c48f-Xiaomi' \
  // --header 'user-agent: sela,3.0.8,android Mi Note 3,9,sela100,40' \
  // --header 'user-language: zh'
}
