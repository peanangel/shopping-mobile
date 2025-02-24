import 'package:get/get.dart';
import 'package:shopping/app/data/product_model.dart';
import 'package:shopping/app/service/user_preferences.dart';
import 'package:shopping/app/service/base_service.dart';
import 'package:shopping/app/widgets/widget.dart';

class ProductDetailPageController extends GetxController {
  //TODO: Implement ProductDetailPageController
  final BaseService _baseService = Get.find<BaseService>();
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

  Future<void> addToCart() async {
    // final title = titleController.text.trim();
    // final description = descriptionController.text.trim();

    // if (title.isEmpty || description.isEmpty) {
    //   showMessage('Both Title and Description are required.', isError: true);
    //   return;
    // }
    final userref = await UserPreferences().getUser();
    final body = {"uid": userref?.uid, "pid": product.pid};

    try {
      final response = await _baseService.post(
        endpoint: "/products/cart",
        data: body,
      );

      if (response['message'] == 'Product added to cart successfully' ||
          response['message'] == 'Amount updated successfully') {
        showMessage('added successfully!');
      } else {
        showMessage('Failed to add Todo. Please try again.', isError: true);
      }
    } catch (e) {
      showMessage(
        'An error occurred. Please check your connection.',
        isError: true,
      );
      print('Error: $e');
    } finally {
      // Ensure Get.back() is called after everything is done
    }
  }
}
