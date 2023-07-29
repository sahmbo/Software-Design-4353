import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/loginPageController.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/model/loginPageModel.dart';
import 'package:flutter_application_1/fuelQuote.dart';
import 'package:flutter_application_1/clientReg.dart';
import 'dart:async';
import 'navigationPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primaryColor: Colors.teal[300],
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.blueGrey[300]),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal[300]!, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusColor: Colors.teal[300],
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: Colors.black,
        ),
      ),
      home: const LoginApp(),
    ),
  );
}

class LoginApp extends StatefulWidget {
  const LoginApp({Key? key}) : super(key: key);

  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserController _userController = UserController();
  String errorMessage = '';
  Timer? timer;

  void handleLogin() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    User? savedUser = await _userController.fetchUser(username, password);
    if (savedUser != null) {
      setState(() {
        errorMessage = '';
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MyApp(),
        ),
      );
    } else {
      setState(() {
        errorMessage = 'Username and/or Password incorrect';
      });

      if (timer != null) {
        timer!.cancel();
      }
      timer = Timer(const Duration(seconds: 10), () {
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),
        backgroundColor: Colors.teal[200],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50.0), // add some space at the top
              Icon(Icons.account_circle,
                  size: 100.0,
                  color: Colors.blueGrey[100]), // user icon at the top
              SizedBox(height: 50.0), // add some space below the icon
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  key: ValueKey('UsernameField'),
                  controller: _usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0), // add some space between textfields

// Here starts the Container with the Password TextField
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextField(
                  key: ValueKey('PasswordField'),
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0), // add some space below the password field
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: ElevatedButton(
                      key: ValueKey('LoginButton'),
                      onPressed: handleLogin,
                      child: Text('Login'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal[300],
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ClientRegistration(),
                          ),
                        );
                      },
                      child: Text('Create an Account'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.teal[300],
                        onPrimary: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.0), // add some space below the buttons
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
