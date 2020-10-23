import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/views/ApplianceView.dart';

class CardClass extends StatefulWidget {
  String room;
  Color backgroundcolor;
  Color textcolor;
  IconData icon;

  CardClass(this.room, this.backgroundcolor, this.textcolor, this.icon);

  @override
  _CardClassState createState() =>
      _CardClassState(room, backgroundcolor, textcolor, icon);
}

class _CardClassState extends State<CardClass> {
  String room_parsed = "";
  List<String> roomstring = List<String>();
  Map<String, dynamic> data = Map<String, dynamic>();
  String room;
  Color backgroundcolor;
  Color textcolor;
  IconData icon;
  _CardClassState(this.room, this.backgroundcolor, this.textcolor, this.icon);
  @override
  Widget build(BuildContext context) {
    return Cardview();
  }

  Widget Cardview() {
    room_parsed = "";
    room_parsed = room.toString();
    print("Room : $room");
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: backgroundcolor),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  room_parsed,
                  style: TextStyle(
                      fontSize: 20,
                      color: textcolor,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Control your $room_parsed Appliances",
              style: TextStyle(
                  fontSize: 30, color: textcolor, fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  _getdata();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Appliances(room_parsed)));
                },
                child: Container(
                  height: 50,
                  width: 200,
                  child: Center(
                    child: Text(
                      "View Appliances",
                      style: TextStyle(
                        fontSize: 18,
                        color: backgroundcolor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _getdata() async {
    var returndata;
    final _auth = FirebaseAuth.instance;
    final firestoreinstance = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    String email = user.email;
    firestoreinstance
        .collection("UserData")
        .document(email)
        .get()
        .then((value) {
      setState(() {
        _parsedata(value);
      });
    }).catchError((e) {
      print("Card View $e");
    });
  }

  _parsedata(var value) {
    data = Map<String, dynamic>();
    roomstring = [];
    Map<String, dynamic> returndata = value.data;
    List<Map<String, dynamic>> room_desc = List<Map<String, dynamic>>();
    List<dynamic> roomdata = returndata['Room2'];
  }
}
