import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'controller/fuelQuoteController.dart';
import 'quoteHistoryPage.dart';
import 'clientManage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'AppAuth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: const FuelQuoteForm(
      deliveryAddress: '',
      address2: '',
      city: '',
      state: '',
      zipcode: '',
    ),
    theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(255, 201, 173, 0.5)),
  ));
}

class FuelQuoteForm extends StatefulWidget {
  final String
      deliveryAddress; // Add a parameter to receive the delivery address
  final String address2;
  final String city;
  final String state;
  final String zipcode;

  const FuelQuoteForm(
      {required this.deliveryAddress,
      required this.address2,
      required this.city,
      required this.state,
      required this.zipcode,
      Key? key})
      : super(key: key); // remind to change!!!!!!

  @override
  _FuelQuoteFormState createState() => _FuelQuoteFormState();
}

class _FuelQuoteFormState extends State<FuelQuoteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FuelQuoteController _fuelQuoteController = FuelQuoteController();

  final TextEditingController _gallonsController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  //final String _deliveryAddress = '123 Main Street'; // Replace with the actual client profile data

  bool _isSignOutHovered = false;
  bool _isCalculateHovered = false;
  bool _isSubmitHovered = false;

  Future<void> _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginApp()),
        (route) => false, // Remove all routes from the stack
      );
    } catch (e) {
      //print("");
    }
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

  String getFormattedDeliveryAddress() {
    // Concatenate the address components into a single string
    return "${widget.deliveryAddress}, ${widget.address2}, ${widget.city}, ${widget.state}, ${widget.zipcode}";
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Get the form values
      double gallons = double.tryParse(_gallonsController.text) ?? 0.0;
      String deliveryDate = _deliveryDateController.text;
      String deliveryAddress = widget.deliveryAddress;
      String state = ''; // Replace with the actual state value

      // Create a map to store the data
      Map<String, dynamic> formData = {
        'gallonsRequested': gallons,
        'deliveryDate': deliveryDate,
        'deliveryAddress': deliveryAddress,
        'state': state,
        'username': AppAuth.instance.userName,
        'suggestedPrice': 0.0,
        'totalAmountDue': 0.0,

      };

      // Get a reference to the Firestore collection
      CollectionReference formCollection =
          FirebaseFirestore.instance.collection('FuelQuotes');

      // Add the document to the collection
      formCollection
          .add(formData)
          .then((value) => print('Form data added to Firestore'))
          .catchError((error) => print('Error adding form data: $error'));
    }
  }

  @override
  Widget build(BuildContext context) {
    var suggestedPrice = 0;
    var totalAmountDue = 0;
    //var _submitForm;
    return Scaffold(
      //nav bar
      appBar: AppBar(
        title: const Text('Fuel Quote Form'),
        actions: <Widget>[
          Tooltip(
            message: 'Profile',
            child: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ClientManagementApp(),
                  ),
                );
              },
            ),
          ),
          Tooltip(
            message: 'Fuel Quote',
            child: IconButton(
              icon: Icon(Icons.local_gas_station),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FuelQuoteForm(
                      deliveryAddress: '',
                      address2: '',
                      city: '',
                      state: '',
                      zipcode: '',
                    ),
                  ),
                );
              },
            ),
          ),
          Tooltip(
            message: 'History',
            child: IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuoteHistoryPage(),
                  ),
                );
              },
            ),
          ),
          Tooltip(
            message: 'Logout',
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: _handleLogout,
            ),
          ),
        ],
      ),
      //end nav bar

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
                initialValue:
                    getFormattedDeliveryAddress(), // Use the provided delivery address here
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'Delivery Address',
                ),
              ),
              TextFormField(
                //initialValue: widget.State, // Use the provided delivery address here
                enabled: false,
                decoration: const InputDecoration(
                  labelText: 'State',
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
              SizedBox(height: 20.0),
              SizedBox(
                height: 50, // Set a fixed height for the SizedBox
                child: MouseRegion(
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
                      primary: _isCalculateHovered
                          ? const Color.fromRGBO(77, 182, 172, 1)
                          : const Color.fromRGBO(77, 182, 172, 1),
                      onPrimary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text(
                      'Get Quote',
                      style: TextStyle(
                        color:
                            _isCalculateHovered ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 50, // Set a fixed height for the SizedBox
                child: MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isSubmitHovered = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isSubmitHovered = false;
                    });
                  },
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    /*{
                      if (_formKey.currentState?.validate() ?? false) {
                        calculateTotalAmountDue();
                        setState(() {});
                      }
                    },*/
                    style: ElevatedButton.styleFrom(
                      primary: _isSubmitHovered
                          ? const Color.fromRGBO(77, 182, 172, 1)
                          : const Color.fromRGBO(77, 182, 172, 1),
                      onPrimary: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: _isSubmitHovered ? Colors.white : Colors.black,
                      ),
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
