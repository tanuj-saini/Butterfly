import 'dart:convert';

import 'package:email_app/Models/UserModel.dart';
import 'package:email_app/data/Network/network_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositry {
  final _appService = NetworkApiServices();
  Future sendJwtVerify(String url, Map<String, String> headers) async {
    // Get the response from the API
    var response = await _appService.postApiWithHeaders("", url, headers);
    print(response);

    return jsonDecode(response);
  }

  Future<UserModel> getUserData(String url, Map<String, String> headers) async {
    // Get the response from the API
    dynamic response = await _appService.getApiWithHeaders(url, headers);

    // Decode the response to a map
    Map<String, dynamic> decodedResponse = jsonDecode(response);

    print("From repositry");
    print(decodedResponse);

    // Access 'user' and 'token' directly from the decoded map
    Map<String, dynamic> user = decodedResponse['user'];
    String token = decodedResponse['token'];
    print("hello Token");
    print(token);

    // Save the token to SharedPreferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwtToken', token);

    // Retrieve the token to verify it was saved correctly
    String? jwt = await prefs.getString('jwtToken');
    print("jwt token");
    print(jwt);

    // Return UserModelDto from the 'user' part of the response
    return UserModel.fromJson(user);
  }
}
