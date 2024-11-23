import 'dart:io';
import 'package:email_app/Models/ButterflyModel.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ButterflyController extends GetxController {
  var butterflyName = ''.obs;
  var scientificName = ''.obs;
  var imageFile = Rx<File?>(null);

  final picker = ImagePicker();

  Future<void> setDetails(String name, String scientificName) async {
    butterflyName.value = name;
    this.scientificName.value = scientificName;
  }

  Future<void> uploadButterflyData() async {
    if (imageFile.value == null) {
      Get.snackbar('Error', 'Please select an image first');
      return;
    }
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('${dotenv.env['URL'] ?? 'URL not found'}/api/butterflies'),
      );
      request.fields['name'] = butterflyName.value;
      request.fields['scientificName'] = scientificName.value;
      request.files.add(await http.MultipartFile.fromPath(
        'imageURL',
        imageFile.value!.path,
      ));

      final response = await request.send();
      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Butterfly data uploaded successfully');
      } else {
        Get.snackbar('Error', 'Failed to upload data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  var butterflyHistory = <Butterfly>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadButterflyHistory();
  }

  Future<void> loadButterflyHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith('butterfly'));
    List<Butterfly> loadedButterflies = [];

    for (var key in keys) {
      final butterflyJson = prefs.getString(key);
      if (butterflyJson != null) {
        final butterfly = Butterfly.fromJson(jsonDecode(butterflyJson));
        loadedButterflies.add(butterfly);
      }
    }

    butterflyHistory.value = loadedButterflies;
  }
}
