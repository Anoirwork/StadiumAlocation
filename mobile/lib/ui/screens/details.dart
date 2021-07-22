import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:http/http.dart' as http;
import 'package:pfe/constants/constants.dart';
import 'package:pfe/models/Stadium.dart';
import "package:latlong/latlong.dart";
import 'package:pfe/ui/screens/reservation.dart';
import 'package:pfe/ui/screens/stadiumshop.dart';
import 'package:pfe/ui/screens/profile.dart';
import 'package:pfe/ui/widgets/bottom_navigation_bar.dart';

import '../tabicon.dart';
import 'catalogue.dart';
import 'event.dart';
import 'maps.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  String idStadium;
  Position userPos;
  Details({Key key, this.idStadium, this.userPos}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> with TickerProviderStateMixin {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = Container(
    width: double.infinity,
    height: double.infinity,
    child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Text('Loading...'),
          CircularProgressIndicator(),
        ])),
  );
  AnimationController animationController;
  Stadium stadium;
  double rate;
  Future<Stadium> getStadiumDetails(String id) async {
    String url = "http://10.0.2.2:3000/api/stadium/$id";
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var js = json['stadium'];
    stadium = Stadium.fromJson(js);
    distanceToStadium = double.parse(calculateDistance(
            widget.userPos.latitude,
            widget.userPos.longitude,
            stadium.positions.latitude,
            stadium.positions.longitude)
        .toStringAsFixed(2));
    return stadium;
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  double distanceToStadium = 0;

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stadium>(
        future: getStadiumDetails(this.widget.idStadium),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                body: Stack(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20.0)),
                    foregroundDecoration: BoxDecoration(color: Colors.black26),
                    height: 400,
                    child: Image.network(
                        "http://10.0.2.2:3000/" + stadium.picPath,
                        fit: BoxFit.cover)),
                SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 250),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '${stadium.name}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 16.0),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 16.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.tealAccent[700],
                                borderRadius: BorderRadius.circular(20.0)),
                            child: Text(
                              "${stadium.rating}/5 reviews",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.0),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            color: Colors.white,
                            icon: Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CatalogueScreen()));
                            },
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(32.0),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: stadium.rating,
                                            itemBuilder: (context, index) =>
                                                Icon(
                                              Icons.star,
                                              color: Colors.tealAccent[700],
                                            ),
                                            itemCount: 5,
                                            itemSize: 30.0,
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      ),
                                      Text.rich(
                                        TextSpan(children: [
                                          WidgetSpan(
                                              child: Icon(
                                            Icons.location_on,
                                            size: 20.0,
                                            color: Colors.grey,
                                          )),
                                          TextSpan(
                                              text:
                                                  "$distanceToStadium km to this stadium")
                                        ]),
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 20.0),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "DT ${stadium.price}",
                                      style: TextStyle(
                                          color: Colors.tealAccent[700],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                    Text(
                                      "/per 1.5H",
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.grey),
                                    )
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(height: 30.0),
                            SizedBox(
                              width: double.infinity,
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                color: Colors.tealAccent[700],
                                textColor: Colors.white,
                                child: Text(
                                  "Book Now",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal: 32.0,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BookingScreen()));
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.6),
                                    offset: const Offset(4, 4),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: FlutterMap(
                                options: MapOptions(
                                  center: LatLng(stadium.positions.latitude,
                                      stadium.positions.longitude),
                                  zoom: 15.0,
                                ),
                                nonRotatedLayers: [
                                  TileLayerOptions(
                                      urlTemplate:
                                          "https://api.mapbox.com/styles/v1/mapbox/streets-v11/tiles/{z}/{x}/{y}?access_token=${API_KEY}",
                                      subdomains: ['a', 'b', 'c']),
                                  MarkerLayerOptions(
                                    markers: [
                                      Marker(
                                        width: 70.0,
                                        height: 70.0,
                                        point: LatLng(
                                            stadium.positions.latitude,
                                            stadium.positions.longitude),
                                        builder: (ctx) => Container(
                                          child: Image.asset(
                                              'assets/images/marker.png'),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            Text(
                              "Description".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14.0),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              '${stadium.description}',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontWeight: FontWeight.w300, fontSize: 14.0),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: PreferredSize(
                      child: Container(
                        child: ClipRRect(
                            child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  //   width: MediaQuery.of(context).size.width,
                                  //  height: MediaQuery.of(context).padding.top,
                                  color: Colors.transparent,
                                ))),
                      ),
                      preferredSize:
                          Size(MediaQuery.of(context).size.width, 22),
                    )),
              ],
            ));
          } else if (snapshot.hasError) {
            return Container(child: Text("Error"));
          } else {
            return Container(
                color: Colors.white,
                child: Center(
                    child: CupertinoActivityIndicator(
                  radius: 20,
                )));
          }
        });
  }
}
