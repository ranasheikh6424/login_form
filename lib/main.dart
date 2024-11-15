import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Corrected the call to currentPlatform
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register the user and navigate to the Login screen
  Future<void> registerUser() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill in all fields")));
      return;
    }

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

      // Store user data in Firestore
      await _firestore.collection("users").doc(userCredential.user?.uid).set({
        "name": nameController.text.trim(),
        "email": emailController.text.trim(),
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful")));

      // Navigate to login screen after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? "An Error occurred")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Chat'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    registerUser();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// This is the page you would navigate to after registration
class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Next Page")),
      body: const Center(child: Text("Welcome to the next page!")),
    );
  }
}
