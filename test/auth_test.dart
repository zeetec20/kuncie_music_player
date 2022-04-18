import 'package:flutter_test/flutter_test.dart';
import 'package:kuncie/models/Users.dart';
import 'package:kuncie/repository/users_repository.dart';
import 'package:kuncie/service/auth_result.dart';
import 'package:kuncie/service/auth_service.dart';
import 'package:kuncie/service/crypt_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:uuid/uuid.dart';

import 'auth_test.mocks.dart';

@GenerateMocks([UsersRepository, CryptService])
void main() {
  MockUsersRepository usersRepository = MockUsersRepository();
  MockCryptService cryptService = MockCryptService();
  AuthService authService = AuthService(usersRepository);
  authService.cryptService = cryptService;

  group('login', () {
    test('login, success', () async {
      when(usersRepository.findByEmail('email')).thenAnswer((_) async => Users(
          id: 'id',
          name: 'name',
          email: 'email',
          password: 'password',
          createdAt: DateTime.now()));
      when(cryptService.match('password', 'password')).thenReturn(true);

      AuthResult result = await authService.login('email', 'password');

      expect(result.success, isTrue);
      expect(result.message, isNull);
      expect(result.user, isNotNull);
    });

    test('login, failed (user not exist)', () async {
      when(usersRepository.findByEmail('email')).thenAnswer((_) async => null);

      AuthResult result = await authService.login('email', 'password');

      expect(result.success, isFalse);
      expect(result.message, isNotNull);
      expect(result.user, isNull);
    });

    test('login, failed (email and password incorrect)', () async {
      when(usersRepository.findByEmail('email')).thenAnswer((_) async => Users(
          id: 'id',
          name: 'name',
          email: 'email',
          password: 'password',
          createdAt: DateTime.now()));
      when(cryptService.match('password', 'password')).thenReturn(false);

      AuthResult result = await authService.login('email', 'password');

      expect(result.success, isFalse);
      expect(result.message, isNotNull);
      expect(result.user, isNull);
    });
  });

  group('register', () {
    test('register, success', () async {
      when(usersRepository.findByEmail('email')).thenAnswer((_) async => null);
      when(cryptService.hash('password')).thenReturn('password');
      when(usersRepository.create('name', 'email', 'password'))
          .thenAnswer((_) async => 0);

      AuthResult result =
          await authService.register('name', 'email', 'password');

      expect(result.success, isTrue);
      expect(result.message, isNull);
      expect(result.user, isNull);
    });

    test('register, failed (user already exist)', () async {
      when(usersRepository.findByEmail('email')).thenAnswer((_) async => Users(
          id: 'id',
          name: 'name',
          email: 'email',
          password: 'password',
          createdAt: DateTime.now()));

      AuthResult result =
          await authService.register('name', 'email', 'password');

      expect(result.success, isFalse);
      expect(result.message, isNotNull);
      expect(result.user, isNull);
    });
  });
}
