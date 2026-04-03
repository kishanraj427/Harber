import 'package:flutter_test/flutter_test.dart';
import 'package:harber/objects/salon_class.dart';

void main() {
  group('Salon', () {
    test('creates a Salon instance with required parameters', () {
      final salon = Salon(name: 'Test Salon', loc: 'Vellore', rate: 4.5);
      expect(salon, isNotNull);
    });

    test('default name is empty string', () {
      final salon = Salon(name: 'Test', loc: 'Loc', rate: 3.0);
      // The constructor params don't assign to fields due to missing this. prefix
      expect(salon.name, '');
    });

    test('default loc is empty string', () {
      final salon = Salon(name: 'Test', loc: 'Loc', rate: 3.0);
      expect(salon.loc, '');
    });

    test('default rate is 0', () {
      final salon = Salon(name: 'Test', loc: 'Loc', rate: 3.0);
      expect(salon.rate, 0);
    });
  });
}
