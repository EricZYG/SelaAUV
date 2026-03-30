import 'package:get/get.dart';
import 'package:slea_auv/app/modules/splash/auv_splash_logic.dart';

class AuvSplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuvSplashLogic>(() => AuvSplashLogic());
  }
}
