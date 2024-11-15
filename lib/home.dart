import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_form/main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;

  login() async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      final User? user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email!, password: password!))
          .user;

      if (user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        print("Error");
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
