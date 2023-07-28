import 'package:flutter/material.dart';
import 'package:flutter_application_1/clientManage.dart';
import 'package:flutter_application_1/fuelQuote.dart';
import 'package:flutter_application_1/quoteHistoryPage.dart';
import 'package:flutter_application_1/loginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homepage',
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _buildButton(context, 'Manage', Icons.people, ClientManagement()),
            _buildButton(
                context,
                'Fuel Quote',
                Icons.local_gas_station,
                FuelQuoteForm(
                  deliveryAddress: '',
                )), //********* remind to change if it does not update! */
            _buildButton(
                context, 'Quote History', Icons.history, QuoteHistoryPage()),
            _buildButton(context, 'Logout', Icons.logout, LoginApp()),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String title, IconData icon, Widget page) {
    return Container(
      height: 150, // Set the height of the button
      width: 150, // Set the width of the button
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon,
                size: 50), // You can adjust this value to resize your icon
            Text(title),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.teal[300],
        ),
      ),
    );
  }
}
