import '../model/quoteHistoryModel.dart';

class QuoteHistoryController {
  final QuoteHistory _quoteHistory = QuoteHistory(
    quoteHistoryItems: [
      QuoteHistoryItem(
        gallonsRequested: 1.2,
        deliveryAddress: '123 Main Street',
        deliveryDate: DateTime.now(),
        suggestedPricePerGallon: 0.0,
        totalAmountDue: 0.0,
      ),
      QuoteHistoryItem(
        gallonsRequested: 2.2,
        deliveryAddress: '223 Main Street',
        deliveryDate: DateTime.now(),
        suggestedPricePerGallon: 0.0,
        totalAmountDue: 0.0,
      ),
      QuoteHistoryItem(
        gallonsRequested: 3.3,
        deliveryAddress: '323 Main Street',
        deliveryDate: DateTime.now(),
        suggestedPricePerGallon: 0.0,
        totalAmountDue: 0.0,
      ),
      QuoteHistoryItem(
        gallonsRequested: 4.4,
        deliveryAddress: '423 Main Street',
        deliveryDate: DateTime.now(),
        suggestedPricePerGallon: 0.0,
        totalAmountDue: 0.0,
      ),
    ],
  );

  QuoteHistory get quoteHistory => _quoteHistory;
}
