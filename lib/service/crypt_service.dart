import 'package:crypt/crypt.dart';

class CryptService {
  String salt = 'music_app';

  String hash(String password) =>
      Crypt.sha256(password, rounds: 1000, salt: salt).toString();

  bool match(String hashPassword, String password) {
    return Crypt(hashPassword).match(password);
  }
}
