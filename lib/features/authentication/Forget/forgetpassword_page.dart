import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          _buildTextfield(AppTexts.textFullname),
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

  Widget _buildTextfield(String label, {bool isPassword = false}) {
    return Padding(
      padding: AppSize.fieldPadding,
      child: TextField(
        obscureText: isPassword,
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
        Get.to(() => LoginPage()); // Navigate to the Login page
      },
      child: Text(
        "Back to Login",
        style: TextStyle(color: AppColors.appColor, fontSize: 16),
      ),
    );
  }
}
