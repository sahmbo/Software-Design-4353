 import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/clientManageController.dart';
import 'package:flutter_application_1/fuelQuote.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/quoteHistoryPage.dart';

import 'AppAuth.dart';
import 'loginPage.dart';
//import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const ClientManagementApp());
}

class ClientManagementApp extends StatelessWidget {
  const ClientManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ClientManagement(),
    );
  }
}

class ClientManagement extends StatefulWidget {
  const ClientManagement({super.key});

  @override
  _ClientManagementState createState() => _ClientManagementState();
}

class _ClientManagementState extends State<ClientManagement> {
  final List<String> items = [
    'AL',
    'AK',
    'AZ',
    'AR',
    'AS',
    'CA',
    'CO',
    'CT',
    'DE',
    'DC',
    'FL',
    'GA',
    'GU',
    'HI',
    'ID',
    'IL',
    'IN',
    'IA',
    'KS',
    'KY',
    'LA',
    'ME',
    'MD',
    'MA',
    'MI',
    'MN',
    'MS',
    'MO',
    'MT',
    'NE',
    'NV',
    'NH',
    'NJ',
    'NM',
    'NY',
    'NC',
    'ND',
    'MP',
    'OH',
    'OK',
    'OR',
    'PA',
    'PR',
    'RI',
    'SC',
    'SD',
    'TN',
    'TX',
    'TT',
    'UT',
    'VT',
    'VA',
    'VI',
    'WA',
    'WV',
    'WI',
    'WY'
  ];
  String? selectedItem;
  final _formKey = GlobalKey<FormState>();
  final ProfileController profileController = ProfileController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItem = 'AL';
  }

  @override
  void dispose() {
    fullNameController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    cityController.dispose();
    zipcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //nav bar
      appBar: AppBar(
        title: const Text('Client Profile'),
        actions: <Widget>[
          IconButton(
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
          IconButton(
            icon: Icon(Icons.local_gas_station),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FuelQuoteForm(),
                ),
              );
            },
          ),
          IconButton(
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
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginApp(),
                ),
              );
            },
          ),
        ],
      ),
      //end nav bar

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Full Name Field
                  TextFormField(
                    key: Key('fullName_field'), // Update the key value
                    controller: fullNameController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Full Name',
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust the padding
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // Address 1 Field
                  TextFormField(
                    key: Key('address1_field'), // Update the key value
                    controller: address1Controller,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address 1',
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust the padding
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // Address 2 Field
                  TextFormField(
                    key: Key('address2_field'), // Update the key value
                    controller: address2Controller,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Address 2',
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust the padding
                    ),
                  ),

                  const SizedBox(height: 10),

                  // City Field
                  TextFormField(
                    key: Key('city_field'), // Update the key value
                    controller: cityController,
                    maxLength: 100,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'City',
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust the padding
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  
                    DropdownButton<String>(
                      value: selectedItem,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedItem = newValue;
                          profileController.saveState(newValue ?? '');
                        });
                      },
                      isExpanded: true,
                      items: items.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  
                  const SizedBox(height: 10),

                  // Zipcode Field
                  TextFormField(
                    key: Key('Zipcode_field'), // Update the key value
                    controller: zipcodeController,
                    maxLength: 9,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Zipcode',
                      counterText: '',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Adjust the padding
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please fill out this field';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Do something when form is valid
                        profileController.saveFullName(fullNameController.text);
                        profileController.saveAddress_1(address1Controller.text);
                        profileController.saveAddress_2(address2Controller.text);
                        profileController.saveCity(cityController.text);
                        profileController.saveZipcode(zipcodeController.text);
                        //print(profileController.clientManage);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => FuelQuoteForm()),
                        // );
                        String fullName = fullNameController.text;
                        String address1 = address1Controller.text;
                        String address2 = address2Controller.text;
                        String city = cityController.text;
                        String zipcode = zipcodeController.text;
                        String? username = AppAuth.instance.userName;

                      // Create a new profile map with the user's input
                      final profile = {
                        "Username": username,
                        "Full Name": fullName,
                        "Address 1": address1,
                        "Address 2": address2,
                        "City": city,
                        "State": selectedItem,
                        "Zipcode": zipcode,
                      };

                      try {
                        // Save the profile data to Firestore
                        await FirebaseFirestore.instance.collection("Profiles").add(profile);

                        // After saving, navigate to the next screen or perform any other actions
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FuelQuoteForm()),
                        );
                      } catch (e) {
                        // Handle any errors that occurred during the save operation
                        //print("Error saving profile: $e");
                      }

                      } else {
                        // Alert user when form is invalid
                      }
                    },
                    child: const Text('Complete'),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}