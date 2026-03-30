import 'package:get/get.dart';
import 'package:slea_auv/app/modules/home/auv_home_logic.dart';

class AuvHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuvHomeLogic>(() => AuvHomeLogic());
  }
}
