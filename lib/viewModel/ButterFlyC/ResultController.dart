import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ResultController extends GetxController {
  var isLoading = false.obs;
  var result = ''.obs;
  var SientificName = ''.obs;
  var imageurls = "".obs;

  Future<void> uploadImageAndPredict(File image) async {
    isLoading.value = true;
    result.value = "";

    try {
      String photoUrlCLo = "";
      final cloudinary = CloudinaryPublic(
          dotenv.env['CLOD1'] ?? 'Cloudinary1 not found',
          dotenv.env['CLOD2'] ?? 'Cloudinary2 not found');
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(image.path, folder: "User Profile"));
      photoUrlCLo = response.secureUrl;

      if (photoUrlCLo != "") {
        print(photoUrlCLo);
        String imageUrl = photoUrlCLo;
        String api = dotenv.env['API_URL'] ?? 'API URL not found';
        // Send image URL to prediction API
        var apiResponse = await http.post(
          Uri.parse(api),
          body: json.encode({"image_url": imageUrl}),
          headers: {"Content-Type": "application/json"},
        );
        print(apiResponse);

        if (apiResponse.statusCode == 200) {
          var apiResult = json.decode(apiResponse.body);
          result.value = apiResult['common_name'];
          SientificName.value = apiResult["scientific_name"];
          imageurls.value = apiResult["image_url"];
          print(imageurls.value);

          // Adjust based on API response
        } else {
          result.value = "Error: Unable to fetch prediction.";
        }
      } else {
        result.value = "Error: Image upload failed.";
      }
    } catch (e) {
      result.value = "Error: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
