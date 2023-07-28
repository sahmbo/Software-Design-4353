import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/fuelQuoteModel.dart';
//import 'package:flutter/material.dart';

class FuelQuoteController {
  final FuelQuote _fuelQuote = FuelQuote(
    gallonsRequested: 0.0,
    deliveryDate: DateTime.now(),
    suggestedPrice: 0.0,
    totalAmountDue: 0.0,
    deliveryAddress: '',
  );

  void updateGallonsRequested(double value) {
    _fuelQuote.gallonsRequested = value;
  }

  void updateDeliveryDate(DateTime date) {
    _fuelQuote.deliveryDate = date;
  }

  void calculateTotalAmountDue() {
    _fuelQuote.totalAmountDue = _fuelQuote.gallonsRequested * _fuelQuote.suggestedPrice;
  }

  void saveFuelQuoteToFirestore(String username) async {
    final fuelQuoteData = {
      "Username": username,
      "Gallons Requested": _fuelQuote.gallonsRequested,
      "Delivery Date": _fuelQuote.deliveryDate,
      "Suggested Price": _fuelQuote.suggestedPrice,
      "Total Amount Due": _fuelQuote.totalAmountDue,
      "Delivery Address": _fuelQuote.deliveryAddress,
    };


    try {
      await FirebaseFirestore.instance.collection("FuelQuotes").doc(username).set(fuelQuoteData);
      // Alternatively, you can use .doc() if you want to specify a document ID: .doc("fuel_quote_id").set(fuelQuoteData);
    } catch (e) {
      // Handle any errors that occurred during the save operation
      //print("Error saving fuel quote: $e");
    }
  }

  FuelQuote get fuelQuote => _fuelQuote;
}