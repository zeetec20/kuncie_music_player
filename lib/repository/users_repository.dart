import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/Users.dart';
import 'package:uuid/uuid.dart';

class UsersRepository {
  Future<Box<Users>> openUsersBox() => Hive.openBox<Users>('users');

  Future<Users> get(String id) async =>
      (await openUsersBox()).values.where((element) => element.id == id).first;

  Future<Users?> findByEmail(String email) async {
    List<Users> users = (await openUsersBox())
        .values
        .where((element) => element.email == email)
        .toList();
    if (users.isNotEmpty) return users.first;
    return null;
  }

  Future<int> create(String name, String email, String password) async {
    return (await openUsersBox()).add(Users(
        id: Uuid().v4(),
        name: name,
        email: email,
        password: password,
        createdAt: DateTime.now()));
  }
}
