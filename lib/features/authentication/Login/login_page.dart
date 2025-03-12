import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:login_design2/features/authentication/Forget/forgetpassword_page.dart';
import 'package:login_design2/features/authentication/dashboard_page.dart';
import 'package:login_design2/features/authentication/signUp/signup_page.dart';
import 'package:login_design2/features/controller/login/login_controller.dart';
import 'package:login_design2/utilities/constants/colors.dart';
import 'package:login_design2/utilities/constants/icons.dart';
import 'package:login_design2/utilities/constants/images.dart';
import 'package:login_design2/utilities/constants/sizes.dart';
import 'package:login_design2/utilities/constants/texts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text Editing Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String errorMessage = ''; // Error message variable
  void login({required String email, required String password}) {
    if (!_formKey.currentState!.validate()) {
      return; // If form is invalid, stop execution
    }

    setState(() {
      errorMessage = ''; // Clear previous error messages
    });

    var url = "http://192.168.1.3:8008/api/auth/signin";
    var body = {"email": email, "password": password};

    // Send HTTP POST request
    http
        .post(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: json.encode(body),
        )
        .then((response) {
          if (response.statusCode == 200) {
            var responseBody = json.decode(response.body);

            if (responseBody["success"] == true) {
              setState(() {
                errorMessage = ""; // Clear the error message
              });
              Get.to(() => DashboardPage()); // Navigate to dashboard
              print("User login successfully");
              _emailController.clear();
              _passwordController.clear();
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

    // Initialize mediaSize
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
              top: AppSize.loginContainer, // Use the constant value
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
              controller: _emailController,
              label: AppTexts.textemail,
              icon: Appicons.userIcon,
            ),
            const SizedBox(height: 20),
            _buildTextfield(
              controller: _passwordController,
              label: AppTexts.textPassword,
              icon: Appicons.passIcon,
              isPassword: true,
            ),
            const SizedBox(height: 20),

            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            const SizedBox(height: 10),
            _checkAndForgetPassword(),
            const SizedBox(height: 20),
            _buildButton(),
            const SizedBox(height: 30),
            _buildSignInWithText(),
            const SizedBox(height: 30),
            _buildSocial(),
            const SizedBox(height: 20),
            _Anaccount(),
          ],
        ),
      ),
    );
  }

  // Text in Container
  Widget _buildWelcomeBackText() {
    return Text(
      "Welcome Back",
      style: TextStyle(
        color: AppColors.appColor,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextfield({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Padding(
      padding: AppSize.fieldPadding,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,

          suffixIcon: Icon(icon, color: AppColors.appColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.fieldBorder),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "$label is required"; // This will show error below the field
          }
          return null;
        },
      ),
    );
  }

  Widget _checkAndForgetPassword() {
    final LoginController controller = Get.find(); // Access the controller

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() {
            return Row(
              children: [
                Checkbox(
                  value:
                      controller
                          .isChecked
                          .value, // Get the value from controller
                  onChanged: (bool? value) {
                    controller.checkBoxFuc(
                      value ?? false,
                    ); // Call the controller function
                  },
                ),
                Text("Remember Me"),
              ],
            );
          }),
          TextButton(
            onPressed: () {
              Get.to(() => ForgetpasswordPage());
            },
            child: Text("Forget Password?"),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return ElevatedButton(
      onPressed: () {
        login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.appColor,
        minimumSize: Size(AppSize.fieldWidth, AppSize.fieldHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.borderRadius),
        ),
      ),
      child: Text("Login", style: TextStyle(color: AppColors.whteColors)),
    );
  }

  Widget _buildSocial() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImage.faceImage, width: 40, height: 40),
        const SizedBox(width: 40),
        Image.asset(AppImage.twitterImage, width: 40, height: 40),
        const SizedBox(width: 40),

        Image.asset(AppImage.gitImage, width: 40, height: 40),
        const SizedBox(width: 40),

        Image.asset(AppImage.googleImage, width: 40, height: 40),
      ],
    );
  }

  Widget _buildSignInWithText() {
    return Padding(
      padding: AppSize.lignPadding,
      child: Row(
        children: [
          Expanded(child: Divider(thickness: 1, indent: 0)),
          Padding(
            padding: AppSize.textlignPadding,
            child: Text("Sign in With"),
          ),
          Expanded(child: Divider(thickness: 1, indent: 0)),
        ],
      ),
    );
  }

  Widget _Anaccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don,t have Acoount?"),
        TextButton(
          onPressed: () {
            Get.to(() => SignupPage());
          },
          child: Text("SignUp"),
        ),
      ],
    );
  }
}
