// app/controllers/home_controller.dart
import 'package:get/get.dart';

class HomeController extends GetxController {
  int selectedIndex = 0;

  void changePage(int index) {
    selectedIndex = index;
    update();
  }
}