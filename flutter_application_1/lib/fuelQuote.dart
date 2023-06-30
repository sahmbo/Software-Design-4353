import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'dart:async';
import 'clientReg.dart';

void main() {
  runApp(MaterialApp(
    home: FuelQuoteForm(),
  ));
}

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.45),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  gradient: LinearGradient(
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
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Sign out the user here, if necessary.
                        // Then, navigate to the LoginApp page.
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginApp()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(255, 163, 165, 1.0),
                        onPrimary: Color.fromRGBO(15, 76, 92, 1.0),
                      ),
                      child: Text('Sign Out'),
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
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(255, 163, 165, 1.0),
                  onPrimary: Color.fromRGBO(15, 76, 92, 1.0),
                ),
                child: Text('Calculate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginApp extends StatefulWidget {
  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  String errorMessage = ''; // Stores the error message
  Timer? timer; // Timer for error message duration

  void handleLogin() {
    String username = ''; // Get the username value from the TextField
    String password = ''; // Get the password value from the TextField

    if (username == 'admin' && password == 'password') {
      // Clear the error message
      setState(() {
        errorMessage = '';
      });

      // Perform successful login logic
    } else {
      // Show the error message
      setState(() {
        errorMessage = 'Username and/or Password incorrect';
      });

      // Start the timer to clear the error message after 10 seconds
      if (timer != null) {
        timer!.cancel();
      }
      timer = Timer(Duration(seconds: 10), () {
        setState(() {
          errorMessage = '';
        });
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Login Container
              Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [Colors.blue[200]!, Colors.blue[100]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20), // Add space below the Login Container
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Login Button
                    ElevatedButton(
                      onPressed: handleLogin,
                      child: Text('Login'),
                    ),
                    SizedBox(width: 10), // Add space between the buttons
                    // Create an Account Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ClientRegistration(),
                          ),
                        );
                      },
                      child: Text('Create an Account'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20), // Add space below the buttons
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}