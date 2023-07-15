import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/clientManage.dart';

void main() {
  testWidgets('Address 2 field is optional', (WidgetTester tester) async {
    await tester.pumpWidget(ClientManagementApp());

    Finder address2Field = find.byKey(Key('address2_field'));

    // Enter values in the Address 1 and City fields
    await tester.enterText(find.byKey(Key('fullName_field')), 'John Doe');
    await tester.enterText(find.byKey(Key('address1_field')), '123 Main St');
    await tester.enterText(find.byKey(Key('city_field')), 'New York');
    await tester.enterText(find.byKey(Key('Zipcode_field')), '70000');

    // Leave the Address 2 field empty
    await tester.enterText(address2Field, '');

    // Tap the Complete button
    await tester.tap(find.text('Complete'));
    await tester.pump();

    // Expect no error message for the Address 2 field
    expect(find.text('Please fill out this field'), findsNothing);
  });
}



