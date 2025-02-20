import 'package:get/get.dart';

class CartItem {
  final int id;
  final String name;
  final String imageUrl;
  final double price;
  RxInt quantity;
  RxBool isSelected;

  CartItem({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required int quantity,
    bool isSelected = false,
  }) : 
    quantity = quantity.obs,
    isSelected = isSelected.obs;
}

class CartPageController extends GetxController {
  final RxList<CartItem> cartItems = <CartItem>[].obs;
  final double shippingCost = 5.99;

  @override
  void onInit() {
    super.onInit();
    // Add some example items
    cartItems.addAll([
      CartItem(
        id: 1,
        name: "Product 1",
        imageUrl: "https://i.pinimg.com/736x/4c/fe/41/4cfe41532b80ba0299594ff99f19ce21.jpg",
        price: 99.99,
        quantity: 1,
      ),
      CartItem(
        id: 2,
        name: "Product 2",
        imageUrl: "https://i.pinimg.com/736x/4c/fe/41/4cfe41532b80ba0299594ff99f19ce21.jpg",
        price: 149.99,
        quantity: 2,
      ),
    ]);
  }

  int get selectedItemCount => cartItems.where((item) => item.isSelected.value).length;

  double get selectedSubtotal {
    return cartItems
        .where((item) => item.isSelected.value)
        .fold(0, (sum, item) => sum + (item.price * item.quantity.value));
  }

  double get selectedTotal => selectedSubtotal + (selectedItemCount > 0 ? shippingCost : 0);

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

  void incrementQuantity(int index) {
    if (cartItems[index].quantity < 99) {
      cartItems[index].quantity++;
    }
  }

  void decrementQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    }
  }

  void removeItem(int index) {
    cartItems.removeAt(index);
  }

  void clearCart() {
    cartItems.clear();
  }
}