import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:shopping/app/modules/cart_page/views/cart_page_view.dart';
import 'package:shopping/app/modules/home/controllers/home_controller.dart';
import 'package:shopping/app/modules/product_detail_page/controllers/product_detail_page_controller.dart';
import 'package:shopping/app/modules/product_detail_page/views/product_detail_page_view.dart';
import 'package:shopping/app/modules/profile_page/views/profile_page_view.dart';
import 'package:shopping/app/routes/app_pages.dart';
import 'package:shopping/app/service/cart_service.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex,
            children: [
              _buildHomePage(theme, context),
              // _buildCategoriesPage(theme),
              CartPageView(),
              ProfilePageView(),
            ],
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: theme.primaryColor.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.primaryColor.withOpacity(0.1),
                        Colors.white,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: theme.primaryColor.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        context,
                        icon: Icons.home_rounded,
                        label: 'Home',
                        index: 0,
                        controller: controller,
                      ),
                      // _buildNavItem(
                      //   context,
                      //   icon: Icons.category_rounded,
                      //   label: 'Categories',
                      //   index: 1,
                      //   controller: controller,
                      // ),
                      _buildNavItem(
                        context,
                        icon: Icons.shopping_cart_rounded,
                        label: 'Cart',
                        index: 1,
                        controller: controller,
                        badgeCount: 3,
                      ),
                      _buildNavItem(
                        context,
                        icon: Icons.person_rounded,
                        label: 'Profile',
                        index: 2,
                        controller: controller,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required HomeController controller,
    int? badgeCount,
  }) {
    final theme = Theme.of(context);
    final isSelected = controller.selectedIndex == index;

    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : Colors.grey[600],
                  size: 24,
                ),
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
            if (badgeCount != null && badgeCount > 0)
              Positioned(
                top: -5,
                right: -5,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.error,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Text(
                    badgeCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomePage(ThemeData theme, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text('Discover', style: theme.textTheme.titleLarge),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded),
              onPressed: () {},
            ),
            Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications_rounded),
                  onPressed: () {},
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.error,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 50,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [Icon(Icons.category)],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: Obx(() {
            if (controller.isLoading.value) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (controller.productList.isEmpty) {
              return const SliverToBoxAdapter(
                child: Center(child: Text('No products available.')),
              );
            }

            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              delegate: SliverChildBuilderDelegate((
                BuildContext context,
                int index,
              ) {
                final product = controller.productList[index];

                return GestureDetector(
                  onTap: () {
                    // Check if the controller is already available, and initialize it if not
                    if (Get.isRegistered<ProductDetailPageController>() ==
                        false) {
                      Get.put(ProductDetailPageController());
                    }
                    if (!Get.isRegistered<CartService>()) {
                      Get.put(CartService());
                    }
                    // Get.put(CartPageController());
                    // Pass the product to the ProductDetailPageView
                    Get.to(() => ProductDetailPageView(), arguments: product);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                child: Image.network(
                                  product.image.isNotEmpty
                                      ? product.image
                                      : 'https://via.placeholder.com/150',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.favorite_border_rounded,
                                    size: 20,
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    product.productName,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '\$${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: controller.productList.length),
            );
          }),
        ),
      ],
    );
  }

  // Other page building methods remain the same...
  Widget _buildCategoriesPage(ThemeData theme) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text('Categories', style: theme.textTheme.titleLarge),
        ),
        const SliverToBoxAdapter(
          child: Center(child: Text("Categories Content")),
        ),
      ],
    );
  }

  Widget _buildCartPage(ThemeData theme) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text('Shopping Cart', style: theme.textTheme.titleLarge),
        ),
        const SliverToBoxAdapter(child: Center(child: Text("Cart Content"))),
      ],
    );
  }

  Widget _buildProfilePage(ThemeData theme) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          title: Text('My Profile', style: theme.textTheme.titleLarge),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_rounded),
              onPressed: () {},
            ),
          ],
        ),
        const SliverToBoxAdapter(child: Center(child: Text("Profile Content"))),
      ],
    );
  }
}
