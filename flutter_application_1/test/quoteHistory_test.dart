import 'package:flutter_application_1/controller/quoteHistoryController.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/model/quoteHistoryModel.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main() {
   test('Quote History Test', () async {


    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );

    final quoteHistoryController = QuoteHistoryController();
    List<QuoteHistoryModel> quoteHistoryModels = await quoteHistoryController.GetQuoteHistoryModels("adminuser");

    // Test case 1: Verify that quoteHistory is not null
    expect(quoteHistoryModels.length > 2, true);

    // Test case 2: Verify that quoteHistoryItems is not empty
    expect(quoteHistoryModels.isNotEmpty, true);
  });
}
