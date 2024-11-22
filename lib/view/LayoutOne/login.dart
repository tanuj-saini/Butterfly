import 'package:email_app/view/LayoutOne/register.dart';
import 'package:email_app/viewModel/AuthC/SignController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  final LoginController _loginController = Get.put(LoginController());
  final GlobalKey<FormState> formKey = GlobalKey();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: height,
            child: Stack(
              children: [
                // Background Image with Opacity
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.5, // Adjust opacity as needed (0.0 to 1.0)
                    child: Image.asset(
                      'assets/butterflyicon.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // Main Content
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.08,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: Colors
                              .black87, // Changed to dark color for better visibility
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Welcome Back to Butterfly Identification App specially made for the species of Gujarat!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors
                              .black54, // Changed to dark color for better visibility
                        ),
                      ),
                      SizedBox(height: height * 0.12),

                      // Login Form Card
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.9), // Added opacity to the card
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          constraints: BoxConstraints(maxWidth: width * 0.85),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 20,
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Email Field
                                  TextFormField(
                                    controller:
                                        _loginController.emailController.value,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      labelStyle:
                                          TextStyle(color: Colors.grey[600]),
                                      prefixIcon: Icon(Icons.email_outlined,
                                          color: Colors.purple[300]),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.purple.shade300),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return "Email is required";
                                      if (!value.contains('@'))
                                        return "Enter a valid email";
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),

                                  // Password Field
                                  TextFormField(
                                    controller: _loginController
                                        .passwordController.value,
                                    obscureText: !isPasswordVisible,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      labelStyle:
                                          TextStyle(color: Colors.grey[600]),
                                      prefixIcon: Icon(Icons.lock_outline,
                                          color: Colors.purple[300]),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          isPasswordVisible
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: Colors.grey[600],
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            isPasswordVisible =
                                                !isPasswordVisible;
                                          });
                                        },
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.purple.shade300),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return "Password is required";
                                      if (value.length < 6)
                                        return "Password must be at least 6 characters";
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: height * 0.05),

                                  // Sign In Button
                                  Center(
                                    child: Obx(() => SizedBox(
                                          width: width * 0.5,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                _loginController.sendData();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                              elevation: 5,
                                            ),
                                            child:
                                                _loginController.isLoading.value
                                                    ? CircularProgressIndicator(
                                                        color: Colors.white)
                                                    : const Text(
                                                        "Sign In",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          letterSpacing: 1.2,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                          ),
                                        )),
                                  ),

                                  SizedBox(height: height * 0.02),

                                  // Register Link
                                  Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(RegisterUI());
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Don't have an account? ",
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "Register",
                                            style: TextStyle(
                                              color: Colors.purple,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
