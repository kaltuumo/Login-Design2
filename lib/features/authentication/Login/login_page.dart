import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_design2/features/authentication/Forget/forgetpassword_page.dart';
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
          const SizedBox(height: 20),
          _buildTextfield(AppTexts.textUsername, Appicons.userIcon),
          const SizedBox(height: 20),
          _buildTextfield(
            AppTexts.textPassword,
            Appicons.passIcon,
            isPassword: true,
          ),
          const SizedBox(height: 20),

          _checkAndForgetPassword(),
          const SizedBox(height: 20),
          _buildButton(),
        ],
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

  Widget _buildTextfield(
    String label,
    IconData icon, {
    bool isPassword = false,
  }) {
    return Padding(
      padding: AppSize.fieldPadding,
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.fieldBorder),
          ),
        ),
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
        Get.to(() => LoginPage());
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
}
