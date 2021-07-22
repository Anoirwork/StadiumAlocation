import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pfe/models/User.dart';

class Service {
  final String url = "http://192.168.1.22:3000/api/";
  static Service _instance;
  factory Service() => _instance ??= new Service._();

  Service._();
  getStadiums() async {
    var response = await http.get(Uri.parse(url));
    var listGenerate = jsonDecode(response.body);
    return listGenerate["data"];
  }

  getUserInfo() async {
    var response = await http.get(Uri.parse(url + 'users/getinfo'));
    var json = jsonDecode(response.body);
    print(json);
    return User.fromJson(json);
  }

  reserveStadium(String dateTime) async {
    var response = await http.post(Uri.parse(url + 'stadium/reserve'), body: {
      'uid': '6062042541ca10181a38ae35',
      'sid': '60aba6892437f4fb2855b321',
      'dateTime': dateTime
    });
    print(response);
    var json = jsonDecode(response.body);

    return json;
  }
}
