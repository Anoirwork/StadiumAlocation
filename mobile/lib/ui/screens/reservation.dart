import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pfe/network/Service.dart';
import 'details.dart';
import 'landing.dart';

class BookingScreen extends StatefulWidget {
  final String doctor;

  const BookingScreen({Key key, this.doctor}) : super(key: key);
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();
  FocusNode f5 = FocusNode();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String timeText = 'Select Time';
  String dateUTC;
  String date_Time;

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    ).then(
      (date) {
        setState(
          () {
            selectedDate = date;
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime,
        alwaysUse24HourFormat: false);

    if (formattedTime != null) {
      setState(() {
        timeText = formattedTime;
        _timeController.text = timeText;
      });
    }
    date_Time = selectedTime.toString().substring(10, 15);
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "OK",
      ),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LandingScreen(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Done!",
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    selectTime(context);
    _doctorController.text = widget.doctor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/milou.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.only(top: 0),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextFormField(
                                focusNode: f4,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 20,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[350],
                                  hintText: 'Select Date*',
                                ),
                                controller: _dateController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Please Enter the Date';
                                  return null;
                                },
                                onFieldSubmitted: (String value) {
                                  f4.unfocus();
                                  FocusScope.of(context).requestFocus(f5);
                                },
                                textInputAction: TextInputAction.next,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: ClipOval(
                                  child: Material(
                                    color:
                                        Colors.tealAccent[700], // button color
                                    child: InkWell(
                                      // inkwell color
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons.date_range_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        selectDate(context);
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              TextFormField(
                                focusNode: f5,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 20,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(90.0)),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey[350],
                                  hintText: 'Select Time*',
                                ),
                                controller: _timeController,
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Please Enter the Time';
                                  return null;
                                },
                                onFieldSubmitted: (String value) {
                                  f5.unfocus();
                                },
                                textInputAction: TextInputAction.next,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: ClipOval(
                                  child: Material(
                                    color:
                                        Colors.tealAccent[700], // button color
                                    child: InkWell(
                                      // inkwell color
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Icon(
                                          Icons.timer_outlined,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        selectTime(context);
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 2,
                              primary: Colors.tealAccent[700],
                              onPrimary: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                print(_nameController.text);
                                print(_dateController.text);
                                print(_timeController.text);
                                showAlertDialog(context);
                                var fullTime = _dateController.text +
                                    ' ' +
                                    _timeController.text;
                                var response =
                                    await Service().reserveStadium(fullTime);

                                print(response);
                              }
                            },
                            child: Text(
                              "Book Appointment",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
