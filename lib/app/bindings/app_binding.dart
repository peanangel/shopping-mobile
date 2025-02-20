import 'package:get/get.dart';
import 'package:shopping/app/controllers/app_controller.dart';
import 'package:shopping/app/modules/cart_page/controllers/cart_page_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppController>(() => AppController());
    Get.lazyPut(()=>CartPageController());
  }
}
