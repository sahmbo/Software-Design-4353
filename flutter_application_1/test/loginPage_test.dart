import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginPage.dart';

void main() {
  testWidgets('Username and password fields are empty',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginApp()));

    Finder usernameField = find.byKey(ValueKey('UsernameField'));
    Finder passwordField = find.byKey(ValueKey('PasswordField'));

    await tester.enterText(usernameField, 'test');
    await tester.enterText(passwordField, 'test');

    expect(find.text('test'), findsNWidgets(2));

    await tester.enterText(usernameField, '');
    await tester.enterText(passwordField, '');

    expect(find.text('test'), findsNothing);
  });
}
