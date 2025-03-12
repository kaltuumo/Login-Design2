import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:login_design2/features/controller/login/login_controller.dart';
import 'package:login_design2/utilities/constants/colors.dart';
import 'package:login_design2/utilities/constants/images.dart';
import 'package:login_design2/utilities/constants/sizes.dart';
import 'package:login_design2/utilities/constants/texts.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String errorMessage = ''; // Error message variable

  void register({
    required String fullname,
    required String email,
    required String password,
    required String phone,
  }) {
    if (!_formKey.currentState!.validate()) {
      return; // If form is invalid, stop execution
    }
    setState(() {
      errorMessage = ''; // Clear previous error messages
    });

    var url = "http://192.168.1.3:8008/api/auth/signup";
    var body = {
      "fullname": fullname,
      "email": email,
      "password": password,
      "phone": phone,
    };

    http
        .post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body),
        )
        .then((response) {
          print("Response: ${response.body}");

          var responseBody = json.decode(response.body);
          if (response.statusCode == 200) {
            if (responseBody["success"] == true) {
              setState(() {
                errorMessage = ""; // Clear the error message
              });

              print("User registered successfully");

              // Clear the text fields after successful registration
              _fullnameController.clear();
              _emailController.clear();
              _passwordController.clear();
              _phoneController.clear();

              // Add a delay to allow UI to update before navigating
              Future.delayed(Duration(seconds: 1), () {
                Get.to(() => LoginController());
              });
            }
            // Handle case for 'User already exists'
            else if (responseBody["message"] == "User already exists!") {
              setState(() {
                errorMessage =
                    "User already exists! Please use a different email.";
              });
              print("User already exists!");
            }
          }
        })
        .catchError((error) {
          print("Error during HTTP request: $error");
        });
  }

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    AppSize.init(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whteColors,
        image: DecorationImage(
          image: AssetImage(AppImage.bgImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.scatfColor,
        body: Stack(
          children: [
            Positioned(
              top: AppSize.containerTopPosition,
              left: AppSize.containerLeftPosition,
              right: AppSize.containerRightPosition,
              child: _builTop(controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builTop(LoginController controller) {
    return Form(
      key: _formKey,
      child: Container(
        width: AppSize.mediaSize.width,
        height: AppSize.mediaSize.height * 0.8,
        decoration: BoxDecoration(
          color: AppColors.whteColors,
          borderRadius: AppSize.kTopRounderBiedr,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildWelcomeBackText(),
            const SizedBox(height: 20),
            _buildTextfield(
              AppTexts.textFullname,
              controller: _fullnameController,
            ),
            const SizedBox(height: 20),
            _buildTextfield(AppTexts.textemail, controller: _emailController),
            const SizedBox(height: 20),
            _buildTextfield(
              AppTexts.textPassword,
              isPassword: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 20),
            _buildTextfield(AppTexts.textphone, controller: _phoneController),
            const SizedBox(height: 20),
            _checkAndForgetPassword(controller),
            const SizedBox(height: 20),
            _buildButton(),
            const SizedBox(height: 20),
            // _buildSignInWithText(),
            const SizedBox(height: 20),
            // _buildSocial(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeBackText() {
    return Text(
      "Get Started",
      style: TextStyle(
        color: AppColors.appColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextfield(
    String label, {
    bool isPassword = false,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: AppSize.fieldPadding,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.fieldBorder),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label is required";
          }
          return null;
        },
      ),
    );
  }

  Widget _checkAndForgetPassword(LoginController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return Row(
              children: [
                Checkbox(
                  value: controller.isChecked.value,
                  onChanged: (bool? value) {
                    controller.checkBoxFuc(value ?? false);
                  },
                ),
                const Text("I Agree The Processing"),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        register(
          fullname: _fullnameController.text,
          email: _emailController.text.trim(),
          password: _passwordController.text,
          phone: _phoneController.text,
        );
      },

      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.appColor,
        minimumSize: Size(AppSize.fieldWidth, AppSize.fieldHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
      ),
      child: Text("SignUp", style: TextStyle(color: AppColors.whteColors)),
    );
  }

  // Widget _buildSocial() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       Image.asset(AppImage.faceImage, width: 40, height: 40),
  //       const SizedBox(width: 40),
  //       Image.asset(AppImage.twitterImage, width: 40, height: 40),
  //       const SizedBox(width: 40),
  //       Image.asset(AppImage.gitImage, width: 40, height: 40),
  //       const SizedBox(width: 40),
  //       Image.asset(AppImage.googleImage, width: 40, height: 40),
  //     ],
  //   );
  // }

  // Widget _buildSignInWithText() {
  //   return Padding(
  //     padding: AppSize.lignPadding,
  //     child: Row(
  //       children: [
  //         const Expanded(child: Divider(thickness: 1, indent: 0)),
  //         Padding(
  //           padding: AppSize.textlignPadding,
  //           child: const Text("Sign in With"),
  //         ),
  //         const Expanded(child: Divider(thickness: 1, indent: 0)),
  //       ],
  //     ),
  //   );
  // }
}
