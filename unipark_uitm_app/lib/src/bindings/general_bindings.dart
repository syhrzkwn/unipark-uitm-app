import 'package:get/get.dart';
import 'package:unipark_uitm_app/src/utils/helpers/network_manager.dart';

class GeneralBindings extends Bindings {

  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}