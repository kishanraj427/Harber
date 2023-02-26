import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



class LogInController extends GetxController {
  var email = TextEditingController().obs;
  var pass = TextEditingController().obs;
  var passwordVisible = true.obs;
  var isPress = false.obs;
}
