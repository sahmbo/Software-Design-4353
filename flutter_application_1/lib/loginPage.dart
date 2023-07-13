import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/loginPageController.dart';
import 'package:flutter_application_1/model/loginPageModel.dart';
import 'package:flutter_application_1/fuelQuote.dart';
import 'package:flutter_application_1/clientReg.dart';
import 'dart:async';

void main() {
  runApp(
    const MaterialApp(
      title: 'My App',
      home: LoginApp(),
    ),
  );
}

class LoginApp extends StatefulWidget {
  const LoginApp({super.key});

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
    if (savedUser != null &&
        savedUser.username == username &&
        savedUser.password == password) {
      setState(() {
        errorMessage = '';
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const FuelQuoteForm(),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  gradient: LinearGradient(
                    colors: [Colors.blue[200]!, Colors.blue[100]!],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                key: ValueKey('UsernameField'),
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                key: ValueKey('PasswordField'),
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: handleLogin,
                      child: const Text('Login'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ClientRegistration(),
                          ),
                        );
                      },
                      child: const Text('Create an Account'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                errorMessage,
                style: const TextStyle(
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
