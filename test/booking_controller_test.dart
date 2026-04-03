import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:harber/screens/booking_screen/booking_controller.dart';

void main() {
  late BookingController controller;

  setUp(() {
    Get.testMode = true;
    controller = BookingController();
  });

  group('BookingController', () {
    test('initial values are set correctly', () {
      expect(controller.name.value, '');
      expect(controller.loc.value, '');
      expect(controller.rate.value, 0.0);
    });

    test('has 24 time slots', () {
      expect(controller.time.length, 24);
    });

    test('has 24 selection states', () {
      expect(controller.isSelected.length, 24);
    });

    test('all time slots are initially unselected', () {
      for (var selected in controller.isSelected) {
        expect(selected, false);
      }
    });

    test('itemSelected selects the correct index', () {
      controller.itemSelected(5);
      expect(controller.isSelected[5], true);
    });

    test('itemSelected deselects all other slots', () {
      controller.itemSelected(5);
      for (int i = 0; i < 24; i++) {
        if (i == 5) {
          expect(controller.isSelected[i], true);
        } else {
          expect(controller.isSelected[i], false);
        }
      }
    });

    test('itemSelected switches selection to new index', () {
      controller.itemSelected(3);
      expect(controller.isSelected[3], true);

      controller.itemSelected(10);
      expect(controller.isSelected[3], false);
      expect(controller.isSelected[10], true);
    });

    test('itemSelected toggles off when same index tapped again', () {
      controller.itemSelected(7);
      expect(controller.isSelected[7], true);

      controller.itemSelected(7);
      expect(controller.isSelected[7], false);
    });

    test('only one time slot can be selected at a time', () {
      controller.itemSelected(0);
      controller.itemSelected(12);
      controller.itemSelected(23);

      int selectedCount = controller.isSelected.where((s) => s == true).length;
      expect(selectedCount, 1);
      expect(controller.isSelected[23], true);
    });

    test('date defaults to today', () {
      final now = DateTime.now();
      expect(controller.date.value.year, now.year);
      expect(controller.date.value.month, now.month);
      expect(controller.date.value.day, now.day);
    });

    test('date can be updated', () {
      final futureDate = DateTime(2026, 5, 15);
      controller.date.value = futureDate;
      expect(controller.date.value, futureDate);
    });

    test('name and loc can be updated', () {
      controller.name.value = 'Urban Cuts';
      controller.loc.value = 'Main Street, Vellore';
      controller.rate.value = 4.5;

      expect(controller.name.value, 'Urban Cuts');
      expect(controller.loc.value, 'Main Street, Vellore');
      expect(controller.rate.value, 4.5);
    });
  });
}
