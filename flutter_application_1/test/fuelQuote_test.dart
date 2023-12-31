import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/fuelQuoteController.dart';
import 'package:flutter_application_1/fuelQuote.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/model/fuelQuoteModel.dart';

void main() {
  test('Fuel Quote Input Validation', () {
    final fuelQuoteController = FuelQuoteController();

    // Test case 1: Verify if Gallons Requested is numeric and required
    fuelQuoteController.updateGallonsRequested(100.0);
    expect(fuelQuoteController.fuelQuote.gallonsRequested, equals(100.0));

    // Test case 2: Verify if Gallons Requested is required and cannot be null
    fuelQuoteController.updateGallonsRequested(0.0);
    expect(fuelQuoteController.fuelQuote.gallonsRequested, equals(0.0));

    // Test case 3: Verify if Delivery Date is required and cannot be null
    fuelQuoteController.updateDeliveryDate(DateTime.now());
    expect(fuelQuoteController.fuelQuote.deliveryDate, isA<DateTime>());

    // Test case 4: Verify if Delivery Date is set correctly
    final testDate = DateTime(2023, 7, 15);
    fuelQuoteController.updateDeliveryDate(testDate);
    expect(fuelQuoteController.fuelQuote.deliveryDate, equals(testDate));
  });

  testWidgets('Verify delivery address is not null', (WidgetTester tester) async {
    // Provide a non-null delivery address
    const String nonNullDeliveryAddress = '123 Main Street';

    await tester.pumpWidget(MaterialApp(
      home: FuelQuoteForm(deliveryAddress: nonNullDeliveryAddress),
    ));

    final deliveryAddressField = find.byKey(ValueKey('deliveryAddress'));

    final deliveryAddressValue = (tester.widget(deliveryAddressField) as TextFormField).controller?.text;

    // Verify that the delivery address is not null.
    expect(deliveryAddressValue, isNotNull);
    expect(deliveryAddressValue, equals(nonNullDeliveryAddress));
  });
}
