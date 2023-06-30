import 'package:flutter/material.dart';

void main() {
  runApp(ClientManagementApp());
}

class ClientManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ClientManagement(),
    );
  }
}

class ClientManagement extends StatefulWidget {
  @override
  _ClientManagementState createState() => _ClientManagementState();
}

class _ClientManagementState extends State<ClientManagement> {
  final List<String> items = ['AL','AK','AZ','AR','AS','CA','CO','CT','DE','DC','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PA','PR','RI','SC','SD','TN','TX','TT','UT','VT','VA','VI','WA','WV','WI','WY'];
  String? selectedItem;
   //final _formKey = GlobalKey<FormState>();
   //final _scaffoldKey = GlobalKey<ScaffoldState>();
   //final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // TextEditingController fullNameController = TextEditingController();
  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool showFullNameError = false;

  @override
  void initState() {
    super.initState();
    selectedItem = 'AL'; // Initialize the selected value
  }

  // String? _validateZipcode(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter a Zipcode';
  //   }
  //   if (value.length < 5) {
  //     return 'Zipcode must be at least 5 characters';
  //   }
  //   return null; // Return null if the validation is successful
  // }

  // @override
  // void dispose(){
  //   fullNameController.dispose();
  //   super.dispose();
  // }

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     // Form is valid, proceed with the submission
  //     // Add your logic here for form submission
  //     // For example, you can access the form values:
  //     final String fullName = fullNameController.text;
  //     final String selectedState = selectedItem!;
      
  //     // Perform the necessary actions with the form data
  //     print('Full Name: $fullName');
  //     print('Selected State: $selectedState');

  //     // Reset the form
  //     fullNameController.clear();
  //     selectedItem = 'AL';
  //     _formKey.currentState!.reset();
  //     setState(() {
  //       showFullNameError = false; // Reset the error display
  //     });
  //   } else {
  //     // Form validation failed, show error for Full Name TextField
  //     setState(() {
  //       showFullNameError = true;
  //     });
  //   }
  // }

  // String? _validateFullName(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please enter your Full Name';
  //   }
  //   return null; // Return null if the validation is successful
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Client Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // if (showFullNameError)
              //     Text(
              //       'Please enter your Full Name',
              //       style: TextStyle(
              //         color: Colors.red,
              //       ),
              //     ),
              TextFormField(
                maxLength: 50, //sets the max char to 50
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full Name',
                  counterText: '', //hides the char count text
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter name";
                  }else{
                    return null;
                  }
                },
              ),

              SizedBox(height: 10), // Add space below the FullName
              TextFormField(
                maxLength: 100, //sets the max char to 100
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address 1',
                  counterText: '', //hides the char count text
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter address";
                  }else{
                    return null;
                  }
                },
              ),

              SizedBox(height:10), //Add space below Address 1
              TextField(
                maxLength: 100, //sets the max char to 100
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address 2',
                  counterText: '', // hides the char count text
                ),
              ),

              SizedBox(height:10), //Add space below Address 2
              TextFormField(
                maxLength: 100, //sets the max char to 100
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'City',
                  counterText: '', //hides the char count text
                ),
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter city";
                  }else{
                    return null;
                  }
                },
              ),

              SizedBox(height: 10), //Add space below City
              DropdownButton<String>(
                //decoration: InputDecoration(),
                value: selectedItem,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue; // Update the selected value
                  });
                  // Handle dropdown value change
                },
                items: items.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              SizedBox(height: 10), //add space below state
              TextFormField(
                maxLength: 9, //set the max char to 9
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Zipcode',
                  counterText: '', //Hides the char count text
                ),
                //validator: _validateZipcode,
                validator: (value){
                  if(value!.isEmpty){
                    return "Enter Zipcode";
                  }else{
                    return null;
                  }
                },
              ),

              SizedBox(height: 10), //add space below Zipcode
              ElevatedButton(
                onPressed: () {
                  // if(_formKey.currentState!.validate()){
                  //   _scaffoldKey.currentState.showSnackBar(new SnackBar(
                  //   content: new Text('Hello this is snackbar!'))
                  //   );
                  // }
                },
                child: Text('Complete'),
              ),
            ]
          ),
        ),
      ),
    );
  }
}