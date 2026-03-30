import 'package:get/get.dart';
import 'package:slea_auv/app/routes/auv_routes.dart';
import 'package:slea_auv/app/modules/splash/auv_splash_binding.dart';
import 'package:slea_auv/app/modules/splash/auv_splash_page.dart';
import 'package:slea_auv/app/modules/login/auv_login_binding.dart';
import 'package:slea_auv/app/modules/login/auv_login_page.dart';
import 'package:slea_auv/app/modules/home/auv_home_binding.dart';
import 'package:slea_auv/app/modules/home/auv_home_page.dart';

/// 应用页面路由配置
class AuvPages {
  static const initial = AuvRoutes.splash;

  static final routes = [
    GetPage(
      name: AuvRoutes.splash,
      page: () => const AuvSplashPage(),
      binding: AuvSplashBinding(),
    ),
    GetPage(
      name: AuvRoutes.login,
      page: () => const AuvLoginPage(),
      binding: AuvLoginBinding(),
    ),
    GetPage(
      name: AuvRoutes.home,
      page: () => const AuvHomePage(),
      binding: AuvHomeBinding(),
    ),
  ];
}
