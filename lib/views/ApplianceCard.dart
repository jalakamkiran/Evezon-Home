import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homeautomation/Homepage.dart';
import 'package:provider/provider.dart';

import 'home_transition.dart';

class ApplianceCard extends StatefulWidget {
  String title;
  String room;
  bool statevalue;
  IconData iconData;
  List<String> devices;
  List<bool> devicestates;
  ApplianceCard(this.title, this.iconData, this.room, this.statevalue,
      this.devices, this.devicestates);
  @override
  _ApplianceCardState createState() => _ApplianceCardState(
      title, iconData, room, statevalue, devices, devicestates);
}

class _ApplianceCardState extends State<ApplianceCard> {
  bool editable = false;
  String room;
  bool switchstate = true;
  String title;
  IconData iconData;
  bool statevalue;
  List<String> devices;
  TextEditingController controller = TextEditingController();
  List<bool> devicestates;
  _ApplianceCardState(this.title, this.iconData, this.room, this.statevalue,
      this.devices, this.devicestates);
  @override
  Widget build(BuildContext context) {
    print("Title : $title");

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0)),
        child: Container(
          height: 120,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      iconData,
                      color: Colors.indigo,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "100%",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo),
                    )
                  ],
                ),
                SizedBox(
                  width: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    !editable
                        ? Text(
                      title,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold),
                    )
                        : Container(
                      width: 50,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: title,
                            hintStyle: TextStyle(
                                fontSize: 20, color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.indigo)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.indigo)),
                            errorBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.indigo)),
                            focusedErrorBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.indigo)),
                            border: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.indigo)),
                            disabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.indigo))),
                        controller: controller,
                        autofocus: true,
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          String new_dev_name;
                          setState(() {
                            editable = !editable;
                          });
                          new_dev_name = controller.text;
                          if (new_dev_name.isEmpty) {
                            //nothing
                          } else {
                            FirebaseUser firebaseUser =
                            await FirebaseAuth.instance.currentUser();
                            String email = firebaseUser.email;
                            var _firestore = Firestore.instance;
                            setState(() {
                              email = firebaseUser.email;
                              Map<String, dynamic> updatedatafields =
                              Map<String, dynamic>();
                              _firestore
                                  .collection("UserData")
                                  .document(email)
                                  .get()
                                  .then((value) {
                                rename_device(value.data, new_dev_name, title);
                                Fluttertoast.showToast(msg: "Updated....");
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChangeNotifierProvider(
                                                create: (context) =>
                                                    HomeTransition(),
                                                child: homepage())));
                              });
                            });
                          }
                        })
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: CupertinoSwitch(
                      activeColor: Colors.pinkAccent[100],
                      value: statevalue,
                      onChanged: (bool value) async {
                        print("Room $room");
                        FirebaseUser firebaseUser =
                        await FirebaseAuth.instance.currentUser();
                        String email = firebaseUser.email;
                        var _firestore = Firestore.instance;
                        setState(() {
                          email = firebaseUser.email;
                          statevalue = value;
                          Map<String, dynamic> updatedatafields =
                          Map<String, dynamic>();
                          _firestore
                              .collection("UserData")
                              .document(email)
                              .get()
                              .then((value) {
                            parseupdate(value.data);
                          });
                        });
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  parseupdate(var value) async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    String email = firebaseUser.email;
    var _firestore = Firestore.instance;
    List<Map<String, dynamic>> list = List<Map<String, dynamic>>();
    Map<String, dynamic> devupdate = Map<String, dynamic>();
    Map<String, dynamic> updatevalue = value;
    updatevalue.forEach((key, value) {
      if (key == room) {
        List<dynamic> devvalue = value;
        devvalue.forEach((element) {
          devupdate = element;
          devupdate[title] = statevalue;
        });
        list.add(devupdate);
        updatevalue[room] = list;
      }
    });
    _firestore.collection("UserData").document(email).setData(updatevalue);
  }

  rename_device(var value, String new_name, String old_name) async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    String email = firebaseUser.email;
    var _firestore = Firestore.instance;
    List<Map<String, dynamic>> list = List<Map<String, dynamic>>();
    Map<String, dynamic> devupdate = Map<String, dynamic>();
    Map<String, dynamic> devnameupdate = Map<String, dynamic>();
    List<String> newkeys = List<String>();
    Map<String, dynamic> updatevalue = value;
    updatevalue.forEach((key, value) {
      if (key == room) {
        List<dynamic> devvalue = value;
        devvalue.forEach((element) {
          devupdate = element;
          print(devupdate);
          devupdate.forEach((key, value) {
            var k = key;
            if (k == old_name) {
              key = k.replaceAll(key, new_name);
              print(key);
              newkeys.add(key);
            } else {
              newkeys.add(key);
            }
          });
          newkeys.forEach((element) {
            devnameupdate[element] = false;
          });
        });
        list.add(devnameupdate);
        updatevalue[room] = list;
      }
    });
    print(updatevalue);
    _firestore.collection("UserData").document(email).setData(updatevalue);
  }
}

class Deviceupdateclass {
  String devicename;
  bool state;
  Deviceupdateclass(this.devicename, this.state);

  @override
  String toString() {
    return '{${this.devicename} : ${this.state}}';
  }
}
