// import 'package:get/get.dart';
// import 'package:shopping/app/service/user_preferences.dart';

// class AuthMiddleware extends GetMiddleware {
//   final UserPreferences userPrefs = UserPreferences();

//   @override
//   int? get priority => 1;

//   @override
//   RouteSettings? redirect(String? route) {
//     return checkAuth(route);
//   }

//   RouteSettings? checkAuth(String? route) async {
//     final isLoggedIn = await userPrefs.isLoggedIn();
//     final user = await userPrefs.getUser();

//     // Public routes that don't require authentication
//     if (route == '/login' || 
//         route == '/register' || 
//         route == '/forgot-password') {
//       if (isLoggedIn) {
//         // If user is already logged in, redirect to appropriate dashboard
//         return const RouteSettings(name: '/dashboard');
//       }
//       return null; // Allow access to public routes
//     }

//     // Check if user is logged in
//     if (!isLoggedIn) {
//       // Store the attempted route for redirect after login
//       await userPrefs.setLastAttemptedRoute(route ?? '/dashboard');
//       return const RouteSettings(name: '/login');
//     }

//     // Role-based route protection
//     if (user != null) {
//       if (route?.startsWith('/admin') == true && !user.role.isAdmin) {
//         return const RouteSettings(name: '/unauthorized');
//       }
//       if (route?.startsWith('/seller') == true && !user.role.isSeller) {
//         return const RouteSettings(name: '/unauthorized');
//       }
//     }

//     return null; // Allow access to protected routes for authenticated users
//   }
// }