import 'dart:convert';

import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:http/http.dart' as http;

class BaseService extends GetxService {
  final String serverUrl = "http://localhost:3000";
  final String serverPath = "/shopping";

  String getServerUrl() => serverUrl;
  String getServerApiUrl() => serverUrl + serverPath;

  // Function to make GET requests
  Future<Map<String, dynamic>> get({required String endpoint}) async {
    Uri url = Uri.parse(getServerApiUrl() + endpoint);
    try {
      final response = await http.get(url);

      // Check for successful response
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      rethrow;
    }
  }

  // Function to make POST requests
  Future<dynamic> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    Uri url = Uri.parse(getServerApiUrl() + endpoint);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Success: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return json.decode(response.body);
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception(
          'Failed to post data: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }

  // Function to make POST requests
  Future<dynamic> put({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    Uri url = Uri.parse(getServerApiUrl() + endpoint);

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data ?? {}),
      );

      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Success: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return json.decode(response.body);
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception(
          'Failed to post data: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }

  Future<dynamic> delete({required String endpoint}) async {
    Uri url = Uri.parse(getServerApiUrl() + endpoint);
    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return "delete successful";
      } else {
        return {"error": "Failed to delete"};
      }
    } catch (e) {
      return {"error": "An error occurred: $e"};
    }
  }

  // Function to handle error and return meaningful message
  String handleError(Exception e) {
    return 'Error: ${e.toString()}';
  }

  // Function to make PATCH requests
  Future<dynamic> patch({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    Uri url = Uri.parse(getServerApiUrl() + endpoint);

    try {
      final response = await http.patch(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data ?? {}),
      );

      // Check for successful response
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Success: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return json.decode(response.body);
      } else {
        print('Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception(
          'Failed to patch data: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Exception: $e');
      rethrow;
    }
  }

  
}
