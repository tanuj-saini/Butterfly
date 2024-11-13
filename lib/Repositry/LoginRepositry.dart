import 'dart:convert';
import 'package:email_app/Models/UserModel.dart';
import 'package:email_app/data/Network/network_api.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginRepositry {
  final _appService = NetworkApiServices();
  static const String TOKEN_KEY = 'jwtToken';
  Future<UserModel?> loginApi(dynamic data, String url) async {
    try {
      final response = await _appService.postApi(data, url);

      // Handle different response types
      Map<String, dynamic> decodedResponse;

      if (response is String) {
        // If response is already a String, parse it
        decodedResponse = jsonDecode(response);
      } else if (response is Map<String, dynamic>) {
        // If response is already a Map, use it directly
        decodedResponse = response;
      } else {
        // If response is something else (like Response object)
        // Convert response body to string first
        final responseStr = response.body.toString();
        decodedResponse = jsonDecode(responseStr);
      }

      // Extract token from response
      final String? token = decodedResponse['token'];
      if (token == null) {
        throw Exception('Token not found in response');
      }

      // Store token securely
      await _storeToken(token);
      print(token);

      // Create user model from response
      // Make sure we're passing the user data correctly
      final userData = decodedResponse['user'] ?? decodedResponse;
      return UserModel.fromJson(userData);
    } catch (error) {
      Get.snackbar(
        "Login Failed",
        "An error occurred during login: ${error.toString()}",
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Login Error: $error");
      return null;
    }
  }

  Future<UserModel?> signInApi(dynamic data, String url) async {
    try {
      final response = await _appService.postApi(data, url);

      // Handle different response types
      Map<String, dynamic> decodedResponse;

      if (response is String) {
        // If response is already a String, parse it
        decodedResponse = jsonDecode(response);
      } else if (response is Map<String, dynamic>) {
        // If response is already a Map, use it directly
        decodedResponse = response;
      } else {
        // If response is something else (like Response object)
        // Convert response body to string first
        final responseStr = response.body.toString();
        decodedResponse = jsonDecode(responseStr);
      }

      // Extract token from response
      final String? token = decodedResponse['token'];
      if (token == null) {
        throw Exception('Token not found in response');
      }

      // Store token securely
      await _storeToken(token);
      print(token);

      // Create user model from response
      // Make sure we're passing the user data correctly
      final userData = decodedResponse['user'] ?? decodedResponse;
      return UserModel.fromJson(userData);
    } catch (error) {
      Get.snackbar("Sign-In failed", "$error");
      print("Sign-In Error: $error");
      return null; // Return null in case of error
    }
  }

  Future<void> _storeToken(String token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(TOKEN_KEY, token);
    } catch (e) {
      print("Error storing token: $e");
      throw Exception('Failed to store authentication token');
    }
  }

  Future<UserModel?> updateUserProfileApi(dynamic data, String url) async {
    try {
      // Perform POST request to update user profile
      final response = await _appService.postApi(data, url);
      final decodedResponse = jsonDecode(response);

      // Return a UserModel instance from JSON response
      return UserModel.fromJson(decodedResponse);
    } catch (error) {
      Get.snackbar("Profile Update Failed", "$error");
      print("Profile Update Error: $error");
      return null; // Return null if there is an error
    }
  }
}
