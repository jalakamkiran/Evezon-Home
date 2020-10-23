import 'package:flutter/material.dart';
import 'package:homeautomation/Loginpage.dart';

class VerificationDialog extends StatefulWidget {
  @override
  _VerificationDialogState createState() => _VerificationDialogState();
}

class _VerificationDialogState extends State<VerificationDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(70), bottomLeft: Radius.circular(70))),
      child: Container(
        alignment: Alignment.topCenter,
        width: 200,
        height: 200,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Hold on",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat"),
                ),
              ),
              Text(
                "A verification email has been sent to your registered mail ID. It will take no more than a minute to do it. Please verify to continue",
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontFamily: "Montserrat",
                    color: Colors.grey,
                    fontStyle: FontStyle.italic),
                textAlign: TextAlign.justify,
                maxLines: 6,
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return loginpage();
                    }));
                  },
                  child: Container(
                    height: 35,
                    width: 70,
                    child: Center(
                      child: Text(
                        "Close",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            letterSpacing: 1.5),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
