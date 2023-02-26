import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:harber/app_color.dart';
import 'package:harber/screens/login_screen/login_screen.dart';
import 'package:harber/screens/signup_screen/signup_screen.dart';
import 'package:harber/screens/slide_screen/slide_controller.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class SlideScreen extends StatelessWidget {
  const SlideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SlideController controller = Get.put(SlideController());
    AutoScrollController scrollController = AutoScrollController();
    return Obx(() => Scaffold(
            body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 400),
                childAnimationBuilder: (widget) => SlideAnimation(
                    horizontalOffset: 50,
                    child: FadeInAnimation(
                      child: widget,
                    )),
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height / 1.5,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: scrollController,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return AutoScrollTag(
                            controller: scrollController,
                            key: ValueKey(index),
                            index: index,
                            child: slides(index: index, size: size));
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.prime2,
                    ),
                    width: size.width * 0.8,
                    height: size.width * 0.13,
                    child: TextButton(
                        onPressed: () {
                          if (controller.slideCount.value == 2) {
                            Get.off(
                              const SignUpScreen(),
                              curve: Curves.ease,
                              duration: const Duration(milliseconds: 750),
                            );
                          }
                          controller.slideCount++;
                          scrollController.scrollToIndex(
                              controller.slideCount.value,
                              duration: const Duration(milliseconds: 700),
                              preferPosition: AutoScrollPosition.begin);
                        },
                        child: Text(
                          controller.slideCount.value == 2 ? "Sign Up" : "Next",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.5,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    height: size.width * 0.13,
                    child: TextButton(
                        onPressed: () {
                          if (controller.slideCount.value == 2) {
                            Get.off(
                              const LogInScreen(),
                              curve: Curves.ease,
                              duration: const Duration(milliseconds: 750),
                            );
                          }
                          controller.slideCount.value = 2;
                          scrollController.scrollToIndex(2,
                              duration: const Duration(milliseconds: 700),
                              preferPosition: AutoScrollPosition.begin);
                        },
                        child: Text(
                          controller.slideCount.value == 2 ? "Log In" : "Skip",
                          style: const TextStyle(
                              fontSize: 16.5,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              )),
        )));
  }
}

Widget slides({required int index, required Size size}) {
  BoxDecoration boxDecoration = const BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      color: Colors.redAccent);

  String text = "";
  if (index == 0) {
    text =
        "Are you bored of waiting your turn?\nWe make it simple for you by enabling you to have a reserved seat!";
  } else if (index == 1) {
    text =
        "Explore and compare the top saloons in your neighborhood by searching and comparing services and prices with ratings!";
  } else if (index == 2) {
    text =
        "Sign up to connect with your favourite barber or locate the one that will best fit your needs!";
  }

  return SizedBox(
      width: size.width,
      height: size.height / 3.5,
      child: Column(children: [
        Image.asset(
          'assets/splash${index + 1}.png',
          fit: BoxFit.fitHeight,
        ),
        SizedBox(height: size.width / 20),
        Container(
          width: size.width,
          height: size.height / 4,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: size.width / 6),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              letterSpacing: 0.2,
              height: 1.6,
              wordSpacing: 0.5,
              fontWeight: FontWeight.w700,
              fontSize: 15.5,
            ),
          ),
        ),
        SizedBox(height: size.width / 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: index == 0 ? 13 : 7,
                height: 7,
                decoration: boxDecoration),
            const SizedBox(width: 7),
            Container(
                width: index == 1 ? 13 : 7,
                height: 7,
                decoration: boxDecoration),
            const SizedBox(width: 7),
            Container(
                width: index == 2 ? 13 : 7,
                height: 7,
                decoration: boxDecoration),
          ],
        ),
      ]));
}
