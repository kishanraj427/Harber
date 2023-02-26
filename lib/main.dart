import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '';
import 'package:harber/screens/home_screen/home_screen.dart';
import 'package:harber/screens/slide_screen/slide_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Harber',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double size = Get.height * 0.4;

  @override
  void initState() {
    super.initState();
    User? user = FirebaseAuth.instance.currentUser;
    Timer(
        const Duration(milliseconds: 2500),
        () => Get.off(
              user == null ? const SlideScreen() : const MyHomeScreen(),
              curve: Curves.ease,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        body: Center(
      child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.2, end: 1),
          duration: const Duration(milliseconds: 10),
          builder: (BuildContext context, double val, _) {
            return AnimatedOpacity(
                duration: const Duration(milliseconds: 1200),
                opacity: val,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 1200),
                  width: size * val,
                  height: size * val,
                  child: Image.asset('assets/logo.png'),
                ));
          }),
    ));
  }
}
