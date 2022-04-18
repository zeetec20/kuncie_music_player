import 'package:hive/hive.dart';

part 'Users.g.dart';

@HiveType(typeId: 3)
class Users {
  Users(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.createdAt});

  @HiveField(1)
  String id;

  @HiveField(2)
  String name;

  @HiveField(3)
  String email;

  @HiveField(4)
  String password;

  @HiveField(5)
  DateTime createdAt;
}

