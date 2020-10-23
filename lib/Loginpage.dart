import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeautomation/Homepage.dart';
import 'package:homeautomation/SignupPage.dart';
import 'package:homeautomation/VerificationDialog.dart';
import 'package:homeautomation/views/home_transition.dart';
import 'package:provider/provider.dart';

class loginpage extends StatefulWidget {
  @override
  _loginpageState createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String username;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String _email;
    String _pass;
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => HomeTransition(),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        child: Image(
                          image: AssetImage('assets/logo.jpeg'),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontFamily: 'Montserrat Bold',
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ".",
                        style: TextStyle(
                            fontFamily: 'Montserrat Bold',
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                  Text(
                    "Control, Organise and Manage your Home appliances with One or two taps",
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "EMAIL",
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat Bold',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    controller: emailcontroller,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "PASSWORD",
                        labelStyle: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Montserrat Bold',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black))),
                    controller: passwordcontroller,
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    obscureText: true,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  Container(
                    height: 60,
                    child: Material(
                      borderRadius: BorderRadius.circular(30),
                      shadowColor: Colors.black,
                      color: Colors.black,
                      elevation: 7.0,
                      child: GestureDetector(
                        onTap: () async {
                          _email = emailcontroller.text.toString().trim();
                          _pass = passwordcontroller.text.toString().trim();
                          _firebaseAuth
                              .signInWithEmailAndPassword(
                              email: _email, password: _pass)
                              .then(
                                  (user) =>
                                  Fluttertoast.showToast(msg: "Please wait")
                                      .catchError((e) {})
                                      .whenComplete(() async {
                                    FirebaseUser user =
                                    await _firebaseAuth.currentUser();
                                    if (user.isEmailVerified) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider(
                                                      create: (context) =>
                                                          HomeTransition(),
                                                      child: homepage())));
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return VerificationDialog();
                                          });
                                    }
                                  }), onError: (error) {
                            Fluttertoast.showToast(
                                msg: "Enter a valid username or password");
                          });
                        },
                        child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 50.0),
                              child: ListTile(
                                title: Text(
                                  "login",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.play_circle_filled,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Don't have an account ? ",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Montserrat Bold'),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => signuppage()));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                              fontFamily: 'Montserrat Bold',
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
