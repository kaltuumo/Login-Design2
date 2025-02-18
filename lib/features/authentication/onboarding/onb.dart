import "package:flutter/material.dart";
import "package:get/get_core/get_core.dart";
import "package:get/get_navigation/get_navigation.dart";
import "package:login_design2/features/authentication/Login/login_page.dart";
import "package:login_design2/utilities/constants/colors.dart";
import "package:login_design2/utilities/constants/images.dart";
import "package:login_design2/utilities/constants/sizes.dart";

class Onb extends StatefulWidget {
  const Onb({super.key});

  @override
  State<Onb> createState() => _OnbState();
}

class _OnbState extends State<Onb> {
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
      child: Text("Get Started", style: TextStyle(color: AppColors.whteColors)),
    );
  }
}
