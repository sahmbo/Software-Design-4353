import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/loginPage.dart';
import 'package:flutter_application_1/clientReg.dart';

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

  testWidgets('Create an Account button reroutes to ClientRegistration page',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: LoginApp(),
      routes: {
        '/clientRegistration': (BuildContext context) => ClientRegistration(),
      },
    ));

    await tester.tap(find.text('Create an Account'));
    await tester.pumpAndSettle();

    expect(find.byType(ClientRegistration), findsOneWidget);
  });

  final Finder redTextFinder = find.byWidgetPredicate(
    (Widget widget) => widget is Text && widget.style?.color == Colors.red,
    description: 'Text with red color',
  );

  testWidgets(
      'Error message appears when fields are empty and Login is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: LoginApp()));

    await tester.tap(find.byKey(ValueKey('LoginButton')));
    await tester.pump();

    expect(redTextFinder, findsOneWidget);
  });
}
