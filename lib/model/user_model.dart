import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String? token;
  @HiveField(1)
  String? id;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? password;
  User({
    required this.token,
    required this.email,
    required this.id,
    required this.password,
  });
  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        email = json['email'],
        token = json['token'],
        password = json['password'];
  Map<String, dynamic> toJson() {
    return {'token': token, 'id': id, 'password': password, 'email': email};
  }
}
