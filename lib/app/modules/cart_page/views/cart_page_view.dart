// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/cart_page_controller.dart';

// class CartPageView extends GetView<CartPageController> {
//   const CartPageView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Shopping Cart', style: theme.textTheme.titleLarge),
//         centerTitle: true,
//         actions: [
//           PopupMenuButton(
//             icon: const Icon(Icons.more_vert),
//             itemBuilder:
//                 (context) => [
//                   PopupMenuItem(
//                     onTap: controller.selectAll,
//                     child: const Text('Select All'),
//                   ),
//                   PopupMenuItem(
//                     onTap: controller.unselectAll,
//                     child: const Text('Unselect All'),
//                   ),
//                   PopupMenuItem(
//                     // onTap: controller.clearCart,
//                     child: const Text('Clear Cart'),
//                   ),
//                 ],
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.cartItems.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.shopping_cart_outlined,
//                   size: 64,
//                   color: theme.primaryColor.withOpacity(0.5),
//                 ),
//                 const SizedBox(height: 16),
//                 Text('Your cart is empty', style: theme.textTheme.titleMedium),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () => Get.back(),
//                   child: const Text('Start Shopping'),
//                 ),
//               ],
//             ),
//           );
//         }

//         return Column(
//           children: [
//             Expanded(
//               child: ListView.separated(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: controller.cartItems.length,
//                 separatorBuilder:
//                     (context, index) => const SizedBox(height: 16),
//                 itemBuilder: (context, index) {
//                   final item = controller.cartItems[index];
//                   return Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.05),
//                           blurRadius: 10,
//                           offset: const Offset(0, 5),
//                         ),
//                       ],
//                     ),
//                     child: Dismissible(
//                       key: Key(item.id.toString()),
//                       direction: DismissDirection.endToStart,
//                       background: Container(
//                         alignment: Alignment.centerRight,
//                         padding: const EdgeInsets.only(right: 20),
//                         decoration: BoxDecoration(
//                           color: theme.colorScheme.error,
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: const Icon(
//                           Icons.delete_outline,
//                           color: Colors.white,
//                         ),
//                       ),

//                       // onDismissed: (direction) => controller.removeItem(index),
//                       child: Padding(
//                         padding: const EdgeInsets.all(12),
//                         child: Row(
//                           children: [
//                             // Checkbox
//                             Obx(
//                               () => Checkbox(
//                                 value: item.isSelected.value,
//                                 onChanged:
//                                     (value) =>
//                                         controller.toggleItemSelection(index),
//                                 activeColor: theme.primaryColor,
//                               ),
//                             ),
//                             // Product Image
//                             ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.network(
//                                 item.imageUrl,
//                                 width: 80,
//                                 height: 80,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             const SizedBox(width: 16),
//                             // Product Details
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     item.name,
//                                     style: theme.textTheme.titleMedium
//                                         ?.copyWith(fontWeight: FontWeight.bold),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     '\$${item.price.toStringAsFixed(2)}',
//                                     style: TextStyle(
//                                       color: theme.primaryColor,
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             // Quantity Controls
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: theme.primaryColor.withOpacity(0.1),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Row(
//                                 children: [
//                                   IconButton(
//                                     icon: const Icon(Icons.remove),
//                                     onPressed:
//                                         () => controller.chkUpdate = false.obs,
//                                     // onPressed: (){},
//                                     color: theme.primaryColor,
//                                   ),
//                                   Obx(
//                                     () => Text(
//                                       item.quantity.toString(),
//                                       style: TextStyle(
//                                         color: theme.primaryColor,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   IconButton(
//                                     icon: const Icon(Icons.add),
//                                     onPressed:
//                                         () => controller.chkUpdate = true.obs,
//                                     color: theme.primaryColor,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             // Cart Summary
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, -5),
//                   ),
//                 ],
//               ),
//               child: SafeArea(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Selected Items',
//                           style: theme.textTheme.titleMedium,
//                         ),
//                         Obx(
//                           () => Text(
//                             controller.selectedItemCount.toString(),
//                             style: theme.textTheme.titleMedium?.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Subtotal', style: theme.textTheme.titleMedium),
//                         Obx(
//                           () => Text(
//                             '\$${controller.selectedSubtotal.toStringAsFixed(2)}',
//                             style: theme.textTheme.titleMedium?.copyWith(
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Shipping', style: theme.textTheme.titleMedium),
//                         Text(
//                           '\$${controller.shippingCost.toStringAsFixed(2)}',
//                           style: theme.textTheme.titleMedium?.copyWith(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 8),
//                       child: Divider(),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Total', style: theme.textTheme.titleLarge),
//                         Obx(
//                           () => Text(
//                             '\$${controller.selectedTotal.toStringAsFixed(2)}',
//                             style: theme.textTheme.titleLarge?.copyWith(
//                               color: theme.primaryColor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     SizedBox(
//                       width: double.infinity,
//                       child: Obx(
//                         () => ElevatedButton(
//                           onPressed:
//                               controller.selectedItemCount > 0
//                                   ? () {
//                                     // Proceed to checkout with selected items
//                                   }
//                                   : null,
//                           style: ElevatedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(vertical: 16),
//                           ),
//                           child: Text(
//                             controller.selectedItemCount > 0
//                                 ? 'Checkout (${controller.selectedItemCount} items)'
//                                 : 'Select items to checkout',
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

// CartPageView.dart fixes
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/app/routes/app_pages.dart';
import '../controllers/cart_page_controller.dart';

class CartPageView extends GetView<CartPageController> {
  const CartPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart', style: theme.textTheme.titleLarge),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    onTap: controller.selectAll,
                    child: const Text('Select All'),
                  ),
                  PopupMenuItem(
                    onTap: controller.unselectAll,
                    child: const Text('Unselect All'),
                  ),
                  PopupMenuItem(
                    onTap: controller.clearCart,
                    child: const Text('Clear Cart'),
                  ),
                ],
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 64,
                  color: theme.primaryColor.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Text('Your cart is empty', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => Get.to(Routes.HOME),
                  child: const Text('Start Shopping'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.cartItems.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final item = controller.cartItems[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Dismissible(
                      key: Key(item.id.toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                        ),
                      ),
                      // onDismissed: (direction) => controller.removeItem(index),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            // Checkbox
                            Obx(
                              () => Checkbox(
                                value: item.isSelected.value,
                                onChanged:
                                    (value) =>
                                        controller.toggleItemSelection(index),
                                activeColor: theme.primaryColor,
                              ),
                            ),
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                item.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey.shade200,
                                      child: const Icon(
                                        Icons.image_not_supported,
                                      ),
                                    ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${item.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: theme.primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Quantity Controls
                            Container(
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.remove),
                                    color: theme.primaryColor,
                                    onPressed: () {
                                      final item = controller.cartItems[index];
                                      if (item.quantity <= 1) {
                                        // Show confirmation dialog when quantity is 1
                                        _showRemoveItemDialog(
                                          context,
                                          index,
                                          item.productName,
                                        );
                                      } else {
                                        // Directly decrement if quantity is greater than 1
                                        controller.decrementQuantity(index);
                                      }
                                    },
                                  ),
                                  Obx(
                                    () => Text(
                                      '${item.quantity.value}',
                                      style: TextStyle(
                                        color: theme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add),
                                    onPressed:
                                        () =>
                                            controller.incrementQuantity(index),
                                    color: theme.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Cart Summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selected Items',
                          style: theme.textTheme.titleMedium,
                        ),
                        Obx(
                          () => Text(
                            controller.selectedItemCount.toString(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal', style: theme.textTheme.titleMedium),
                        Obx(
                          () => Text(
                            '\$${controller.selectedSubtotal.toStringAsFixed(2)}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Shipping', style: theme.textTheme.titleMedium),
                        Text(
                          '\$${controller.shippingCost.toStringAsFixed(2)}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: theme.textTheme.titleLarge),
                        Obx(
                          () => Text(
                            '\$${controller.selectedTotal.toStringAsFixed(2)}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                        () => ElevatedButton(
                          onPressed:
                              controller.selectedItemCount > 0
                                  ? controller.proceedToCheckout
                                  : null,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: Text(
                            controller.selectedItemCount > 0
                                ? 'Checkout (${controller.selectedItemCount} items)'
                                : 'Select items to checkout',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // In your cart view page
  Future<void> _showRemoveItemDialog(context, index, itemName) async {
    final ThemeData theme = Theme.of(context);

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                  size: 48,
                ),
                const SizedBox(height: 16),
                Text(
                  'Remove Item',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Are you sure you want to remove "$itemName" from your cart?',
                  style: theme.textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(color: theme.primaryColor),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: theme.primaryColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                          controller.decrementQuantity(index);
                        },
                        child: const Text(
                          'Remove',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
