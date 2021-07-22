import 'package:flutter/material.dart';
import "dart:core";
import "package:http/http.dart" as http;
import 'package:pfe/constants/constants.dart';
import 'package:pfe/ui/widgets/custom_shape.dart';
import 'package:pfe/ui/widgets/customappbar.dart';
import 'package:pfe/ui/widgets/responsive_ui.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController _fnController = TextEditingController();
  TextEditingController _lnController = TextEditingController();
  TextEditingController _psController = TextEditingController();
  TextEditingController _eController = TextEditingController();
  TextEditingController _phController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Opacity(opacity: 0.88, child: CustomAppBar()),
                clipShape(),
                form(),
                acceptTermsTextRow(),
                SizedBox(
                  height: _height / 35,
                ),
                button(),
                infoTextRow(),
                socialIconsRow(),
                signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
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
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.tealAccent, Colors.tealAccent[700]],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: _height / 5.5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.0,
                  color: Colors.black26,
                  offset: Offset(1.0, 10.0),
                  blurRadius: 20.0),
            ],
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset("assets/icons/register.png"),
          // child: GestureDetector(
          //   onTap: () {
          //     print('Adding photo');
          // },
          //child: Icon(
          //Icons.add_a_photo,
          //size: _large ? 40 : (_medium ? 33 : 31),
          //color: Colors.tealAccent[700],
          //)),
        ),
        Positioned(
          top: _height / 8,
          left: _width / 1.75,
          child: Container(
            alignment: Alignment.center,
            height: _height / 23,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.tealAccent[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            firstNameTextFormField(),
            SizedBox(height: _height / 60.0),
            lastNameTextFormField(),
            SizedBox(height: _height / 60.0),
            emailTextFormField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 10,
        child: TextFormField(
          controller: _fnController,
          keyboardType: TextInputType.name,
          cursorColor: Colors.tealAccent,
          decoration: InputDecoration(
            prefixIcon:
                Icon(Icons.assignment_ind, color: Colors.tealAccent, size: 20),
            hintText: "First name",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
          ),
        ));
  }

  Widget lastNameTextFormField() {
    return Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 10,
        child: TextFormField(
          controller: _lnController,
          keyboardType: TextInputType.name,
          cursorColor: Colors.tealAccent,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.assignment_ind_outlined,
                color: Colors.tealAccent, size: 20),
            hintText: "Last name",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
          ),
        ));
  }

  Widget emailTextFormField() {
    return Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 10,
        child: TextFormField(
          controller: _eController,
          keyboardType: TextInputType.name,
          cursorColor: Colors.tealAccent,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail, color: Colors.tealAccent, size: 20),
            hintText: "Email ",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
          ),
        ));
  }

  Widget phoneTextFormField() {
    return Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 10,
        child: TextFormField(
          controller: _phController,
          keyboardType: TextInputType.name,
          cursorColor: Colors.tealAccent,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.phone, color: Colors.tealAccent, size: 20),
            hintText: "Phone",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
          ),
        ));
  }

  Widget passwordTextFormField() {
    return Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 10,
        child: TextFormField(
          controller: _psController,
          keyboardType: TextInputType.name,
          cursorColor: Colors.tealAccent,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock, color: Colors.tealAccent, size: 20),
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
          ),
        ));
  }

  Widget acceptTermsTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 100.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Checkbox(
              activeColor: Colors.tealAccent,
              value: checkBoxValue,
              onChanged: (bool newValue) {
                setState(() {
                  checkBoxValue = newValue;
                });
              }),
          Text(
            "I accept all terms and conditions",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget button() {
    String url = "http://10.0.2.2:3000/api/users/register";
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        var response = await http.post(Uri.parse(url), headers: {
          "Accept": "application/json"
        }, body: {
          "firstName": _fnController.text,
          "lastName": _lnController.text,
          "email": _eController.text,
          "phoneNumber": _phController.text,
          "password": _psController.text
        });
        print('response : ${response.body}');
        print('response status : ${response.statusCode}');
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.tealAccent, Colors.tealAccent[700]],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'SIGN UP',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }

  Widget infoTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Or create using social media",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: _large ? 12 : (_medium ? 11 : 10)),
          ),
        ],
      ),
    );
  }

  Widget socialIconsRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 80.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/googlelogo.png"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/fblogo.jpg"),
          ),
          SizedBox(
            width: 20,
          ),
          CircleAvatar(
            radius: 15,
            backgroundImage: AssetImage("assets/images/twitterlogo.jpg"),
          ),
        ],
      ),
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(top: _height / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Already have an account?",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
          SizedBox(
            width: 5,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop(SIGN_IN);
              print("Routing to Sign up screen");
            },
            child: Text(
              "Sign in",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.tealAccent[700],
                  fontSize: 19),
            ),
          )
        ],
      ),
    );
  }
}
