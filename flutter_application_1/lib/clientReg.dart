import 'package:flutter/material.dart';
import 'controller/loginPageController.dart';
import 'model/loginPageModel.dart';
import 'loginPage.dart'; // Import the LoginPage

class ClientRegistration extends StatefulWidget {
  const ClientRegistration({super.key});

  @override
  _ClientRegistrationState createState() => _ClientRegistrationState();
}

class _ClientRegistrationState extends State<ClientRegistration> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _userController = UserController();

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Registration'),
        backgroundColor: Colors.teal[200],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Username',
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Password',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  if (username.length < 4 || username.length > 12) {
                    showErrorDialog(
                        'Username should be between 4 and 12 characters long');
                    return;
                  }

                  if (password.length < 6 || password.length > 12) {
                    showErrorDialog(
                        'Password should be between 6 and 12 characters long');
                    return;
                  }

                  User user = User(username: username, password: password);
                  await _userController.saveUser(user);

                  // Redirect to LoginPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginApp(),
                    ),
                  );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
