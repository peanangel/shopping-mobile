import 'package:get/get.dart';
import 'package:shopping/app/data/product_model.dart';
import 'package:shopping/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:shopping/app/service/cart_service.dart';

class ProductDetailPageController extends GetxController {
  //TODO: Implement ProductDetailPageController

  final CartService _cartService = Get.find<CartService>();
  final CartPageController _cartController = Get.find<CartPageController>();
  late final ProductModel product;
  @override
  void onInit() {
    super.onInit();
    product = Get.arguments ?? ProductModel;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }



  Future<void> addToCart(pid) async {
    try {
      final updatedCart = await _cartService.addToCart(pid);
      _cartController.cartItems.assignAll(updatedCart);
    } catch (e) {
      print("Error adding to cart: $e");
    }
  }
}
