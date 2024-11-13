import 'package:email_app/view/CheckingUserJwt.dart';
import 'package:email_app/view/LayoutOne/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? typeOfUser = prefs.getString('jwtToken');
  if (typeOfUser == null) {
    prefs.setString('jwtToken', "");
  }
  runApp(MyApp(
    typeOfUser: typeOfUser,
  ));
}

class MyApp extends StatelessWidget {
  final String? typeOfUser;
  const MyApp({required this.typeOfUser, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: typeOfUser == null
            ? LoginUI()
            : Checkinguserjwt(jwtToken: typeOfUser!));
  }
}
