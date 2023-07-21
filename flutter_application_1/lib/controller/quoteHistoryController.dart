import 'package:flutter_application_1/AppAuth.dart';
import '../model/quoteHistoryModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteHistoryController {
  Future<List<QuoteHistoryModel>> GetQuoteHistoryModels(
      String? userName) async {
    try {
      if (userName == null) {
        return [];
      }
      final quotesRef = FirebaseFirestore.instance
          .collection('QuoteForms')
          .withConverter<QuoteHistoryModel>(
            fromFirestore: (snapshot, _) =>
                QuoteHistoryModel.fromJson(snapshot.data()!),
            toFirestore: (quoteHistoryItem, _) => quoteHistoryItem.toJson(),
          );

      // Get docs from collection reference
      List<QuoteHistoryModel> quoteHistoryItems = await quotesRef
          .where('username', isEqualTo: userName)
          .get()
          .then((value) => value.docs
              .map((e) => e.data())
              .toList()
              .cast<QuoteHistoryModel>());

      return quoteHistoryItems;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
