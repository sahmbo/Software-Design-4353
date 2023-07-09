import 'package:flutter/material.dart';
import 'controller/loginPageController.dart';
import 'model/loginPageRepo.dart';
import 'loginPage.dart'; // Import the LoginPage

class ClientRegistration extends StatefulWidget {
  @override
  _ClientRegistrationState createState() => _ClientRegistrationState();
}

class _ClientRegistrationState extends State<ClientRegistration> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Registration'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Username',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Password',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  User user = User(
                      username: _usernameController.text,
                      password: _passwordController.text);
                  await _userController.saveUser(user);

                  // Redirect to LoginPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginApp(),
                    ),
                  );
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
