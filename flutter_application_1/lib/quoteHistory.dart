import 'package:flutter/material.dart'; 
  
void main() {runApp(MyApp());}  
  
class MyApp extends StatefulWidget {  
  @override  
  _DataTableExample createState() => _DataTableExample();  
}  
  
class _DataTableExample extends State<MyApp> {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: Scaffold(  
          // appBar: AppBar(  
          //   title: Text('Quote History'),  
          // ),  
          body: ListView(children: <Widget>[  
            Center(  
                child: Text(  
                  'Fuel Quote History',  
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),  
                )),  
            DataTable(  
              columns: [  
                DataColumn(label: Text(  
                    'Gallons Requested',  
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)  
                )),  
                DataColumn(label: Text(  
                    'Delivery Address',  
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)  
                )),  
                DataColumn(label: Text(  
                    'Delivery Date',  
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)  
                )),  
                 DataColumn(label: Text(  
                    'Suggested Price / gallon',  
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)  
                )),  
                 DataColumn(label: Text(  
                    'Total Amount Due',  
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)  
                )),  
                 
              ],  
              rows: [  
                DataRow(cells: [  
                  DataCell(Text('1')),  
                  DataCell(Text('Houston, TX')),  
                  DataCell(Text('07/02/2023')), 
                  DataCell(Text('45.00')),  
                  DataCell(Text('164.00')),  
                ]),  
                DataRow(cells: [  
                  DataCell(Text('5')),  
                  DataCell(Text('Dallas, TX')),  
                  DataCell(Text('08/12/2023')),
                  DataCell(Text('35.00')),  
                  DataCell(Text('150.00')),   
                ]),  
                DataRow(cells: [  
                  DataCell(Text('10')),  
                  DataCell(Text('Austin, TX')),  
                  DataCell(Text('09/05/2023')),
                  DataCell(Text('30.00')),  
                  DataCell(Text('120.00')),   
                ]),   
              ],  
            ),  
          ])  
      ),  
    );  
  }  
}  