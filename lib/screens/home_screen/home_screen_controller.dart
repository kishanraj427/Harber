import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var search = TextEditingController().obs;
  var salons = <Map>[].obs;
  var userName = "".obs;
  var storeList = <Map>[].obs;
  var location = 'vellore'.obs;
  var state = 'tamil nadu'.obs;
  var upcomingList = <Map>[].obs;
  RxInt i = 0.obs;

  @override
  void onInit() {
    FirebaseFirestore.instance
    .collection('users')
    .doc(FirebaseAuth.instance.currentUser?.email)
    .get()
    .then((value) {
      userName.value = value['name'];
    });
    loadData();
    loadUpcoming();
    super.onInit();
  }

  searchSalon(String val) {
    if (val.length == 0) {
      salons = storeList;
      return;
    }
    salons.clear();
    storeList.forEach((ele) {
      if (ele['name'].toLowerCase().contains(val.toLowerCase())) {
        salons.add(ele);
      }
    });
  }

  loadData() async {
    await FirebaseFirestore.instance
        .collection('salons')
        .doc(state.value)
        .collection(location.value)
        .get()
        .then((value) => {
              value.docChanges.forEach((element) {
                var salon = {
                  'name': element.doc['name'],
                  'image': element.doc['image'],
                  'loc': element.doc['loc'],
                  'rate': element.doc['rate']
                };
                salons.insert(0, salon);
                storeList.insert(0, salon);
              }),
            });
  }

  loadUpcoming() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.email)
        .collection('booking')
        .snapshots()
        .listen((event) {
      event.docChanges.forEach((element) {
        var salon = {
          'name': element.doc['name'],
          'loc': element.doc['loc'],
          'date': element.doc['date'].toDate(),
          'service': element.doc['service'],
          'time': element.doc['time']
        };
        print(salon['name']);
        upcomingList.add(salon);
      });
    });
  }
}
