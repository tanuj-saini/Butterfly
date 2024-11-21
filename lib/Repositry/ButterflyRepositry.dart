import 'dart:convert';
import 'package:email_app/Models/ButterflyModel.dart';
import 'package:email_app/utils/const.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ButterflyRepository {
  final String apiUrl = "${URL}/api/butterflies";

  Future<void> saveButterfly(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        // If the butterfly is successfully saved, parse and return it
      } else {
        // Handle any errors
        print("Failed to save butterfly: ${response.body}");
        return null;
      }
    } catch (error) {
      print("Error in saveButterfly: $error");
      return null;
    }
  }

  Future<List<Butterfly>> fetchButterflies(int page, int limit) async {
    final response = await http
        .get(Uri.parse('${URL}/api/butterflies?page=$page&limit=$limit'));

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      return data.map((json) => Butterfly.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load butterflies');
    }
  }
}
