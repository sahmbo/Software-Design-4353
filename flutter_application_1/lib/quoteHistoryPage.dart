import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/quoteHistoryController.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _DataTable createState() => _DataTable();
}

class _DataTable extends State<MyApp> {
  final QuoteHistoryController _quoteHistoryController =
      QuoteHistoryController();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          // appBar: AppBar(
          //   title: Text('Quote History'),
          // ),
          body: ListView(children: <Widget>[
        const Center(
            child: Text(
          'Fuel Quote History',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        )),
        DataTable(
          columns: const [
            DataColumn(
                label: Text('Gallons Requested',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Delivery Address',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Delivery Date',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Suggested Price / gallon',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
            DataColumn(
                label: Text('Total Amount Due',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
          ],
          rows: _quoteHistoryController.quoteHistory.quoteHistoryItems
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
