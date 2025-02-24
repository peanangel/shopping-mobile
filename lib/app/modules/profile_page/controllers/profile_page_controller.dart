import 'package:get/get.dart';
import 'package:shopping/app/data/user_model.dart';
import 'package:shopping/app/service/base_service.dart';
import 'package:shopping/app/service/user_preferences.dart';
import 'package:shopping/app/widgets/widget.dart';

class ProfilePageController extends GetxController {
  final BaseService _baseService = Get.find<BaseService>();
  Rx<UserModel?> user = Rx<UserModel?>(
    null,
  ); // Use Rx<UserModel?> for a single user

  @override
  void onInit() {
    super.onInit();
    // Load profile data when the controller is initialized
    loadProfileData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> loadProfileData() async {
  try {
    final userref = await UserPreferences().getUser();
    if (userref == null) {
      showMessage('No user found, please log in.', isError: true);
      return;
    }

    final userId = userref.uid;
    final response = await _baseService.get(endpoint: "/user/user/$userId");

    print('Response: $response');  // Print the response to check the data

    if (response['message'] == 'successful' && response['data'] != null) {
      // Now, 'data' is an object, so we can directly access it
      var userData = response['data'];  // Access the user object directly
      user.value = UserModel.fromJson(userData);  // Assuming fromJson can handle a single user's data
      print('User Data: ${user.value}');  // Check if the user data is set properly
    } else {
      showMessage('Failed to load user data.', isError: true);
    }
  } catch (e) {
    print('Error loading data: $e');
    showMessage('Failed to load data. Please try again.', isError: true);
  }
}

}
