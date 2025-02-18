import 'package:flutter/widgets.dart';

class AppSize {
  static late Size mediaSize;

  static void init(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
  }

  static const double fieldHeight = 50; // TextField & Button height
  static const double fieldWidth = 350; // Full width

  // Buttons login and Sign Up With Onbording Screen
  static const BorderRadius bothBorder = BorderRadius.only(
    topLeft: Radius.circular(30),

    // Buttons SingUp With Onbording Screen
  );
  //Font Weight in All Ap Text Font Weight
  static const FontWeight appTxtFontweight = FontWeight.bold;

  // Border Radiud in App
  static const double borderRadius = 30;

  //borderRadius With Textfelds
  static const double fieldBorder = 10;

  /// Two Alignes in Text Sign In With Markay Geesaha Kasoo dhawaanaayann
  static const EdgeInsets lignPadding = EdgeInsets.symmetric(horizontal: 30);

  //   /// Two Alignes in Text Sign In With Markay qoraalka Kasoo dhawaanaayann
  static const EdgeInsets textlignPadding = EdgeInsets.symmetric(
    horizontal: 10,
  );

  /// Padding With textFields
  static const EdgeInsets fieldPadding = EdgeInsets.symmetric(horizontal: 16);

  // Container border In Top Left And Right
  static const BorderRadius kTopRounderBiedr = BorderRadius.only(
    topLeft: Radius.circular(30),
    topRight: Radius.circular(30),
  );

  // Container For Intuu kor iyo geesaha Kasoo sikanaayo
  static const double containerTopPosition = 250;
  static const double containerLeftPosition = 0;
  static const double containerRightPosition = 0;

  // Text In welcom position And textFileds position
  static const double textTopPosition = 290;
  static const double textLeftPosition = 20;
}
