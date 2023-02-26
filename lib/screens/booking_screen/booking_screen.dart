import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:harber/app_color.dart';
import 'package:harber/screens/booking_screen/booking_controller.dart';
import 'package:harber/screens/payment_screen/payment_screen.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(BookingController(),
        permanent: true, tag: Get.arguments[0]['name']);
    controller.name.value = Get.arguments[0]['name'];
    controller.loc.value = Get.arguments[0]['loc'];
    controller.rate.value = Get.arguments[0]['rate'];

    return Obx(() => Scaffold(
          backgroundColor: AppColor.background,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
              //elevation: 0,
              foregroundColor: Colors.black,
              backgroundColor: Colors.white,
              title: Text(
                controller.name.value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )),
          body: SafeArea(
            child: ListView(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
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
                          const Text(
                            'Location',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            controller.loc.value,
                            style: const TextStyle(
                              color: Colors.black,
                              //fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              color: Colors.green[900],
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  '${controller.rate.value}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.white),
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
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
                          const Text(
                            'Select Date & Time',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: Get.height / 3,
                            child: CalendarDatePicker(
                            initialDate: controller.date.value,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 7)),
                            onDateChanged: (value) {
                              controller.date.value = value;
                            },
                            ),
                          ),
                        ],
                      ) 
                        
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Container(
                      height: Get.height / 2,
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: ToggleButtons(
                            borderWidth: 2,
                            borderRadius: BorderRadius.circular(20),
                            fillColor: Colors.blue[50],
                            direction: Axis.vertical,
                            isSelected: controller.isSelected,
                            onPressed: ((index) {
                              if (controller.isSelected[index]) {
                                controller.isSelected[index] = false;
                                return;
                              }
                              controller.itemSelected(index);
                              Get.bottomSheet(BottomSheet(
                                enableDrag: false,
                                elevation: 3,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                onClosing: (() {}),
                                builder: (context) {
                                  return Wrap(children: [
                                    Container(
                                      padding: const EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: AnimationConfiguration.toStaggeredList(
                                          duration: const Duration(milliseconds: 400),
                                          childAnimationBuilder: (widget) => SlideAnimation(
                                            verticalOffset: 50,
                                            child: FadeInAnimation(
                                              child: widget,
                                            )
                                          ),  
                                          children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller.date
                                                    .toString()
                                                    .substring(0, 10),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Time: ${controller.time[index].data}\nAvailabe slots : 10',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 15),
                                              ),
                                            ],
                                          ),
                                          MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            elevation: 0,
                                            color: AppColor.prime2,
                                            onPressed: (() =>
                                                Get.to(PaymentScreen(),
                                                    arguments: [
                                                      controller.name.value,
                                                      controller.loc.value,
                                                      controller.date.value,
                                                      controller.time[index].data
                                                    ],
                                                    curve: Curves.ease,
                                                    duration: const Duration(milliseconds: 750),
                                                )),
                                            child: Row(
                                              children: const [
                                                Text(
                                                  'Continue',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Icon(
                                                  Icons.fast_forward_rounded,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),)
                                  ]);
                                },
                              ));
                            }),
                            selectedBorderColor: AppColor.prime2,
                            borderColor: Colors.grey,
                            children: controller.time,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ),
        ));
  }
}
