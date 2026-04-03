import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harber/app_color.dart';

void main() {
  group('AppColor', () {
    test('prime1 has correct color value', () {
      expect(AppColor.prime1, const Color.fromARGB(255, 0, 187, 255));
    });

    test('prime2 has correct color value', () {
      expect(AppColor.prime2, const Color.fromARGB(255, 0, 149, 255));
    });

    test('prime3 has correct color value', () {
      expect(AppColor.prime3, const Color.fromARGB(255, 98, 20, 255));
    });

    test('background has correct color value', () {
      expect(AppColor.background, const Color.fromARGB(255, 239, 239, 239));
    });

    test('all colors are fully opaque', () {
      expect(AppColor.prime1.alpha, 255);
      expect(AppColor.prime2.alpha, 255);
      expect(AppColor.prime3.alpha, 255);
      expect(AppColor.background.alpha, 255);
    });
  });
}
