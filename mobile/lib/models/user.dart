import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String firstName;
  String lastName;
  String email;
  String phonenumber;
  String cpf;
  dynamic latitude;
  dynamic longitude;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phonenumber,
    this.cpf,
    this.latitude,
    this.longitude,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        phonenumber: json["phonenumber"],
        cpf: json["cpf"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phonenumber": phonenumber,
        "cpf": cpf,
        "latitude": latitude,
        "longitude": longitude,
      };
}
