import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pfe/ui/screens/signup.dart';
import 'package:pfe/ui/widgets/custom_shape.dart';
import 'package:pfe/ui/widgets/responsive_ui.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'landing.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignInScreen(),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Container(
        height: _height,
        width: _width,
        padding: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              clipShape(),
              welcomeTextRow(),
              signInTextRow(),
              form(),
              SizedBox(
                height: _height * 0.04,
              ),
              forgetPassTextRow(),
              SizedBox(
                height: _height * 0.04,
              ),
              button(),
              SizedBox(
                height: _height * 0.02,
              ),
              signUpTextRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    print(_height);
    //double height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 4
                  : (_medium ? _height / 3.75 : _height / 3.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.tealAccent, Colors.tealAccent[700]],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 4.5
                  : (_medium ? _height / 4.25 : _height / 4),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.tealAccent, Colors.tealAccent[700]],
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: _height / 12),
          alignment: Alignment.bottomCenter,
          child: Image.asset('assets/icons/log.png', scale: 7),
        ),
      ],
    );
  }

  Widget welcomeTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20),
      child: Row(
        children: <Widget>[
          Text(
            "Welcome",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: _large ? 50 : (_medium ? 40 : 30),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 15.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in to your account",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: _large ? 20 : (_medium ? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 15.0),
      child: Form(
        key: _key,
        child: Column(
          children: <Widget>[
            emailTextFormField(),
            SizedBox(height: _height / 40.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget emailTextFormField() {
    return Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 10,
        child: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.name,
          cursorColor: Colors.tealAccent[700],
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail, color: Colors.tealAccent, size: 20),
            hintText: "Email",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
          ),
        ));
  }

  bool _isObscure = true;
  Widget passwordTextFormField() {
    return Material(
      borderRadius: BorderRadius.circular(30.0),
      elevation: 10,
      child: TextFormField(
        autofocus: true,
        controller: passwordController,
        keyboardType: TextInputType.name,
        cursorColor: Colors.orange[200],
        obscureText: _isObscure,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: Colors.tealAccent, size: 20),
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            suffixIcon: IconButton(
                icon:
                    Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                })),
      ),
    );
  }

  Widget forgetPassTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Forgot your password?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              print("Routing");
            },
            child: Text(
              "Recover",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.tealAccent[700]),
            ),
          ),
          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        String url = "http://10.0.2.2:3000/api/users/login";

        var response = await http.post(Uri.parse(url), headers: {
          "Accept": "application/json"
        }, body: {
          "password": passwordController.text,
          "email": emailController.text,
        });
        // Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
        // final SharedPreferences prefs = await _prefs;
        // prefs.setString('user', jsonEncode(response.body.));
        Map<String, dynamic> res = jsonDecode(response.body);
        final SharedPreferences prefs = await _prefs;
        prefs.setString("userID", res['userData']['userID']);
        prefs.setString("userToken", res['userData']['token']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LandingScreen()));
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.tealAccent, Colors.tealAccent[700]],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('SIGN IN',
            style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10))),
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 120.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 14 : (_medium ? 12 : 10)),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen()));
            },
            child: Text(
              "Sign up",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.tealAccent[700],
                  fontSize: _large ? 19 : (_medium ? 17 : 15)),
            ),
          )
        ],
      ),
    );
  }
}
