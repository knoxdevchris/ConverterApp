import 'package:flutter_test/flutter_test.dart';
import 'package:unit_converter/conversion.dart';

void main() {
  group('convertValue', () {
    test('converts grams to kilograms correctly', () {
      expect(convertValue(1000, 'grams', 'kilograms'), closeTo(1, 1e-9));
    });

    test('converts miles to feet correctly', () {
      expect(convertValue(1, 'miles', 'feet'), closeTo(5280, 1e-9));
    });

    test('allows zero as a valid value', () {
      expect(convertValue(0, 'meters', 'feet'), 0);
    });

    test('rejects conversions across measurement types', () {
      expect(convertValue(1, 'meters', 'kilograms'), isNull);
    });
  });
}
