import 'package:flutter/material.dart';

class FuelQuoteForm extends StatefulWidget {
  @override
  _FuelQuoteFormState createState() => _FuelQuoteFormState();
}

class _FuelQuoteFormState extends State<FuelQuoteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _gallonsController = TextEditingController();
  TextEditingController _deliveryDateController = TextEditingController();
  double _suggestedPrice = 0.0;
  double _totalAmountDue = 0.0;
  String _deliveryAddress = '123 Main Street'; // Replace with the actual client profile data

  @override
  void dispose() {
    _gallonsController.dispose();
    _deliveryDateController.dispose();
    super.dispose();
  }

  void calculateTotalAmountDue() {
    double gallons = double.tryParse(_gallonsController.text) ?? 0.0;
    double price = _suggestedPrice;
    _totalAmountDue = gallons * price;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Quote Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _gallonsController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the number of gallons requested.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Gallons Requested',
                ),
              ),
              TextFormField(
                controller: _deliveryDateController,
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  // Open a date picker and update the delivery date controller
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );

                  if (pickedDate != null) {
                    setState(() {
                      _deliveryDateController.text =
                          pickedDate.toString().split(' ')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please select the delivery date.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Delivery Date',
                ),
              ),
              TextFormField(
                initialValue: _deliveryAddress,
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Delivery Address',
                ),
              ),
              TextFormField(
                initialValue: _suggestedPrice.toString(),
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Suggested Price / gallon',
                ),
              ),
              TextFormField(
                initialValue: _totalAmountDue.toString(),
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Total Amount Due',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    calculateTotalAmountDue();
                    setState(() {});
                  }
                },
                child: Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FuelQuoteForm(),
  ));
}
