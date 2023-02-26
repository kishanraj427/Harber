import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:harber/app_color.dart';
import 'package:harber/screens/payment_screen/payment_controller.dart';
import 'package:lottie/lottie.dart';
import 'package:upi_india/upi_india.dart';
import '../home_screen/home_screen.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  var controller = Get.put(PaymentController());

  @override
  Widget build(BuildContext context) {
    controller.name.value = Get.arguments[0];
    controller.loc.value = Get.arguments[1];
    controller.date.value = Get.arguments[2];
    controller.time.value = Get.arguments[3];
    return Obx(
      () => Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            'Payment',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          physics: const BouncingScrollPhysics(),
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 400),
            childAnimationBuilder: (widget) => SlideAnimation(
              horizontalOffset: 50,
              child: FadeInAnimation(
                child: widget,
              )
            ),  
            children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 3),
                        color: Colors.black38,
                        blurRadius: 7,
                      )
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Salon: ",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            controller.name.value,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Date: ",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.date.string.substring(0, 10),
                          style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Time: ",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          controller.time.value,
                          style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 3),
                        color: Colors.black38,
                        blurRadius: 7,
                      )
                    ]),
                child: Column(
                  children: [
                    const Text(
                      'Services',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Text(
                      '₹${controller.prices[controller.service.value]}/${controller.services[controller.service.value]}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Radio(
                        groupValue: controller.service.value == 0 ? 1 : 0,
                        value: 1,
                        onChanged: ((value) => {
                              controller.service.value = 0,
                            }),
                      ),
                      title: Text(controller.services[0]),
                    ),
                    ListTile(
                      leading: Radio(
                        groupValue: controller.service.value == 1 ? 1 : 0,
                        value: 1,
                        onChanged: ((value) => {
                              controller.service.value = 1,
                            }),
                      ),
                      title: Text(controller.services[1]),
                    ),
                    ListTile(
                      leading: Radio(
                        groupValue: controller.service.value == 2 ? 1 : 0,
                        value: 1,
                        onChanged: ((value) => {
                              controller.service.value = 2,
                            }),
                      ),
                      title: Text(controller.services[2]),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Container(
                height: Get.height / 2.5,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(2, 3),
                        color: Colors.black38,
                        blurRadius: 7,
                      )
                    ]),
                child: Column(
                  children: [
                    const Text(
                      'Payment Option',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: controller.apps.length,
                          itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      side: const BorderSide(width: 0.8)),
                                  onTap: () async {
                                    var response = await UpiIndia()
                                        .startTransaction(
                                            app: controller.apps[index],
                                            receiverUpiId: '6203465594@ybl',
                                            receiverName: 'Raj Kishan Prasad',
                                            transactionRefId: "9876543210",
                                            amount: controller.prices[
                                                controller.service.value])
                                        .then((value) => {
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser?.email)
                                                  .collection('booking')
                                                  .doc(
                                                      DateTime.now().toString())
                                                  .set({
                                                'name': controller.name.value,
                                                'loc': controller.loc.value,
                                                'date': controller.date.value,
                                                'time': controller.time.value,
                                                'service': controller.services[
                                                    controller.service.value]
                                              }).then((value) => {
                                                        Get.generalDialog(
                                                          pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) {
                                                            return Lottie.asset(
                                                                'assets/payment.json',
                                                                repeat: false);
                                                          },
                                                        ),
                                                        Timer(
                                                          const Duration(
                                                              milliseconds: 900),
                                                          () => Get.offAll(
                                                                const MyHomeScreen(),
                                                                curve: Curves.ease,
                                                                duration: const Duration(milliseconds: 750),
                                                              ))
                                                      }),
                                            });
                                    //if (response.status! == UpiPaymentStatus.SUCCESS) {
                                  },
                                  leading: Image.memory(
                                    controller.apps[index].icon,
                                    fit: BoxFit.fill,
                                  ),
                                  title: Text(
                                    controller.apps[index].name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500),
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                              )),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),)
    );
  }
}
