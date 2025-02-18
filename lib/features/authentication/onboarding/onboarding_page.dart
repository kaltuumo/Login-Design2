import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/utils.dart';
import 'package:login_design2/features/authentication/Login/login_page.dart';
import 'package:login_design2/features/authentication/signUp/signup_page.dart';

import 'package:login_design2/utilities/constants/colors.dart';
import 'package:login_design2/utilities/constants/images.dart';
import 'package:login_design2/utilities/constants/sizes.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whteColors,
        image: DecorationImage(
          image: AssetImage(AppImage.bgImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),

          Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 30,
              fontWeight: AppSize.appTxtFontweight,
              color: Colors.white, // Adjust color as needed
              decoration: TextDecoration.none,
              inherit: false,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Welcome To Our Page',
            style: TextStyle(
              fontSize: 14,
              fontWeight: AppSize.appTxtFontweight,
              color: Colors.white, // Adjust color as needed
              decoration: TextDecoration.none,
              inherit: false,
            ),
          ),

          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: _buildButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // Si buttons ay u dhex taagan yihiin
      children: [
        // Button 1 (Login)
        Container(
          width: 150,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.whteColors, // Background color
            borderRadius: AppSize.bothBorder,
          ),
          child: TextButton(
            onPressed: () {
              // Function for Login button
              Get.to(() => LoginPage());
            },
            child: Text(
              "Login",
              style: TextStyle(
                color: AppColors.appColor, // Text color
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 70), // Boos u dhaxeeya buttons
        // Button 2 (Sign Up)
        Container(
          width: 150,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.whteColors, // Background color
            borderRadius: AppSize.bothBorder,
          ),
          child: TextButton(
            onPressed: () {
              // Function for Sign Up button
              Get.to(() => SignupPage());
            },
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: AppColors.appColor, // Text color
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
