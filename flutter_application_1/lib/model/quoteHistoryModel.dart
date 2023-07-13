// model/quoteHistoryModel.dart

class QuoteHistory{
  final List<QuoteHistoryItem> quoteHistoryItems;

  QuoteHistory({required this.quoteHistoryItems});
}

class QuoteHistoryItem{
  final double gallonsRequested;
  final String deliveryAddress;
  final DateTime deliveryDate;
  final double suggestedPricePerGallon;
  final double totalAmountDue;

  QuoteHistoryItem({required this.gallonsRequested, required this.deliveryAddress, required this.deliveryDate, required this.suggestedPricePerGallon, required this.totalAmountDue});
}