// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shopping/app/data/user_model.dart';

// class UserPreferences {
//   static const String _keyUser = 'user';
//   static const String _keyToken = 'token';
//   static const String _keyIsLoggedIn = 'isLoggedIn';
//   static const String _keyTheme = 'isDarkMode';
//   static const String _keyLanguage = 'language';

//   static final UserPreferences _instance = UserPreferences._internal();

//   factory UserPreferences() {
//     return _instance;
//   }

//   UserPreferences._internal();

//   Future<void> init() async {
//     await SharedPreferences.getInstance();
//   }

//   // User Data Management
//   Future<void> saveUser(UserModel user) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyUser, jsonEncode(user.toJson()));
//   }

//   Future<UserModel?> getUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userStr = prefs.getString(_keyUser);
//     if (userStr != null) {
//       return UserModel.fromJson(jsonDecode(userStr));
//     }
//     return null;
//   }

//   // Token Management
//   Future<void> saveToken(String token) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyToken, token);
//   }

//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyToken);
//   }

//   // Login Status
//   Future<void> setLoggedIn(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_keyIsLoggedIn, value);
//   }

//   Future<bool> isLoggedIn() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_keyIsLoggedIn) ?? false;
//   }

//   // Theme Preference
//   Future<void> setDarkMode(bool value) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool(_keyTheme, value);
//   }

//   Future<bool> isDarkMode() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool(_keyTheme) ?? false;
//   }

//   // Language Preference
//   Future<void> setLanguage(String languageCode) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_keyLanguage, languageCode);
//   }

//   Future<String> getLanguage() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(_keyLanguage) ?? 'en';
//   }

//   // Clear User Data
//   Future<void> clearUserData() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_keyUser);
//     await prefs.remove(_keyToken);
//     await prefs.setBool(_keyIsLoggedIn, false);
//   }

//   // Clear All Data
//   Future<void> clearAll() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }
// }

// // Extension for Role Types
// extension UserRole on int {

//   static const int seller = 1;
//   static const int user = 2;

//   bool get isSeller => this == seller;
//   bool get isCustomer => this == user;
// }



import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping/app/data/user_model.dart';

class UserPreferences {
  static const String _keyUser = 'user';
  static const String _keyToken = 'token';
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyTheme = 'isDarkMode';
  static const String _keyLanguage = 'language';

  static final UserPreferences _instance = UserPreferences._internal();

  late SharedPreferences _prefs; // ใช้ instance เดียวกันตลอด

  factory UserPreferences() => _instance;

  UserPreferences._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // User Data Management
  Future<void> saveUser(UserModel user) async {
    await _prefs.setString(_keyUser, jsonEncode(user.toJson()));
  }

  UserModel? getUser() {
    final userStr = _prefs.getString(_keyUser);
    if (userStr != null) {
      return UserModel.fromJson(jsonDecode(userStr));
    }
    return null;
  }

  // Token Management
  Future<void> saveToken(String token) async {
    await _prefs.setString(_keyToken, token);
  }

  String? getToken() {
    return _prefs.getString(_keyToken);
  }

  // Login Status
  Future<void> setLoggedIn(bool value) async {
    await _prefs.setBool(_keyIsLoggedIn, value);
  }

  bool isLoggedIn() {
    return _prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // Theme Preference
  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_keyTheme, value);
  }

  bool isDarkMode() {
    return _prefs.getBool(_keyTheme) ?? false;
  }

  // Language Preference
  Future<void> setLanguage(String languageCode) async {
    await _prefs.setString(_keyLanguage, languageCode);
  }

  String getLanguage() {
    return _prefs.getString(_keyLanguage) ?? 'en';
  }

  // Clear User Data
  Future<void> clearUserData() async {
    await _prefs.remove(_keyUser);
    await _prefs.remove(_keyToken);
    await _prefs.setBool(_keyIsLoggedIn, false);
    await _prefs.reload();
  }

  // Clear All Data
  Future<void> clearAll() async {
    await _prefs.clear();
    await _prefs.reload();
  }
}

// Use Enum Instead of Extension for Roles
enum UserRole {
  seller(1),
  customer(2);

  final int value;
  const UserRole(this.value);

  static UserRole fromInt(int role) {
    return UserRole.values.firstWhere((e) => e.value == role, orElse: () => UserRole.customer);
  }
}
