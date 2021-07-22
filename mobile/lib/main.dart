import 'package:flutter/material.dart';
import 'package:pfe/ui/screens/landing.dart';
import 'package:pfe/ui/screens/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  // ignore: invalid_use_of_visible_for_testing_member
  SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "OVictoire",
        theme: ThemeData(primaryColor: Colors.orange[900]),
        home: SignInPage());
  }
}
