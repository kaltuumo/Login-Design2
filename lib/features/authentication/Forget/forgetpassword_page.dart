import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_design2/features/authentication/Login/login_page.dart';
import 'package:login_design2/features/controller/login/login_controller.dart';
import 'package:login_design2/utilities/constants/colors.dart';
import 'package:login_design2/utilities/constants/images.dart';
import 'package:login_design2/utilities/constants/sizes.dart';
import 'package:login_design2/utilities/constants/texts.dart';

class ForgetpasswordPage extends StatefulWidget {
  const ForgetpasswordPage({super.key});

  @override
  State<ForgetpasswordPage> createState() => _ForgetpasswordPageState();
}

class _ForgetpasswordPageState extends State<ForgetpasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  String errorMessage = '';
  void forgetPassword({required String email}) {
    var url = "http://192.168.1.3:8008/api/auth/send-forgot-password-code";
    var body = {"email": email};

    // Send HTTP POST request
    http
        .patch(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body),
        )
        .then((response) {
          print("Response Code: ${response.statusCode}");
          print("Response Body: ${response.body}");
          if (response.statusCode == 200) {
            var responseBody = json.decode(response.body);

            if (responseBody["success"] == true) {
              setState(() {
                errorMessage = ""; // Clear the error message
              });
              // Get.to(() => LoginPage()); // Navigate to dashboard
              print("Forget Password successfully");
              _emailController.clear();
            } else {
              setState(() {
                errorMessage = "Invalid credentials. Please try again.";
              });
            }
          } else {
            setState(() {
              errorMessage = "Failed to login. Please try again later.";
            });
          }
        })
        .catchError((error) {
          setState(() {
            errorMessage =
                "An error occurred. Please try again."; // Catch any error in the request
          });
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
              top: AppSize.containerTopPosition, // Use the constant value
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
    return Container(
      width: AppSize.mediaSize.width,
      height: AppSize.mediaSize.height * 0.8,
      decoration: BoxDecoration(
        color: AppColors.whteColors,
        borderRadius: AppSize.kTopRounderBiedr,
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          _buildWelcomeBackText(),
          const SizedBox(height: 30),
          _buildTextfield(AppTexts.textFullname, controller: _emailController),
          const SizedBox(height: 30),
          _buildButton(),
          _buildBackToLoginButton(),
        ],
      ),
    );
  }

  // Text in Container
  Widget _buildWelcomeBackText() {
    return Text(
      "Reset Your Password",
      style: TextStyle(
        color: AppColors.appColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextfield(
    String label, {

    required TextEditingController controller,
  }) {
    return Padding(
      padding: AppSize.fieldPadding,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.fieldBorder),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        forgetPassword(email: _emailController.text.trim());
        // Get.to(() => LoginPage());
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.appColor,
        minimumSize: Size(AppSize.fieldWidth, AppSize.fieldHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
      ),
      child: Text(
        "Send Reset Link",
        style: TextStyle(color: AppColors.whteColors),
      ),
    );
  }

  Widget _buildBackToLoginButton() {
    return TextButton(
      onPressed: () {
        // Get.to(() => LoginPage()); // Navigate to the Login page
      },
      child: Text(
        "Back to Login",
        style: TextStyle(color: AppColors.appColor, fontSize: 16),
      ),
    );
  }
}
