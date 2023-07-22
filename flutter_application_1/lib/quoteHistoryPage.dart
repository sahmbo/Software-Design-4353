import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/quoteHistoryController.dart';
import 'package:flutter_application_1/model/quoteHistoryModel.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/quoteHistoryPage.dart';
import 'package:flutter_application_1/clientManage.dart';
import 'package:flutter_application_1/fuelQuote.dart';
import 'package:flutter_application_1/loginPage.dart';
import 'AppAuth.dart';

void main() {
  runApp(const QuoteHistoryPage());
}

class QuoteHistoryPage extends StatefulWidget {
  const QuoteHistoryPage({super.key});

  @override
  _DataTable createState() => _DataTable();
}

class _DataTable extends State<QuoteHistoryPage> {
  final QuoteHistoryController _quoteHistoryController =
      QuoteHistoryController();

  List<QuoteHistoryModel> _quoteHistory = [];
  final String? userName = AppAuth.instance.userName;

  void loadData() async {
    final quoteHistory = await _quoteHistoryController.GetQuoteHistoryModels(
        userName);
    setState(() {
      _quoteHistory = quoteHistory;
    });
  }

    @override
  void dispose() {
    super.dispose();
  }

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    loadData();
    return MaterialApp(
      home: Scaffold(
          //nav bar
          appBar: AppBar(
            title: const Text('Quote History'),
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
                      builder: (context) => FuelQuoteForm(deliveryAddress: '',), //remind to change in case!!!
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
          body: ListView(children: <Widget>[
            DataTable(
              columns: const [
                DataColumn(
                    label: Text('Gallons Requested',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Delivery Address',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Delivery Date',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Suggested Price / gallon',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Total Amount Due',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold))),
              ],
              rows: _quoteHistory
                  .map(
                    (p) => DataRow(cells: [
                      DataCell(
                        Text(p.gallonsRequested.toString()),
                      ),
                      DataCell(
                        Text(p.deliveryAddress),
                      ),
                      DataCell(
                        Text(dateFormat.format(p.deliveryDate)),
                      ),
                      DataCell(
                        Text(p.suggestedPricePerGallon.toString()),
                      ),
                      DataCell(
                        Text(p.totalAmountDue.toString()),
                      ),
                    ]),
                  )
                  .toList(),
            ),
          ])),
    );
  }
}