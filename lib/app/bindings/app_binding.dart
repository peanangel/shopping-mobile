import 'package:get/get.dart';
import 'package:shopping/app/controllers/app_controller.dart';
import 'package:shopping/app/modules/cart_page/controllers/cart_page_controller.dart';
import 'package:shopping/app/modules/home/controllers/home_controller.dart';
import 'package:shopping/app/modules/login_page/controllers/login_page_controller.dart';
import 'package:shopping/app/modules/product_detail_page/controllers/product_detail_page_controller.dart';
import 'package:shopping/app/modules/profile_page/controllers/profile_page_controller.dart';
import 'package:shopping/app/modules/register_page/controllers/register_page_controller.dart';
import 'package:shopping/app/service/base_service.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<AppController>(() => AppController());  
    Get.put(RegisterPageController());
    Get.put(LoginPageController());
    Get.put(BaseService());
    Get.lazyPut(()=>CartPageController());
    Get.lazyPut(()=>ProfilePageController());
    Get.lazyPut(()=>HomeController());
    Get.lazyPut(()=>ProductDetailPageController());
    // Get.put(ProductDetailPageController());
   
  

    
 
    

  }
}
