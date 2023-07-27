import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/clientManage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  testWidgets('Profile Data is saved to the database', (WidgetTester tester) async {
    // Generate a unique test collection path for this test
    final testCollectionPath = 'test_profiles_${DateTime.now().millisecondsSinceEpoch}';

    // Create a new ProfileRepository instance
    final ProfileRepository profileRepository = ProfileRepository();

    // Build the ClientManagement widget and pass the unique collection path
    await tester.pumpWidget(ClientManagementApp(testCollectionPath: testCollectionPath));

    // Enter values in the fields
    await tester.enterText(find.byKey(Key('fullName_field')), 'John Doe');
    await tester.enterText(find.byKey(Key('address1_field')), '123 Main St');
    await tester.enterText(find.byKey(Key('city_field')), 'New York');
    await tester.enterText(find.byKey(Key('Zipcode_field')), '70000');

    // Leave the Address 2 field empty
    await tester.enterText(find.byKey(Key('address2_field')), '');

    // Tap the Complete button
    await tester.tap(find.text('Complete'));
    await tester.pumpAndSettle();

   // Save the profile data using the ProfileRepository instance
    await profileRepository.saveProfileData(testCollectionPath, 'test_username', profile);

    // Retrieve the saved profile data from the Firestore database
    final savedProfile =
        await FirebaseFirestore.instance.collection(testCollectionPath).doc('test_username').get();

    // Verify if the profile data is correctly saved to the database
    expect(savedProfile.data(), {
      'Username': 'test_username',
      'Full Name': 'John Doe',
      'Address 1': '123 Main St',
      'Address 2': '',
      'City': 'New York',
      'State': 'AL',
      'Zipcode': '70000',
    });
  });
}



