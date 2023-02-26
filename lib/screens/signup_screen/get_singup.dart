import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



class SignUpController extends GetxController {
  var name = TextEditingController().obs;
  var email = TextEditingController().obs;
  var pass = TextEditingController().obs;
  var passwordVisible = true.obs;
  var isPress = false.obs;
}

