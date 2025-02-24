import 'package:get/get.dart';

import '../controllers/product_detail_page_controller.dart';

class ProductDetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailPageController>(
      () => ProductDetailPageController(),
    );
  }
}
