import 'package:get/get.dart';
import 'package:shopping/app/middleware/auth_middleware.dart';

import '../modules/cart_page/bindings/cart_page_binding.dart';
import '../modules/cart_page/views/cart_page_view.dart';
import '../modules/checkout_page/bindings/checkout_page_binding.dart';
import '../modules/checkout_page/views/checkout_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login_page/bindings/login_page_binding.dart';
import '../modules/login_page/views/login_page_view.dart';
import '../modules/product_detail_page/bindings/product_detail_page_binding.dart';
import '../modules/product_detail_page/views/product_detail_page_view.dart';
import '../modules/profile_page/bindings/profile_page_binding.dart';
import '../modules/profile_page/views/profile_page_view.dart';
import '../modules/register_page/bindings/register_page_binding.dart';
import '../modules/register_page/views/register_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: _Paths.CART_PAGE,
      page: () => const CartPageView(),
      binding: CartPageBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_PAGE,
      page: () => const ProfilePageView(),
      binding: ProfilePageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAIL_PAGE,
      page: () => ProductDetailPageView(),
      binding: ProductDetailPageBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT_PAGE,
      page: () => const CheckoutPageView(),
      binding: CheckoutPageBinding(),
    ),
  ];
}
