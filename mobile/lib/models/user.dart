import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phonenumber,
    this.cpf,
    this.accountId,
    this.email,
  });

  int id;
  String firstName;
  String lastName;
  String phonenumber;
  String cpf;
  int accountId;
  String email;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        phonenumber: json["phonenumber"],
        cpf: json["cpf"],
        accountId: json["account_id"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phonenumber": phonenumber,
        "cpf": cpf,
        "account_id": accountId,
        "email": email,
      };
}
