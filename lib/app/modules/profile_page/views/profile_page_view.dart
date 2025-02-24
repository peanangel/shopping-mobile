import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/app/modules/profile_page/controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: Implement edit profile functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header Section
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Obx(() {
                    return CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      backgroundImage:
                          controller.user.value?.image != null &&
                                  controller.user.value!.image!.isNotEmpty
                              ? NetworkImage(controller.user.value!.image!)
                              : null, // Set to null if no image
                      child:
                          controller.user.value?.image == null ||
                                  controller.user.value!.image!.isEmpty
                              ? const Icon(
                                Icons.person,
                                size: 40,
                                color: Colors.white,
                              )
                              : null, // Hide icon if image exists
                    );
                  }),

                  const SizedBox(height: 16),
                  Obx(() {
                    // Check if the user data is loaded
                    if (controller.user.value == null) {
                      // If the user data is null, show a loading message or a loading indicator
                      return Text(
                        'Loading...', // Fallback to 'Loading...' while data is being fetched
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    } else {
                      // If user data is not null, display the name
                      return Text(
                        controller.user.value?.name ??
                            'No name available', // Fallback to a default value
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                  }),

                  Obx(() {
                    // Check if the email is null or empty
                    return Text(
                      controller.user.value?.email ??
                          'No email provided', // Display default value if null
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    );
                  }),
                ],
              ),
            ),

            // Quick Stats Section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatColumn('Orders', '12'),
                  _buildStatColumn('Wishlist', '8'),
                  _buildStatColumn('Reviews', '4'),
                ],
              ),
            ),

            const Divider(),

            // Menu Items
            _buildMenuItem(
              icon: Icons.shopping_bag,
              title: 'Order History',
              subtitle: 'View your order status and history',
              onTap: () {
                // TODO: Navigate to order history
              },
            ),
            _buildMenuItem(
              icon: Icons.favorite,
              title: 'Wishlist',
              subtitle: 'Products you\'ve saved',
              onTap: () {
                // TODO: Navigate to wishlist
              },
            ),
            _buildMenuItem(
              icon: Icons.location_on,
              title: 'Addresses',
              subtitle: 'Manage delivery addresses',
              onTap: () {
                // TODO: Navigate to addresses
              },
            ),
            _buildMenuItem(
              icon: Icons.settings,
              title: 'Settings',
              subtitle: 'App preferences and account settings',
              onTap: () {
                // TODO: Navigate to settings
              },
            ),
            _buildMenuItem(
              icon: Icons.help,
              title: 'Help & Support',
              subtitle: 'FAQs and customer support',
              onTap: () {
                // TODO: Navigate to help
              },
            ),
            _buildMenuItem(
              icon: Icons.logout,
              title: 'Logout',
              subtitle: 'Sign out from your account',
              onTap: () {
                // TODO: Implement logout
              },
              showDivider: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String title, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.chevron_right),
          onTap: onTap,
        ),
        if (showDivider) const Divider(),
      ],
    );
  }
}
