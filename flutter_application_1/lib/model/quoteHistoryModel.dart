// model/quoteHistoryModel.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class QuoteHistoryModel {
  final String userName;
  final double gallonsRequested;
  final String deliveryAddress;
  final String deliveryDate;
  final double suggestedPricePerGallon;
  final double totalAmountDue;
  final String state;

  Map<String, Object?> toJson() {
    return {
      'username': userName,
      'gallonsRequested': gallonsRequested,
      'deliveryAddress': deliveryAddress,
      'state' : state,
      'deliveryDate': deliveryDate,
      'suggestedPrice': suggestedPricePerGallon,
      'totalAmountDue': totalAmountDue,
    };
  }

  QuoteHistoryModel.fromJson(Map<String, Object?> json)
      : this(
          userName: json['username']! as String,
          state: json['state']! as String,
          gallonsRequested: json['gallonsRequested']! as double,
          deliveryAddress: json['deliveryAddress']! as String,
          deliveryDate: json['deliveryDate']! as String,
          suggestedPricePerGallon:
              json['suggestedPrice']! as double,
          totalAmountDue: json['totalAmountDue']! as double,
        );

  QuoteHistoryModel(
      {required this.userName,
      required this.state,
      required this.gallonsRequested,
      required this.deliveryAddress,
      required this.deliveryDate,
      required this.suggestedPricePerGallon,
      required this.totalAmountDue});
}
