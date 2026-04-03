import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:harber/screens/login_screen/get_login.dart';

void main() {
  late LogInController controller;

  setUp(() {
    Get.testMode = true;
    controller = LogInController();
  });

  group('LogInController', () {
    test('initial text controllers are empty', () {
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

    test('isPress can be set to true during login', () {
      controller.isPress.value = true;
      expect(controller.isPress.value, true);
    });

    test('text controllers accept input', () {
      controller.email.value.text = 'test@example.com';
      controller.pass.value.text = 'secure123';

      expect(controller.email.value.text, 'test@example.com');
      expect(controller.pass.value.text, 'secure123');
    });
  });
}
