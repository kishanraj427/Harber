import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:harber/screens/signup_screen/get_singup.dart';

void main() {
  late SignUpController controller;

  setUp(() {
    Get.testMode = true;
    controller = SignUpController();
  });

  group('SignUpController', () {
    test('initial text controllers are empty', () {
      expect(controller.name.value.text, '');
      expect(controller.email.value.text, '');
      expect(controller.pass.value.text, '');
    });

    test('password is initially visible (passwordVisible is true)', () {
      expect(controller.passwordVisible.value, true);
    });

    test('isPress is initially false', () {
      expect(controller.isPress.value, false);
    });

    test('password visibility can be toggled', () {
      controller.passwordVisible.value = false;
      expect(controller.passwordVisible.value, false);

      controller.passwordVisible.value = true;
      expect(controller.passwordVisible.value, true);
    });

    test('isPress can be set to true during submission', () {
      controller.isPress.value = true;
      expect(controller.isPress.value, true);
    });

    test('text controllers accept input', () {
      controller.name.value.text = 'John Doe';
      controller.email.value.text = 'john@example.com';
      controller.pass.value.text = 'password123';

      expect(controller.name.value.text, 'John Doe');
      expect(controller.email.value.text, 'john@example.com');
      expect(controller.pass.value.text, 'password123');
    });
  });
}
