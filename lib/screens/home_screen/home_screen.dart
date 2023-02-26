import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:harber/app_color.dart';
import 'package:harber/screens/booking_screen/booking_screen.dart';
import 'package:harber/screens/home_screen/home_screen_controller.dart';


class MyHomeScreen extends StatelessWidget {
  const MyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return Obx(() => Scaffold(
          backgroundColor: AppColor.prime2,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 0, right: 15, bottom: 0, top: 0),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1.5, 2),
                                  color: Colors.black12,
                                  blurRadius: 3,
                                )
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: Colors.black12,
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.account_circle_rounded,
                                      color: Colors.white,
                                )),
                                Text(
                                  controller.userName.value,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.w700, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                left: 0, right: 15, bottom: 0, top: 0),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              color: Colors.black12,
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(1.5, 2),
                                  color: Colors.black12,
                                  blurRadius: 3,
                                )
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    )),
                                Text(
                                  controller.location.value.capitalizeFirst!,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      controller.upcomingList.isEmpty ? Container(): const SizedBox(height: 15,),
                      controller.upcomingList.isEmpty ? Container():
                        SizedBox(
                          height: Get.width/4.5,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.upcomingList.length,
                            itemBuilder: (context, index) => 
                            //DateTime.now().compareTo(controller.upcomingList[index]['date']) > -1 ? Container():
                            AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 400),
                              child: SlideAnimation(
                                horizontalOffset: 50,
                                child: FadeInAnimation(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Container(
                                      width: Get.width*0.9,
                                      height: Get.width/4.5,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Upcoming ",
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.bold
                                                ),
                                              ),
                                              Text(
                                                controller.upcomingList[index]['service'],
                                                style: TextStyle(
                                                  color: AppColor.prime2,
                                                  fontWeight: FontWeight.bold
                                                ),)
                                            ],
                                          ),
                                          Text(
                                            controller.upcomingList[index]['name'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  //const Text("Date: "),
                                                  Text(
                                                    controller.upcomingList[index]['date'].toString().substring(0,10),
                                                    style: TextStyle(
                                                      color: Colors.teal[900],
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  //const Text("Time: "),
                                                  Text(
                                                    controller.upcomingList[index]['time'],
                                                    style: TextStyle(
                                                      color: Colors.teal[900],
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,)
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, top: 20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const[
                              BoxShadow(
                                offset: Offset(1.5, 2),
                                color: Colors.black38,
                                blurRadius: 3,
                              )
                            ],
                          ),
                          child: TextField(
                            controller: controller.search.value,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColor.background,
                              prefixIcon:
                                  Icon(Icons.search, color: AppColor.prime2),
                              hintText: "Search...",
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w500),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                  borderSide: BorderSide.none
                              ),
                            ),
                            style: const TextStyle(fontWeight: FontWeight.w500),
                            onChanged: ((value) => controller.searchSalon(value)),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.salons.length,
                              itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 400),
                                child: SlideAnimation(
                                  verticalOffset: 50,
                                  child: FadeInAnimation(
                                    child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () => Get.to(
                                                const BookingScreen(),
                                                arguments: [
                                                    {
                                                      "name": controller.salons[index]['name'],
                                                      "loc": controller.salons[index]['loc'],
                                                      "rate": controller.salons[index]['rate'],
                                                    }
                                                ],
                                                curve: Curves.ease,
                                                duration: const Duration(milliseconds: 750),
                                              ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                 boxShadow: const [
                                                  BoxShadow(
                                                    offset: Offset(1.5, 2),
                                                    color: Colors.black38,
                                                    blurRadius: 3,
                                                  )
                                                ],
                                                color: AppColor.background,
                                                borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: 
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(20),
                                                    child: Image.network(
                                                      controller.salons[index]['image'],
                                                      height: Get.width/4.5,
                                                      width: Get.width/4.5,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      height: Get.width/4.5,
                                                      padding: const EdgeInsets.all(12),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            controller.salons[index]['name'],
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                          Text(
                                                            controller.salons[index]['loc'],
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                            style: const TextStyle(
                                                              color: Colors.black54,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w500
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  const Icon(
                                                                    Icons.star_rounded,
                                                                    color: Colors.amber,
                                                                  ),
                                                                  const SizedBox(width: 5,),
                                                                  Text(
                                                                    controller.salons[index]['rate'].toString(),
                                                                    style: const TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(right: 10.0),
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons.discount_outlined,
                                                                      color: AppColor.prime2,
                                                                      size: 20,
                                                                    ),
                                                                    const SizedBox(width: 5,),
                                                                    const Text(
                                                                      '20%',
                                                                      style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.bold
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
