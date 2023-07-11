import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'package:flutter_application_1/controller/fuelQuoteController.dart';


void main() {
  runApp(MaterialApp(
    home: const FuelQuoteForm(),
    theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 201, 173, 0.5)),
  ));
}

class FuelQuoteForm extends StatefulWidget {
  const FuelQuoteForm({super.key});

  @override
  _FuelQuoteFormState createState() => _FuelQuoteFormState();
}

class _FuelQuoteFormState extends State<FuelQuoteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FuelQuoteController _fuelQuoteController = FuelQuoteController();

  final TextEditingController _gallonsController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  final String _deliveryAddress = '123 Main Street'; // Replace with the actual client profile data

  bool _isSignOutHovered = false;
  bool _isCalculateHovered = false;

  void signOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginApp()),
    );
  }

  @override
  void dispose() {
    _gallonsController.dispose();
    _deliveryDateController.dispose();
    super.dispose();
  }

  void calculateTotalAmountDue() {
    double gallons = double.tryParse(_gallonsController.text) ?? 0.0;
    _fuelQuoteController.updateGallonsRequested(gallons);
    _fuelQuoteController.calculateTotalAmountDue();

    print('Gallons: ${_fuelQuoteController.fuelQuote.gallonsRequested}');
    print('Total amount due: ${_fuelQuoteController.fuelQuote.totalAmountDue}');
  }

  @override
  Widget build(BuildContext context) {
    var suggestedPrice = 0;
    var totalAmountDue = 0;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.45),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9EBC9F), Color(0xFF9EBC9F)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Fuel Quote Form',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white.withOpacity(1),
                      ),
                    ),
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _isSignOutHovered = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          _isSignOutHovered = false;
                        });
                      },
                      child: ElevatedButton(
                        onPressed: signOut,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: _isSignOutHovered
                              ? Colors.white
                              : const Color.fromRGBO(15, 76, 92, 1.0), backgroundColor: _isSignOutHovered
                              ? const Color.fromRGBO(255, 163, 165, 1.0)
                              : const Color.fromRGBO(255, 163, 165, 1.0),
                        ),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            color:
                                _isSignOutHovered ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                controller: _gallonsController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter the number of gallons requested.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Gallons Requested',
                ),
              ),
              TextFormField(
                controller: _deliveryDateController,
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  // Open a date picker and update the delivery date controller
                },
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please select the delivery date.';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Delivery Date',
                ),
              ),
              TextFormField(
                initialValue: _deliveryAddress,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Delivery Address',
                ),
              ),
              TextFormField(
                initialValue: suggestedPrice.toString(),
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Suggested Price / gallon',
                ),
              ),
              TextFormField(
                initialValue: totalAmountDue.toString(),
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Total Amount Due',
                ),
              ),
              MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isCalculateHovered = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isCalculateHovered = false;
                  });
                },
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      calculateTotalAmountDue();
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _isCalculateHovered
                        ? Colors.white
                        : const Color.fromRGBO(15, 76, 92, 1.0), backgroundColor: _isCalculateHovered
                        ? const Color.fromRGBO(255, 163, 165, 1.0)
                        : const Color.fromRGBO(255, 163, 165, 1.0),
                  ),
                  child: Text(
                    'Calculate',
                    style: TextStyle(
                      color: _isCalculateHovered ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}