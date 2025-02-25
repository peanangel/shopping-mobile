// import 'package:get/get.dart';
// import 'package:shopping/app/data/product_model.dart';
// import 'package:shopping/app/service/base_service.dart';
// import 'package:shopping/app/service/user_preferences.dart';
// import 'package:shopping/app/widgets/widget.dart';

// class CartService {
//   final BaseService _baseService = Get.find<BaseService>();

//  Future<List<ProductModel>> addToCart(pid) async {
//     final userref = await UserPreferences().getUser();
//     final body = {"uid": userref?.uid, "pid": pid};

//     try {
//       final response = await _baseService.post(
//         endpoint: "/products/cart",
//         data: body,
//       );

//       if (response['message'] == 'Product added to cart successfully' ||
//           response['message'] == 'Amount updated successfully') {
//         showMessage('added successfully!');
//         return getCartItems();
//       } else {
//         showMessage('Failed to add Todo. Please try again.', isError: true);
//       }
//     } catch (e) {
//       showMessage(
//         'An error occurred. Please check your connection.',
//         isError: true,
//       );
//       print('Error: $e');
//     } finally {
//       // Ensure Get.back() is called after everything is done
//     }
//   }

//   // Get cart items for a user
//   Future<List<ProductModel>> getCartItems() async {
//     final userref = await UserPreferences().getUser();
//     if (userref?.uid == null) {
//       return [];
//     }

//     try {
//       final response = await _baseService.get(
//         endpoint: "/cart/${userref?.uid}",
//       );

//       if (response['message'] == 'successful' && response['list'] != null) {
//         return (response['list'] as List)
//             .map((item) => ProductModel.fromJson(item))
//             .toList();
//       }
//       return [];
//     } catch (e) {
//       print('Error loading cart data: $e');
//       return [];
//     }
//   }

//   // Method to handle product quantity decrement via API call
//   Future<List<ProductModel>> decrementProduct(int cid) async {
//     final body = {"cid": cid};

//     try {
//       final response = await _baseService.patch(
//         endpoint: "/products/cart/decrease",
//         data: body,
//       );

//       if (response['message'] == 'Amount updated successfully') {
//         // Handle success if necessary

//         return getCartItems();
//       } else {
//         throw Exception('Failed to update quantity');
//       }
//     } catch (e) {
//       print('Error decrementing product quantity: $e');
//       rethrow;
//     }
//   }
// }

// CartService.dart fixes
import 'package:get/get.dart';
import 'package:shopping/app/data/product_model.dart';
import 'package:shopping/app/service/base_service.dart';
import 'package:shopping/app/service/user_preferences.dart';
import 'package:shopping/app/widgets/widget.dart';

class CartService {
  final BaseService _baseService = Get.find<BaseService>();

  Future<List<ProductModel>> addToCart(pid) async {
    final userref = await UserPreferences().getUser();
    if (userref?.uid == null) {
      showMessage('User not logged in', isError: true);
      return [];
    }

    final body = {"uid": userref?.uid, "pid": pid};

    try {
      final response = await _baseService.post(
        endpoint: "/products/cart",
        data: body,
      );

      if (response['message'] == 'Product added to cart successfully' ||
          response['message'] == 'Amount updated successfully') {
        showMessage('Added successfully!');
        return getCartItems();
      } else {
        showMessage('Failed to add item. Please try again.', isError: true);
        return getCartItems(); // Return current cart items
      }
    } catch (e) {
      showMessage(
        'An error occurred. Please check your connection.',
        isError: true,
      );
      print('Error: $e');
      return getCartItems(); // Return current cart items even on error
    }
  }

  // Get cart items for a user
  Future<List<ProductModel>> getCartItems() async {
    final userref = await UserPreferences().getUser();
    if (userref?.uid == null) {
      return [];
    }

    try {
      final response = await _baseService.get(
        endpoint: "/cart/${userref?.uid}",
      );

      if (response['message'] == 'successful' && response['list'] != null) {
        return (response['list'] as List)
            .map((item) => ProductModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      print('Error loading cart data: $e');
      return [];
    }
  }

  // Method to handle product quantity decrement via API call
  Future<List<ProductModel>> decrementProduct(int cid) async {
    final body = {"cid": cid};

    try {
      final response = await _baseService.patch(
        endpoint: "/products/cart/decrease",
        data: body,
      );

      if (response['message'] == 'Amount updated successfully' ||
          response['message'] == 'Item deleted from cart') {
        // Handle success if necessary
        showMessage(response['message']);
        return getCartItems();
      } else {
        showMessage('Failed to update quantity', isError: true);
        return getCartItems(); // Return current cart items
      }
    } catch (e) {
      print('Error decrementing product quantity: $e');
      showMessage('Error updating cart', isError: true);
      return getCartItems(); // Return current cart items even on error
    }
  }

  // Method to remove item from cart
  // Future<List<ProductModel>> removeItem(int cid) async {
  //   final body = {"cid": cid};

  //   try {
  //     final response = await _baseService.delete(
  //       endpoint: "/products/cart",
  //       data: body,
  //     );

  //     if (response['message'] == 'Item deleted from cart') {
  //       showMessage('Item removed from cart');
  //       return getCartItems();
  //     } else {
  //       showMessage('Failed to remove item', isError: true);
  //       return getCartItems();
  //     }
  //   } catch (e) {
  //     print('Error removing item: $e');
  //     showMessage('Error removing item', isError: true);
  //     return getCartItems();
  //   }
  // }

  // Method to clear cart
  Future<List<ProductModel>> clearCart() async {
    final userref = await UserPreferences().getUser();
    if (userref?.uid == null) {
      return [];
    }

    try {
      final response = await _baseService.delete(
        endpoint: "/cart/clear/${userref?.uid}",
      );

      if (response['message'] == 'Cart cleared successfully') {
        showMessage('Cart cleared');
        return [];
      } else {
        showMessage('Failed to clear cart', isError: true);
        return getCartItems();
      }
    } catch (e) {
      print('Error clearing cart: $e');
      showMessage('Error clearing cart', isError: true);
      return getCartItems();
    }
  }

  Future<void> removeFromCart( cid) async {
    try {
      final response = await _baseService.delete(endpoint: "/$cid");

      if (response['message'] == 'Delete success') {
        showMessage("delete data");
      } else {
        print(response);
      }
    } catch (e) {}
  }
}
