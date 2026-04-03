import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:harber/screens/payment_screen/payment_controller.dart';

void main() {
  late PaymentController controller;

  setUp(() {
    Get.testMode = true;
    controller = PaymentController();
  });

  group('PaymentController', () {
    test('initial values are empty/default', () {
      expect(controller.name.value, '');
      expect(controller.loc.value, '');
      expect(controller.time.value, '');
      expect(controller.payment.value, false);
    });

    test('has 3 services', () {
      expect(controller.services.length, 3);
    });

    test('services are Hair Cut, Shave, Facial', () {
      expect(controller.services[0], 'Hair Cut');
      expect(controller.services[1], 'Shave');
      expect(controller.services[2], 'Facial');
    });

    test('has 3 prices matching services', () {
      expect(controller.prices.length, 3);
    });

    test('prices are correct', () {
      expect(controller.prices[0], 100.0);
      expect(controller.prices[1], 50.0);
      expect(controller.prices[2], 70.0);
    });

    test('default service is 0 (Hair Cut)', () {
      expect(controller.service.value, 0);
    });

    test('service selection can be changed', () {
      controller.service.value = 1;
      expect(controller.service.value, 1);
      expect(controller.services[controller.service.value], 'Shave');
      expect(controller.prices[controller.service.value], 50.0);
    });

    test('selecting Facial gives correct price', () {
      controller.service.value = 2;
      expect(controller.services[controller.service.value], 'Facial');
      expect(controller.prices[controller.service.value], 70.0);
    });

    test('name and loc can be set', () {
      controller.name.value = 'Urban Salon';
      controller.loc.value = 'Vellore';
      controller.time.value = '10:00 AM - 10:30 AM';

      expect(controller.name.value, 'Urban Salon');
      expect(controller.loc.value, 'Vellore');
      expect(controller.time.value, '10:00 AM - 10:30 AM');
    });

    test('date defaults to today', () {
      final now = DateTime.now();
      expect(controller.date.value.year, now.year);
      expect(controller.date.value.month, now.month);
      expect(controller.date.value.day, now.day);
    });

    test('payment status can be toggled', () {
      expect(controller.payment.value, false);
      controller.payment.value = true;
      expect(controller.payment.value, true);
    });

    test('apps list is initially empty', () {
      expect(controller.apps.length, 0);
    });
  });
}
