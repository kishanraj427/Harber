import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:harber/screens/slide_screen/slide_controller.dart';

void main() {
  late SlideController controller;

  setUp(() {
    Get.testMode = true;
    controller = SlideController();
  });

  group('SlideController', () {
    test('initial slideCount is 0', () {
      expect(controller.slideCount.value, 0);
    });

    test('slideCount can be incremented', () {
      controller.slideCount.value = 1;
      expect(controller.slideCount.value, 1);
    });

    test('slideCount can go through all slides', () {
      controller.slideCount.value = 0;
      expect(controller.slideCount.value, 0);

      controller.slideCount.value = 1;
      expect(controller.slideCount.value, 1);

      controller.slideCount.value = 2;
      expect(controller.slideCount.value, 2);
    });

    test('slideCount can be reset to 0', () {
      controller.slideCount.value = 2;
      controller.slideCount.value = 0;
      expect(controller.slideCount.value, 0);
    });
  });
}
