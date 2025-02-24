// app/controllers/home_controller.dart
import 'package:get/get.dart';
import 'package:shopping/app/data/product_model.dart';
import 'package:shopping/app/service/base_service.dart';
import 'package:shopping/app/widgets/widget.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  final isLoading = false.obs;
  final BaseService _baseService = Get.find<BaseService>();

  void changePage(int index) {
    selectedIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  @override
  void onReady() {
    super.onReady();
    loadProducts(); // Reload products when the page is ready
  }

  Future<void> loadProducts() async {
    isLoading.value = true; // Start loading

    try {
      final response = await _baseService.get(endpoint: "/allproduct");

      if (response['message'] == 'successful' && response['data'] != null) {
        // Convert JSON list to ProductModel list
        productList.assignAll(
          (response['data'] as List)
              .map((item) => ProductModel.fromJson(item))
              .toList(),
        );

        print('Loaded ${productList.length} products');
        if (productList.isNotEmpty) {
          print('First product name: ${productList[0].productName}');
        }
      }
    } catch (e) {
      print('Error loading data: $e');
      showMessage('Failed to load products. Please try again.', isError: true);
    } finally {
      isLoading.value = false; // Stop loading
    }
  }
}
