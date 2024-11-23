import 'package:email_app/Models/UserModel.dart';
import 'package:email_app/Repositry/LoginRepositry.dart';

import 'package:email_app/data/response/status.dart';

import 'package:email_app/view/LayoutOne/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  RxString error = "".obs;
  final rxRequestStatus = Status.LOADING.obs;
  final _api = LoginRepositry();
  RxBool isLoading = false.obs;
  final userModelU = UserModel().obs;

  // Controllers for the input fields
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  // Setters for state management
  void setError(String errorS) {
    error.value = errorS;
  }

  void setUserModel(UserModel userModel) {
    userModelU.value = userModel;
  }

  void setRxRequestStatus(Status _value) {
    rxRequestStatus.value = _value;
  }

  void setIsLoading(RxBool isLoadings) {
    isLoading.value = isLoadings.value;
  }

  // Function to handle sign-in logic
  void sendSignInData() {
    setIsLoading(true.obs);

    UserModel userModel = UserModel(
      email: emailController.value.text,
      password: passwordController.value.text,
    );

    _api
        .signInApi(userModel.toJson(),
            "${dotenv.env['URL'] ?? 'URL not found'}/api/signup")
        .then((value) {
      setIsLoading(false.obs);

      if (value != null) {
        setUserModel(value);
        Get.snackbar("Successfully Signed In", "Welcome");

        Get.to(ProfileSetupScreen(
          email: emailController.value.text,
        ));
      } else {
        setError("Sign-In failed. Please try again.");
      }
    }).catchError((error) {
      setIsLoading(false.obs);
      setError(error.toString());
      Get.snackbar("Error", error.toString());
    });
  }
}
