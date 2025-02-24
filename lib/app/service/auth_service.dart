import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping/app/data/user_model.dart';
import 'package:shopping/app/service/user_preferences.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    final url = Uri.parse('http://localhost:3000/shopping/user/user/login/demo'); // Replace with your API endpoint
    
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        if (data['message'] == 'Login successful') {
          final user = UserModel.fromJson(data['user']);
          final userPreferences = UserPreferences();
          
          await userPreferences.saveUser(user);
          await userPreferences.saveToken(data['token'] ?? ''); // Save token
          await userPreferences.setLoggedIn(true);
          
          return true;
        }
      }
      
      return false;
    } catch (e) {
      print('Login Error: $e');
      return false;
    }
  }
}
