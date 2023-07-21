import 'package:flutter_application_1/AppAuth.dart';
import '../model/quoteHistoryModel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteHistoryController {
  final QuoteHistory _quoteHistory = QuoteHistory(
    
  );

  QuoteHistory get quoteHistory => _quoteHistory;

  Future<List<QuoteHistoryItem>?> GetQuoteHistory() async {
    try {


    final quotesRef = FirebaseFirestore.instance.collection('QuoteForm').withConverter<QuoteHistoryItem>(
      fromFirestore: (snapshot, _) => QuoteHistoryItem.fromJson(snapshot.data()!),
      toFirestore: (quoteHistoryItem, _) => quoteHistoryItem.toJson(),
    );

      // Get docs from collection reference
    List<QuoteHistoryItem> quoteHistoryItems = await quotesRef.where('username', isEqualTo: AppAuth.instance.userName).get().then((value) => value.docs.map((e) => e.data()).toList().cast<QuoteHistoryItem>());

      return quoteHistoryItems;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
