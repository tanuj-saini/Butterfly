import 'dart:io';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  // Rx variables for the profile data
  var name = ''.obs;
  var imageFile = Rx<File?>(null);

  // Method to update the name
  void updateName(String newName) {
    name.value = newName;
  }

  // Method to update the profile image
  void updateProfileImage(File newImage) {
    imageFile.value = newImage;
  }
}
