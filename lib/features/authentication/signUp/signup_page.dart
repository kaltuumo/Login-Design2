import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          const SizedBox(height: 10),
          _buildWelcomeBackText(),
          const SizedBox(height: 20),
          _buildTextfield(AppTexts.textFullname),
          const SizedBox(height: 20),

          _buildTextfield(AppTexts.textUsername),
          const SizedBox(height: 20),
          _buildTextfield(AppTexts.textPassword, isPassword: true),
          const SizedBox(height: 20),

          _checkAndForgetPassword(controller),
          const SizedBox(height: 20),
          _buildButton(),
          const SizedBox(height: 20),

          _buildSignInWithText(),
          const SizedBox(height: 20),
          _buildSocial(),
        ],
      ),
    );
  }

  // Text in Container
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

  Widget _checkAndForgetPassword(LoginController controller) {
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
                Text("I Agree The Proccessing"),
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
        // Get.to(() => LoginPage());
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
}
