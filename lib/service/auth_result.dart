import 'package:kuncie/models/Users.dart';

class AuthResult {
  AuthResult(this.success, {this.message, this.user});

  final bool success;
  final String? message;
  final Users? user;
}
