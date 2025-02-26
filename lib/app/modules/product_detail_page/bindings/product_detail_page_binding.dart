import 'package:get/get.dart';
import 'package:shopping/app/modules/home/controllers/home_controller.dart';
import 'package:shopping/app/service/cart_service.dart';

import '../controllers/product_detail_page_controller.dart';

class ProductDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailPageController>(
      () => ProductDetailPageController(),
    );
    Get.lazyPut(()=>CartService());
    Get.put(HomeController());
    // Get.put(CartService());
  }
}
