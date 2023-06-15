import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project/views/home.dart';
import 'package:project/views/login.dart';
import 'package:project/views/upload_gambar.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<User?>(
        future: Future(() async {
          return _auth.currentUser;
        }),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading"); // Show a loading screen while checking the login status
          } else {
            if (snapshot.hasData) {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                // Replace the current route with the home screen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              });
            } else {
              return LoginScreen(); // User is not logged in, show the login page
            }
          }
          return Container(); // Return an empty container by default
        },
      ),
    );
  }
}