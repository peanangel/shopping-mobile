import 'package:get/get.dart';
import 'package:shopping/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:shopping/app/modules/product_detail_page/controllers/product_detail_page_controller.dart';
import 'package:shopping/app/service/cart_service.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut(() => ProductDetailPageController());
    // Get.put(ProductDetailPageController());
    Get.lazyPut<ProductDetailPageController>(
      () => ProductDetailPageController(),
    );
    Get.lazyPut(() => CartService());
    Get.put(CartPageController());
  }
}
