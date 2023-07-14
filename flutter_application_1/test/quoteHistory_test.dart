import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/quoteHistoryController.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/model/quoteHistoryModel.dart';

void main() {
  test('Quote History Test', () {
    final quoteHistoryController = QuoteHistoryController();

    // Test case 1: Verify that quoteHistory is not null
    expect(quoteHistoryController.quoteHistory.isNull,false);

    // Test case 2: Verify that quoteHistoryItems is not empty
    expect(quoteHistoryController.quoteHistory.quoteHistoryItems.isNotEmpty ,true);
  });
} 