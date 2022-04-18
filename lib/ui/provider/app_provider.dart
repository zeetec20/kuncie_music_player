import 'package:flutter/cupertino.dart';
import 'package:kuncie/models/Users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider with ChangeNotifier {
  Future<SharedPreferences> sharedPreferences() =>
      SharedPreferences.getInstance();
  bool isAuthenticate = false;
  Users? user;
  int page = 0;

  void changePage(int page) {
    this.page = page;
    notifyListeners();
  }

  Future setUser(Users user) async {
    SharedPreferences pref = await sharedPreferences();
    await pref.setString('user.id', user.id);
    await pref.setString('user.name', user.name);
    await pref.setString('user.email', user.email);
    await pref.setInt('user.createdAt', user.createdAt.millisecondsSinceEpoch);
    isAuthenticate = true;
    this.user = user;

    notifyListeners();
  }

  Future checkUser() async {
    SharedPreferences pref = await sharedPreferences();
    if (pref.containsKey('user.id') &&
        pref.containsKey('user.name') &&
        pref.containsKey('user.email') &&
        pref.containsKey('user.createdAt')) {
      isAuthenticate = true;
      this.user = Users(
          id: pref.getString('user.id')!,
          name: pref.getString('user.name')!,
          email: pref.getString('user.email')!,
          password: '',
          createdAt: DateTime.fromMillisecondsSinceEpoch(
              pref.getInt('user.createdAt')!));

      notifyListeners();
    }
  }

  Future removeUser() async {
    SharedPreferences pref = await sharedPreferences();
    await pref.remove('user.id');
    await pref.remove('user.name');
    await pref.remove('user.email');
    await pref.remove('user.createdAt');
    this.user = null;
    this.isAuthenticate = false;

    notifyListeners();
  }
}
