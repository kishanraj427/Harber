import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  var name = "".obs;
  var loc = "".obs;
  var rate = 0.0.obs;
  var date = DateTime.now().obs;
  var time = [
    const Text(
      '09:00 AM - 09:30 AM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '09:30 AM - 10:00 AM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '10:00 AM - 10:30 AM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '10:30 AM - 11:00 AM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '11:00 AM - 11:30 AM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '11:30 AM - 12:00 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '12:00 PM - 12:30 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '12:30 PM - 01:00 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '01:00 PM - 01:30 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '03:00 PM - 03:30 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '02:30 PM - 03:00 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '03:00 PM - 03:30 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '02:30 PM - 03:00 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '03:00 PM - 03:30 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '03:30 PM - 04:00 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '04:00 PM - 04:30 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '04:30 PM - 04:00 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '05:00 PM - 05:30 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '06:30 PM - 06:00 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '06:00 PM - 06:30 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '06:30 PM - 07:00 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      '07:00 PM - 07:30 PM',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      style: TextStyle(fontWeight: FontWeight.bold),
      '07:30 PM - 08:00 PM',
    ),
    const Text(
      style: TextStyle(fontWeight: FontWeight.bold),
      '08:00 PM - 08:30 PM',
    )
  ].obs;
  var isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ].obs;

  itemSelected(int index) {
    for (int i = 0; i < 24; i++) {
      if (i == index && isSelected[i] == false) {
        isSelected[i] = true;
      } else {
        isSelected[i] = false;
      }
    }
  }
}
