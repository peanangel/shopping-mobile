import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping/app/bindings/app_binding.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Shopping App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Base colors - Using a sophisticated teal as primary color
        primaryColor: const Color(0xFF00897B),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),

        // Color scheme
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF00897B), // Teal - Main brand color
          secondary: const Color(0xFF26A69A), // Lighter teal for accents
          surface: Colors.white,
          background: const Color(0xFFF5F5F5), // Light grey background
          error: const Color(0xFFE53935), // Error red
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: const Color(0xFF424242), // Dark grey for text
          onBackground: const Color(0xFF424242),
          onError: Colors.white,
        ),

        // Text theme
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF212121), // Nearly black for headings
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            color: Color(0xFF757575), // Medium grey for subheadings
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF424242), // Dark grey for body text
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF757575), // Medium grey for secondary text
          ),
          labelLarge: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        // Input decoration
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Slightly reduced radius
            borderSide: BorderSide(
              color: const Color(0xFFE0E0E0), // Light grey border
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: const Color(0xFFE0E0E0), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: const Color(0xFF00897B), // Teal border when focused
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),

        // Elevated button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF00897B), // Teal buttons
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2, // Subtle shadow
          ),
        ),

        // Text button theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF00897B), // Teal text buttons
          ),
        ),
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
    );
  }
}
