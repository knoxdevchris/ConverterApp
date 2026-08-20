import 'package:flutter_test/flutter_test.dart';
import 'package:unit_converter/main.dart';

void main() {
  testWidgets('renders the converter controls', (WidgetTester tester) async {
    await tester.pumpWidget(const ConverterApp());

    expect(find.text('Measures Converter'), findsOneWidget);
    expect(find.text('Value'), findsOneWidget);
    expect(find.text('From'), findsOneWidget);
    expect(find.text('To'), findsOneWidget);
    expect(find.text('Convert'), findsOneWidget);
    expect(find.text('Enter a value to convert'), findsOneWidget);
  });
}
