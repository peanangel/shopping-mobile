// import 'package:get/get.dart';
// import 'package:shopping/app/data/product_model.dart';
// import 'package:shopping/app/service/base_service.dart';
// import 'package:shopping/app/service/cart_service.dart';
// class CartPageController extends GetxController {
//   RxList<ProductModel> cartItems = <ProductModel>[].obs;
//   final double shippingCost = 5.99;
//   final isLoading = false.obs;
//   final BaseService _baseService = Get.find<BaseService>();
//   final CartService _cartService = Get.find<CartService>();
//   late RxBool chkUpdate;

//   @override
//   void onInit() {
//     super.onInit();

//     loadCartItems();
//     print("-======-");
//     cartItems.refresh();
//   }

//   int get selectedItemCount =>
//       cartItems.where((item) => item.isSelected.value).length;

//   double get selectedSubtotal {
//     return cartItems
//         .where((item) => item.isSelected.value)
//         .fold(0, (sum, item) => sum + (item.price * item.quantity.value));
//   }

//   double get selectedTotal =>
//       selectedSubtotal + (selectedItemCount > 0 ? shippingCost : 0);

//   void toggleItemSelection(int index) {
//     cartItems[index].isSelected.toggle();
//   }

//   void selectAll() {
//     for (var item in cartItems) {
//       item.isSelected.value = true;
//     }
//   }

//   void unselectAll() {
//     for (var item in cartItems) {
//       item.isSelected.value = false;
//     }
//   }

//   // Method to load cart items asynchronously
//   Future<void> loadCartItems() async {
//     isLoading.value = true;
//     try {
//       final items = await _cartService.getCartItems();
//       cartItems.assignAll(items); // Assign the fetched items to cartItems

//       print("-======- Cart items loaded");
//       print(cartItems[0]);
//     } catch (e) {
//       print("Error loading cart items: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<String> decrementProduct(cid) async {
//     final body = {"cid": cid};

//     try {
//       final response = await _baseService.patch(
//         endpoint: "/products/cart/decrease",
//         data: body,
//       );

//       if (response['message'] == 'Amount updated successfully') {
//         return 'Amount updated successfully';
//       } else if (response['message'] == 'Item deleted from cart') {
//         return 'Item deleted from cart';
//       } else {
//         return 'Failed';
//       }
//     } catch (e) {
//       print('Error: $e');
//       return 'Error';
//     }
//   }

//   Future<void> updateAmount(bool chk, pid, cid) async {
//     if (chk) {
//       cartItems = await _cartService.addToCart(pid);
//     } else {
//       cartItems = await _cartService.decrementProduct(cid);
//     }
//     cartItems.refresh();
//   }
// }

// CartPageController.dart fixes
import 'package:get/get.dart';
import 'package:shopping/app/data/product_model.dart';
import 'package:shopping/app/service/cart_service.dart';
import 'package:shopping/app/widgets/widget.dart';

class CartPageController extends GetxController {
  RxList<ProductModel> cartItems = <ProductModel>[].obs;
  final double shippingCost = 5.99;
  final isLoading = false.obs;
  final CartService _cartService = Get.find<CartService>();

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
    cartItems.refresh();
  }

  int get selectedItemCount =>
      cartItems.where((item) => item.isSelected.value).length;

  double get selectedSubtotal {
    return cartItems
        .where((item) => item.isSelected.value)
        .fold(0, (sum, item) => sum + (item.price * item.quantity.value));
  }

  double get selectedTotal =>
      selectedSubtotal + (selectedItemCount > 0 ? shippingCost : 0);

  void toggleItemSelection(int index) {
    cartItems[index].isSelected.toggle();
  }

  void selectAll() {
    for (var item in cartItems) {
      item.isSelected.value = true;
    }
  }

  void unselectAll() {
    for (var item in cartItems) {
      item.isSelected.value = false;
    }
  }

  // Method to load cart items asynchronously
  Future<void> loadCartItems() async {
    isLoading.value = true;
    try {
      final items = await _cartService.getCartItems();
      cartItems.assignAll(items);
    } catch (e) {
      print("Error loading cart items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Remove item from cart
  // Future<void> removeItem(int index) async {
  //   final item = cartItems[index];
  //   if (item.cid != null) {
  //     cartItems.value = await _cartService.removeItem(item.cid!);
  //   }
  // }

  // Clear all items from cart
  Future<void> clearCart() async {
    cartItems.value = await _cartService.clearCart();
  }

  // Increment quantity
  Future<void> incrementQuantity(int index) async {
    final item = cartItems[index];
    if (item.pid != null) {
      cartItems.value = await _cartService.addToCart(item.pid.toString());
    }
  }

  // Decrement quantity
  // Future<void> decrementQuantity(int index) async {
  //   final item = cartItems[index];
  //   if (item.cid != null) {
  //     cartItems.value = await _cartService.decrementProduct(item.cid);

  //   }

  // }

  // Proceed to checkout
  void proceedToCheckout() {
    List<ProductModel> selectedItems =
        cartItems.where((item) => item.isSelected.value).toList();

    if (selectedItems.isNotEmpty) {
      // Navigate to checkout page with selected items
      Get.toNamed(
        '/checkout',
        arguments: {
          'items': selectedItems,
          'subtotal': selectedSubtotal,
          'shipping': shippingCost,
          'total': selectedTotal,
        },
      );
    }
  }

  // Decrement quantity
  // Future<void> decrementQuantity(int index) async {
  //   final item = cartItems[index];
  //   if (item.cid != null) {
  //     if (item.quantity <= 1) {
  //       // When quantity is 1 or less, remove the item from cart
  //       isLoading.value = true;
  //       try {
  //         // Remove the item completely - this depends on your API/service implementation
  //         cartItems.value = await _cartService.removeFromCart(item.cid);
  //         showMessage('Item removed from cart');
  //       } catch (e) {
  //         print('Error removing from cart: $e');
  //         showMessage('Failed to remove item', isError: true);
  //       } finally {
  //         isLoading.value = false;
  //       }
  //     } else {
  //       // Normal decrement operation
  //       cartItems.value = await _cartService.decrementProduct(item.cid);
  //     }
  //   }
  // }

  // Decrement quantity
  // Decrement quantity
  Future<void> decrementQuantity(int index) async {
    final item = cartItems[index];
    if (item.cid != null) {
      isLoading.value = true;
      try {
        if (item.quantity <= 1) {
          // Just call the void method without assigning its result
          await _cartService.removeFromCart(item.cid);
        } else {
          // Just call the void method without assigning its result
          await _cartService.decrementProduct(item.cid);
        }

        // Then fetch the updated cart items separately
        cartItems.value = await _cartService.getCartItems();
      } catch (e) {
        print('Error updating cart: $e');
        showMessage('Failed to update cart', isError: true);
      } finally {
        isLoading.value = false;
      }
    }
  }
}
