import 'package:flutter/material.dart';
import 'package:pfe/models/User.dart';
import 'package:pfe/network/Service.dart';
import '../widgets/assets.dart';
import '../widgets/network_image.dart';

class Profile extends StatefulWidget {
  const Profile({Key key, AnimationController animationController});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;
  @override
  void initState() {
    futuremethod();
    super.initState();
  }

  void futuremethod() async {
    setState(() {
      Service().getUserInfo().then((res) => user = res);
    });
  }

  final image = avatars[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 250,
              width: double.infinity,
              child: PNetworkImage(
                "https://s3.envato.com/files/256213928/1.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Chini Dhia",
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text(""),
                                    subtitle: Text(""),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text("285"),
                                      Text("Matchs played")
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      Text("3025"),
                                      Text("Hours played")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://scontent.ftun16-1.fna.fbcdn.net/v/t1.6435-9/87153950_2760895453992115_6088848554263052288_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=174925&_nc_ohc=3oU22u5GKtAAX9OcKTI&_nc_ht=scontent.ftun16-1.fna&oh=903a60bf35c005c5d79e7742fc283d0e&oe=60E55AA9'),
                                fit: BoxFit.cover)),
                        margin: EdgeInsets.only(left: 16.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text("User information"),
                        ),
                        Divider(),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text("chinidhia@gmail.com"),
                          leading: Icon(Icons.email),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text("+216-24992825"),
                          leading: Icon(Icons.phone),
                        ),
                        ListTile(
                          title: Text("Website"),
                          subtitle: Text("https://www.littlebutterfly.com"),
                          leading: Icon(Icons.web),
                        ),
                        ListTile(
                          title: Text("About"),
                          subtitle: Text(
                              "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nulla, illo repellendus quas beatae reprehenderit nemo, debitis explicabo officiis sit aut obcaecati iusto porro? Exercitationem illum consequuntur magnam eveniet delectus ab."),
                          leading: Icon(Icons.person),
                        ),
                        ListTile(
                          title: Text("Joined Date"),
                          subtitle: Text("15 February 2019"),
                          leading: Icon(Icons.calendar_view_day),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}
