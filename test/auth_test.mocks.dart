// Mocks generated by Mockito 5.1.0 from annotations
// in kuncie/test/auth_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:hive_flutter/adapters.dart' as _i2;
import 'package:kuncie/models/Users.dart' as _i3;
import 'package:kuncie/repository/users_repository.dart' as _i4;
import 'package:kuncie/service/crypt_service.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeBox_0<E> extends _i1.Fake implements _i2.Box<E> {}

class _FakeUsers_1 extends _i1.Fake implements _i3.Users {}

/// A class which mocks [UsersRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockUsersRepository extends _i1.Mock implements _i4.UsersRepository {
  MockUsersRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Box<_i3.Users>> openUsersBox() =>
      (super.noSuchMethod(Invocation.method(#openUsersBox, []),
              returnValue:
                  Future<_i2.Box<_i3.Users>>.value(_FakeBox_0<_i3.Users>()))
          as _i5.Future<_i2.Box<_i3.Users>>);
  @override
  _i5.Future<_i3.Users> get(String? id) =>
      (super.noSuchMethod(Invocation.method(#get, [id]),
              returnValue: Future<_i3.Users>.value(_FakeUsers_1()))
          as _i5.Future<_i3.Users>);
  @override
  _i5.Future<_i3.Users?> findByEmail(String? email) =>
      (super.noSuchMethod(Invocation.method(#findByEmail, [email]),
          returnValue: Future<_i3.Users?>.value()) as _i5.Future<_i3.Users?>);
  @override
  _i5.Future<int> create(String? name, String? email, String? password) =>
      (super.noSuchMethod(Invocation.method(#create, [name, email, password]),
          returnValue: Future<int>.value(0)) as _i5.Future<int>);
}

/// A class which mocks [CryptService].
///
/// See the documentation for Mockito's code generation for more information.
class MockCryptService extends _i1.Mock implements _i6.CryptService {
  MockCryptService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get salt =>
      (super.noSuchMethod(Invocation.getter(#salt), returnValue: '') as String);
  @override
  set salt(String? _salt) => super.noSuchMethod(Invocation.setter(#salt, _salt),
      returnValueForMissingStub: null);
  @override
  String hash(String? password) =>
      (super.noSuchMethod(Invocation.method(#hash, [password]), returnValue: '')
          as String);
  @override
  bool match(String? hashPassword, String? password) =>
      (super.noSuchMethod(Invocation.method(#match, [hashPassword, password]),
          returnValue: false) as bool);
}
