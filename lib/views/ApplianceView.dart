import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:homeautomation/views/ApplianceCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Appliances extends StatefulWidget {
  String room;
  Appliances(this.room);
  @override
  _AppliancesState createState() => _AppliancesState(room);
}

class _AppliancesState extends State<Appliances> {
  String device_set = "";
  List<String> devicesstring = List<String>();
  List<bool> valuesstring = List<bool>();
  String room;
  _AppliancesState(this.room);

  @override
  void initState() {
    _getdata(room);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String tmp = device_set;
    print("Device set :  $device_set");
    return Scaffold(
        backgroundColor: Colors.indigo,
        body: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
          child: Center(
            child: ListView.builder(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                itemCount: devicesstring.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      ApplianceCard(
                          devicesstring[index].trim(),
                          Icons.devices,
                          room,
                          valuesstring[index],
                          devicesstring,
                          valuesstring),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  );
                }),
          ),
        ));
  }

  _getdata(String devicepar) async {
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
      _parsedata(value.data, devicepar);
    }).catchError((e) {
      print(e);
    });
  }

  _parsedata(var value, String devicepar) {
    setState(() {
      Map<String, dynamic> devicesmap = value;
      List<dynamic> devices2map = devicesmap[devicepar];
      Map<String, dynamic> devicename = Map<String, dynamic>();
      devices2map.forEach((element) {
        devicename = element;
      });
      devicename.forEach((key, value) {
        devicesstring.add(key);
        valuesstring.add(value);
      });
    });
  }

  Widget applicancecard(String devicepar) {
    _getdata(devicepar);
    bool switchstate = true;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Icon(
                      MdiIcons.lightbulb,
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
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        device_set,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.indigo,
                            fontWeight: FontWeight.bold),
                      ),
                      Text("5.6kwh",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: CupertinoSwitch(
                      activeColor: Colors.pinkAccent[100],
                      value: switchstate,
                      onChanged: (bool value) {
                        setState(() {
                          switchstate = value;
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
}
