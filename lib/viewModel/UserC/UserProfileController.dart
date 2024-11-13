import 'package:email_app/Models/UserModel.dart';
import 'package:email_app/Repositry/LoginRepositry.dart';
import 'package:email_app/Repositry/UserRepositry.dart';
import 'package:email_app/view/LayoutOne/ImageContainer.dart';
import 'package:email_app/view/LayoutOne/login.dart';
import 'package:email_app/viewModel/AuthC/LoginController.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileController extends GetxController {
  RxBool isLoading = false.obs; // Track loading state
  RxString error = ''.obs;
  final _api = LoginRepositry();
  final _apiUser = UserRepositry();

  // Observable user model
  final userModelU = UserModel().obs;
  void setUserModelDto(UserModel userModel) {
    userModelU.value = userModel;
  }

  final nameController = TextEditingController().obs;
  final userProfileController = TextEditingController().obs;
  final SignInController signInController = Get.put(SignInController());

  // Method to handle updating user profile
  Future<void> updateUserProfile() async {
    isLoading(true); // Start loading

    try {
      // Call API to update user profile
      var updatedUser = await _api.updateUserProfileApi(
        {
          'email': signInController.emailController.value.text,
          'name': nameController.value.text,
          'userProfile': userProfileController.value.text,
        },
        "http://localhost:3000/api/userProfile", // Backend URL to update profile
      );

      if (updatedUser != null) {
        // Update userModelU with the new data
        userModelU.value = updatedUser;

        // Show success message
        Get.snackbar(
            "Profile Updated", "Your profile has been updated successfully!");

        // Navigate to the next screen if necessary
        Get.to(PickImageScreen());
      } else {
        Get.snackbar("Error", "Failed to update profile");
      }
    } catch (error) {
      this.error.value = error.toString();
      Get.snackbar("Error", "Failed to update profile");
    } finally {
      isLoading(false); // Stop loading
    }
  }

  void setIsLoading(RxBool isLoadings) {
    isLoading.value = isLoadings.value;
  }

  void checkUserToken() async {
    setIsLoading(true.obs);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwtToken');

    if (token == null) {
      prefs.setString('jwtToken', '');
    }

    _apiUser.sendJwtVerify(
      "http://localhost:3000/tokenIsValid",
      <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token-w': token!,
      },
    ).then((value) {
      isLoading.value = false;
      print("yesTrue");
      print(token);
      if (value) {
        _apiUser.getUserData(
          "/",
          <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token-w': token,
          },
        ).then((value) {
          print(value);
          setUserModelDto(value);
          Get.snackbar("Welcome", "Again...");
          setIsLoading(false.obs);
          // String? token = prefs.getString('valid');

          if (value.name != null) {
            isLoading.value = false;
            Get.offAll(PickImageScreen());
          } else {
            isLoading.value = false;
            Get.to(LoginUI());
          }
        });
        isLoading.value = false;
      } else {
        Get.snackbar("No Auth Token Valid", "Validation Failed");
        Get.to(LoginUI());
        setIsLoading(false.obs);
      }
    }).onError((error, stackTrace) {
      Get.snackbar("Error", error.toString());
      print("Error: $error");
      print("StackTrace: $stackTrace");

      isLoading.value = false;
    });
  }
}
