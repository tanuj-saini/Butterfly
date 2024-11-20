import 'package:email_app/Models/UserModel.dart';
import 'package:get/get.dart';

class UserUpdateController extends GetxController {
  final userModelU = UserModel().obs;
  void setUserModelDto(UserModel userModel) {
    userModelU.value = userModel;
  }
}
