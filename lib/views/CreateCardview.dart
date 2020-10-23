import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateCardView extends StatefulWidget {
  String room;
  Color backgroundcolor;
  Color textcolor;
  IconData icon;

  CreateCardView(this.room, this.backgroundcolor, this.textcolor, this.icon);

  @override
  _CreateCardViewState createState() =>
      _CreateCardViewState(room, backgroundcolor, textcolor, icon);
}

class _CreateCardViewState extends State<CreateCardView> {
  TextEditingController roomname = TextEditingController();
  TextEditingController device1 = TextEditingController();
  TextEditingController device2 = TextEditingController();
  TextEditingController device3 = TextEditingController();
  TextEditingController device4 = TextEditingController();
  TextEditingController device5 = TextEditingController();
  bool create_room = true;
  String room;
  Color backgroundcolor;
  Color textcolor;
  IconData icon;
  _CreateCardViewState(
      this.room, this.backgroundcolor, this.textcolor, this.icon);
  @override
  Widget build(BuildContext context) {
    ScaffoldState scaffold = Scaffold.of(context);
    return Cardview(scaffold);
  }

  Widget Cardview(ScaffoldState scaffoldState) {
    print("Room : $room");
    return Container(
      height: 380,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: backgroundcolor),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                create_room
                    ? Text(
                  room.toString(),
                  style: TextStyle(
                      fontSize: 20,
                      color: textcolor,
                      fontWeight: FontWeight.bold),
                )
                    : Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Container(
                    width: 200,
                    height: 30,
                    child: TextField(
                      controller: roomname,
                      style: TextStyle(
                          color: textcolor, fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          focusColor: Colors.white,
                          enabledBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: backgroundcolor)),
                          hintText: "Room name",
                          hintStyle: TextStyle(
                              fontSize: 20,
                              color: textcolor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            create_room
                ? Text(
              "Add a new room to control the appliances",
              style: TextStyle(
                  fontSize: 30,
                  color: textcolor,
                  fontWeight: FontWeight.w900),
            )
                : Padding(
              padding: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 30,
                      child: TextField(
                        controller: device1,
                        style: TextStyle(
                            color: textcolor,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: backgroundcolor)),
                            hintText: "Device 1",
                            hintStyle: TextStyle(
                                fontSize: 30,
                                color: textcolor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      child: TextField(
                        controller: device2,
                        style: TextStyle(
                            color: textcolor,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: backgroundcolor)),
                            hintText: "Device 2",
                            hintStyle: TextStyle(
                                fontSize: 30,
                                color: textcolor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      child: TextField(
                        controller: device3,
                        style: TextStyle(
                            color: textcolor,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: backgroundcolor)),
                            hintText: "Device 3",
                            hintStyle: TextStyle(
                                fontSize: 30,
                                color: textcolor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      child: TextField(
                        controller: device4,
                        style: TextStyle(
                            color: textcolor,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: backgroundcolor)),
                            hintText: "Device 4",
                            hintStyle: TextStyle(
                                fontSize: 30,
                                color: textcolor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 200,
                      height: 30,
                      child: TextField(
                        controller: device5,
                        style: TextStyle(
                            color: textcolor,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            focusColor: Colors.white,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: backgroundcolor)),
                            hintText: "Device 5",
                            hintStyle: TextStyle(
                                fontSize: 30,
                                color: textcolor,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    create_room = !create_room;
                    addrooms(scaffoldState);
                  });
                },
                child: Container(
                  height: 50,
                  width: 200,
                  child: Center(
                    child: Text(
                      "Create Room",
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

  addrooms(ScaffoldState scaffoldState) async {
    String roomn = roomname.text.trim();
    String dev1name = device1.text.trim();
    String dev2name = device2.text.trim();
    String dev3name = device3.text.trim();
    String dev4name = device4.text.trim();
    String dev5name = device5.text.trim();
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    String email = firebaseUser.email;
    var _firestore = Firestore.instance;
    if (roomn.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter the room name",
          backgroundColor: Colors.black87,
          gravity: ToastGravity.CENTER,
          textColor: Colors.white);
    } else {
      Map<String, dynamic> devicesend = Map<String, dynamic>();
      List<String> devices = <String>[
        dev1name,
        dev2name,
        dev3name,
        dev4name,
        dev5name
      ];
      devices.forEach((element) {
        if (element.isEmpty) {
          //empty no addition
        } else {
          devicesend[element] = false;
        }
      });
      print(devicesend);
      _firestore.collection("UserData").document(email).setData({
        roomn: [devicesend]
      }, merge: true).then((value) {});
      print(" Data : $roomn $dev1name $dev2name $dev3name");
    }
  }
}
