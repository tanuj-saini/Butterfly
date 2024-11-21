import 'package:email_app/Models/UserModel.dart';
import 'package:email_app/Repositry/LoginRepositry.dart';
import 'package:email_app/data/response/status.dart';
import 'package:email_app/utils/const.dart';
import 'package:email_app/view/LayoutOne/ImageContainer.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxString error = "".obs;
  final rxRequestStatus = Status.LOADING.obs;
  final _api = LoginRepositry();
  RxBool isLoading = false.obs;
  final userModelU = UserModel().obs;

  final usernameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final phoneNumberController = TextEditingController().obs;
  final aboutController = TextEditingController().obs;

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

  void sendData() {
    setIsLoading(true.obs);

    UserModel userModel = UserModel(
      email: emailController.value.text,
      password: passwordController.value.text,
    );

    _api.loginApi(userModel.toJson(), "${URL}/api/signin").then((value) {
      setIsLoading(false.obs);

      if (value != null) {
        setUserModel(value);
        Get.snackbar("Successfully Logged In", "Welcome");
        Get.to(PickImageScreen());
      } else {
        Get.snackbar("Login failed", "Please try again");
        setError("Login failed. Please try again.");
      }
    }).catchError((error) {
      setIsLoading(false.obs);
      setError(error.toString());
      Get.snackbar("Error", error.toString());
    });
  }
}
