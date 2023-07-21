// model/quoteHistoryModel.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteHistoryModel {
  final String userName;
  final double gallonsRequested;
  final String deliveryAddress;
  final DateTime deliveryDate;
  final double suggestedPricePerGallon;
  final double totalAmountDue;

  Map<String, Object?> toJson() {
    return {
      'username': userName,
      'gallons_requested': gallonsRequested,
      'delivery_address': deliveryAddress,
      'delivery_date': Timestamp.fromDate(deliveryDate),
      'suggested_price_per_gallon': suggestedPricePerGallon,
      'total_amount_due': totalAmountDue,
    };
  }

  QuoteHistoryModel.fromJson(Map<String, Object?> json)
      : this(
          userName: json['username']! as String,
          gallonsRequested: json['gallons_requested']! as double,
          deliveryAddress: json['delivery_address']! as String,
          deliveryDate: (json['delivery_date']! as Timestamp).toDate(),
          suggestedPricePerGallon:
              json['suggested_price_per_gallon']! as double,
          totalAmountDue: json['total_amount_due']! as double,
        );

  QuoteHistoryModel(
      {required this.userName,
      required this.gallonsRequested,
      required this.deliveryAddress,
      required this.deliveryDate,
      required this.suggestedPricePerGallon,
      required this.totalAmountDue});
}
