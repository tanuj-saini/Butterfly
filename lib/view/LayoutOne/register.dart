import 'package:email_app/view/LayoutOne/login.dart';
import 'package:email_app/viewModel/AuthC/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({super.key});

  @override
  State<RegisterUI> createState() => _RegisterUIState();
}

class _RegisterUIState extends State<RegisterUI> {
  final SignInController signInController = Get.put(SignInController());
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  children: [
                    // Header
                    const Text(
                      "Sign Up",
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
                      "Welcome, To explore a catalogue and try out butterfly Identification just register yourself with us!!",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors
                            .black54, // Changed to dark color for better visibility
                      ),
                    ),
                    SizedBox(height: height * 0.12),

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
                                      signInController.emailController.value,
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

                                // Name Field
                                TextFormField(
                                  controller:
                                      signInController.nameController.value,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "Name",
                                    labelStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    prefixIcon: Icon(Icons.person_outline,
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
                                      return "Name is required";
                                    return null;
                                  },
                                ),

                                const SizedBox(height: 20),

                                // Password Field
                                TextFormField(
                                  controller:
                                      signInController.passwordController.value,
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    SizedBox(
                      width: width * 0.5,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: signInController.isLoading.value
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  signInController.isLoading.value = true;
                                  signInController.sendSignInData();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 5,
                        ),
                        child: Obx(
                          () => signInController.isLoading.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(height: height * 0.03),
                        // Sign In Link
                        GestureDetector(
                          onTap: () {
                            Get.to(LoginUI());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Sign In",
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
