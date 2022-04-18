import 'package:kuncie/models/Users.dart';
import 'package:kuncie/repository/users_repository.dart';
import 'package:kuncie/service/auth_result.dart';
import 'package:kuncie/service/crypt_service.dart';

class AuthService {
  AuthService(this.usersRepository);

  final UsersRepository usersRepository;
  String salt = 'music_player';
  CryptService cryptService = CryptService();

  Future<AuthResult> login(String email, String password) async {
    Users? user = await usersRepository.findByEmail(email);
    if (user == null)
      return AuthResult(false, message: 'Email or password incorrect');
    if (cryptService.match(user.password, password))
      return AuthResult(true,
          user: Users(
              id: user.id,
              name: user.name,
              email: user.email,
              password: '',
              createdAt: user.createdAt));
    return AuthResult(false, message: 'Email or password incorrect');
  }

  Future<AuthResult> register(
      String name, String email, String password) async {
    if ((await usersRepository.findByEmail(email)) != null)
      return AuthResult(false, message: 'User with submit email already exist');
    password = cryptService.hash(password);
    await usersRepository.create(name, email, password);
    return AuthResult(true);
  }
}
