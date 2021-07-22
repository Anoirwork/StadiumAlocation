import 'package:geolocator/geolocator.dart';

class Stadium {
  String id;
  String name;
  String description;
  double rating;
  double price;
  String picPath;
  Position positions;

  Stadium(
      {this.id,
      this.name,
      this.description,
      this.rating,
      this.price,
      this.positions,
      this.picPath});

  Stadium.fromJson(Map<String, dynamic> json) {
    try {
      id = json['_id'];
      picPath = json['picPath'];
      name = json['name'];
      description = json['description'];
      rating = json['rating'] == null ? 0.0 : json['rating'].toDouble();
      price = json['price'] == null ? 0.0 : json['price'].toDouble();
      positions = Position(
          latitude: json['positions']['lat'],
          longitude: json['positions']['lng']);
    } catch (e) {
      print("This is from stadium from json $e");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['picPath'] = this.picPath;
    data['description'] = this.description;
    data['rating'] = this.rating;
    data['price'] = this.price;
    if (this.positions != null) {
      data['positions'] = this.positions.toJson();
    }
    return data;
  }
}

// class Positions {
//   double lat;
//   double lng;

//   Positions({this.lat, this.lng});

//   Positions.fromJson(Map<String, dynamic> json) {
//     lat = json['lat'];
//     lng = json['lng'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['lat'] = this.lat;
//     data['lng'] = this.lng;
//     return data;
//   }
// }
