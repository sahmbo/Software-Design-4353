import 'package:flutter/material.dart';
import 'clientReg.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Navigator(
        pages: [
          MaterialPage(
            child: LoginApp(),
          ),
        ],
        onPopPage: (route, result) => route.didPop(result),
      ),
    );
  }
}

class LoginApp extends StatefulWidget {
  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
  String errorMessage = '';
  Timer? timer;

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
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 10,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              ElevatedButton(
                onPressed: handleLogin,
                child: Text('Login'),
              ),
              SizedBox(height: 20), // Add a space between the two buttons
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 20), // Add a space below the error message
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
      ),
    );
  }
}
