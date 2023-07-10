class FuelQuote {
  double gallonsRequested;
  DateTime deliveryDate;
  double suggestedPrice;
  double totalAmountDue;
  String deliveryAddress;

  FuelQuote({
    required this.gallonsRequested,
    required this.deliveryDate,
    required this.suggestedPrice,
    required this.totalAmountDue,
    required this.deliveryAddress,
  });
}