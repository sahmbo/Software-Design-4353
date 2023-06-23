import 'package:flutter/material.dart';

class ClientRegistration extends StatelessWidget {
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Username',
                ),
              ),
              SizedBox(height: 20), // Add space below the username
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Password',
                ),
              ),
              SizedBox(height: 20), // Add space below the password
              ElevatedButton(
                onPressed: () {
                  // Add registration functionality here
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
