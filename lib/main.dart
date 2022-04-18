import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/MusicLike.dart';
import 'package:kuncie/models/RecentMusicPlayed.dart';
import 'package:kuncie/models/Users.dart';
import 'package:kuncie/repository/api_repository.dart';
import 'package:kuncie/repository/music_like_repository.dart';
import 'package:kuncie/repository/recent_music_played_repository.dart';
import 'package:kuncie/repository/users_repository.dart';
import 'package:kuncie/service/music_service.dart';
import 'package:kuncie/service/user_service.dart';
import 'package:kuncie/ui/pages/wrapper_app.dart';
import 'package:kuncie/ui/provider/app_provider.dart';
import 'package:kuncie/ui/provider/login_provider.dart';
import 'package:kuncie/ui/provider/music_player_provider.dart';
import 'package:kuncie/ui/provider/music_provider.dart';
import 'package:kuncie/ui/provider/register_provider.dart';
import 'package:kuncie/ui/provider/search_provider.dart';
import 'package:kuncie/ui/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  Hive.registerAdapter<Users>(UsersAdapter());
  Hive.registerAdapter<RecentMusicPlayed>(RecentMusicPlayedAdapter());
  Hive.registerAdapter<MusicLike>(MusicLikeAdapter());
  await Hive.initFlutter();
  // (await UsersRepository().openUsersBox()).clear();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),
      ChangeNotifierProvider<LoginProvider>(
          create: (_) => LoginProvider(UsersRepository())),
      ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider(UsersRepository())),
      ChangeNotifierProvider<SearchProvider>(create: (_) => SearchProvider()),
      ChangeNotifierProvider<MusicPlayerProvider>(
          create: (_) => MusicPlayerProvider(
              ApiRepository(), RecentMusicPlayedRepository())),
      ChangeNotifierProvider<MusicProvider>(
          create: (_) =>
              MusicProvider(ApiRepository(), RecentMusicPlayedRepository())),
      ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(MusicLikeRepository())),
      ChangeNotifierProvider<MusicProvider>(
          create: (_) =>
              MusicProvider(ApiRepository(), RecentMusicPlayedRepository()))
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kuncie Music Player',
        home: WrapperApp(),
      ),
    );
  }
}
