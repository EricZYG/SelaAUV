import 'package:get/get.dart';
import 'package:slea_auv/app/modules/login/auv_login_logic.dart';

class AuvLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuvLoginLogic>(() => AuvLoginLogic());
  }
}
