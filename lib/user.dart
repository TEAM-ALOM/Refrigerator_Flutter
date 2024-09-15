import 'dart:convert';

class User {
  int? id;
  String? name;
  int? count;
  DateTime? purchaseDate;
  DateTime? expirationDate;
  bool? refrigeration;
  bool? freezing;

  User({
    this.id,
    this.name,
    this.count,
    this.purchaseDate,
    this.expirationDate,
    this.refrigeration,
    this.freezing,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        count: json["count"],
        purchaseDate: json["purchaseDate"],
        expirationDate: json["expirationDate"],
        refrigeration: json["refrigeration"],
        freezing: json["freezing"],
      );
}

class UserList {
  final List<User>? users;
  UserList({this.users});

  factory UserList.fromJson(String jsonString) {
    List<dynamic> listFromJson = json.decode(jsonString);
    List<User> users = <User>[];

    users = listFromJson.map((user) => User.fromJson(user)).toList();
    return UserList(users: users);
  }
}
