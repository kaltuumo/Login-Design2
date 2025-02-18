import 'package:get/get.dart';

class LoginController extends GetxController {
  var isChecked = false.obs;

  void checkBoxFuc(bool value) {
    isChecked.value = value;
  }
}
