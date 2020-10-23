import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/Homepage.dart';
import 'package:homeautomation/Loginpage.dart';
import 'package:homeautomation/views/home_transition.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(Homeautomation());
}

class Homeautomation extends StatefulWidget {
  @override
  _HomeautomationState createState() => _HomeautomationState();
}

class _HomeautomationState extends State<Homeautomation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangeNotifierProvider(
        create: (context) => HomeTransition(),
        child: FutureBuilder<bool>(
          future: check_user(),
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return homepage();
            } else {
              return loginpage();
            }
          },
        ),
      ),
    );
  }

  Future<bool> check_user() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    if (firebaseUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
