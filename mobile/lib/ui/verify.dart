import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe/ui/screens/details.dart';
import 'package:pfe/ui/screens/splashscreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Screen"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Welcome to Main Screen !",
                    style: new TextStyle(fontFamily: "Poppins", fontSize: 16)),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SplashScreen()));
                  },
                  color: Colors.orangeAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    "Back to Splash Screen",
                    style: new TextStyle(fontFamily: "Poppins", fontSize: 16),
                  ),
                ),
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Details()));
                  },
                  color: Colors.redAccent,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: Text(
                    "Go to Api Screen",
                    style: new TextStyle(fontFamily: "Poppins", fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
