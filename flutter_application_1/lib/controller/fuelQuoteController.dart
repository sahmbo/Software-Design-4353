import 'package:flutter_application_1/model/loginPageModel.dart';
import '../model/fuelQuoteModel.dart';
//import 'package:flutter/material.dart';


class FuelQuoteController {
  FuelQuote _fuelQuote = FuelQuote(
    gallonsRequested: 0.0,
    deliveryDate: DateTime.now(),
    suggestedPrice: 0.0,
    totalAmountDue: 0.0,
    deliveryAddress: '123 Main Street',
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

  FuelQuote get fuelQuote => _fuelQuote;
}
