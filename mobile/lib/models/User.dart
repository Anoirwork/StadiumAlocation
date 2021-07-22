class User {
  String userID;
  String firstName;
  String lastName;
  String email;
  String token;

  User({this.userID, this.firstName, this.lastName, this.email, this.token});

  User.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
