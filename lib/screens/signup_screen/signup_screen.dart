import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:harber/app_color.dart';
import 'package:harber/screens/home_screen/home_screen.dart';
import '../login_screen/login_screen.dart';
import 'get_singup.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    return Obx(() => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children:  [
            Container(
              width: Get.width,
              padding: const EdgeInsets.only(
                top: 70,
                bottom: 25,
                left: 25,
                right: 25,
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        AppColor.prime2,
                        AppColor.prime1,
                      ],
                      tileMode: TileMode.repeated,
                      stops: const [0.3, 0.7],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 400),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                      child: widget,
                    )
                  ),   
                  children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 400),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50,
                    child: FadeInAnimation(
                      child: widget,
                    )
                  ),   
            children: [
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Create Account,",
                    style: TextStyle(
                        letterSpacing: 0.7,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "Sign up to get started!",
                    style: TextStyle(
                        letterSpacing: 0.7,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                ],
              ),))
            ),
            Stack(
              children: [
                Container(
                  color: AppColor.prime2,
                  height: Get.height / 3,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(50))),
                  padding: const EdgeInsets.only(
                    top: 25,
                    bottom: 0,
                    left: 25,
                    right: 25,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 400),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        verticalOffset: 50,
                        child: FadeInAnimation(
                          child: widget,
                        )
                      ),   
                      children:[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ignore: avoid_unnecessary_containers
                          const SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: controller.name.value,
                            style: const TextStyle(
                                letterSpacing: 1, fontWeight: FontWeight.w500),
                            textCapitalization: TextCapitalization.words,
                            decoration: const InputDecoration(
                              label: Text(
                                "Full Name",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: controller.email.value,
                            style: const TextStyle(
                                letterSpacing: 1, fontWeight: FontWeight.w500),
                            decoration: const InputDecoration(
                              label: Text(
                                "Email Id",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: controller.pass.value,
                            style: const TextStyle(
                                letterSpacing: 1, fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                                label: const Text(
                                  "Password",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.passwordVisible.value =
                                          !controller.passwordVisible.value;
                                    },
                                    icon: Icon(
                                      controller.passwordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.black54,
                                    ))),
                            obscureText: controller.passwordVisible.value,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () async {
                              controller.isPress.value =
                                  !controller.isPress.value;

                              if (controller.name.value.text == "" ||
                                  controller.email.value.text == "" ||
                                  controller.pass.value.text == "") {
                                Get.snackbar('Registration Failed!!',
                                    'Please fill all the details!!',
                                    snackPosition: SnackPosition.BOTTOM,
                                    borderColor: Colors.red,
                                    borderWidth: 4,
                                    backgroundColor: Colors.white,
                                    dismissDirection: DismissDirection.down);
                                controller.isPress.value = false;
                              } else {
                                try {
                                  UserCredential userCredential =
                                      await FirebaseAuth
                                          .instance
                                          .createUserWithEmailAndPassword(
                                              email:
                                                  controller.email.value.text,
                                              password:
                                                  controller.pass.value.text);
                                  Map<String, String> uData = <String, String>{
                                    "uid": userCredential.user!.uid,
                                    "name": controller.name.value.text,
                                    "email": controller.email.value.text
                                  };
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(userCredential.user!.email)
                                      .set(uData);
                                  Get.offAll(
                                    const MyHomeScreen(),
                                    curve: Curves.ease,
                                    duration: const Duration(milliseconds: 750),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  Get.snackbar('Registration Failed!!',
                                      e.code.replaceAll('-', ' '),
                                      snackPosition: SnackPosition.BOTTOM,
                                      borderColor: Colors.red,
                                      borderWidth: 4,
                                      backgroundColor: Colors.white,
                                      dismissDirection: DismissDirection.down);
                                  controller.isPress.value = false;
                                } catch (e) {
                                  print(e);
                                }
                              }
                            },
                            child: Container(
                              height: Get.height / 15,
                              width: Get.width / 1.5,
                              padding: EdgeInsets.symmetric(
                                  vertical: 13, horizontal: Get.width / 4),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColor.prime2,
                                        AppColor.prime1,
                                      ],
                                      tileMode: TileMode.repeated,
                                      stops: const [0.3, 0.7],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Center(
                                child: controller.isPress.value
                                    ? const FittedBox(
                                        fit: BoxFit.contain,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 5,
                                        ),
                                      )
                                    : const Text('Sign Up',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have Account ? ",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.black87),
                          ),
                          GestureDetector(
                            onTap: (() => Get.off(const LogInScreen(),
                                curve: Curves.ease)),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),)
              ],
            ),
          ],
        )));
  }
}
