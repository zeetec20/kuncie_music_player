import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/models/RecentMusicPlayed.dart';

class RecentMusicPlayedRepository {
  Future<Box<RecentMusicPlayed>> openRecentMusicPlayedBox() =>
      Hive.openBox<RecentMusicPlayed>('recent_music_played');

  Future findByUserId(String? userId) async =>
      (await openRecentMusicPlayedBox())
          .values
          .where((element) => element.userId == userId)
          .toList();

  Future add(Music music, {String? userId}) async => (await openRecentMusicPlayedBox())
      .add(RecentMusicPlayed.fromMusic(music, userId: userId));

  Future<ValueListenable<Box<RecentMusicPlayed>>> listen() async =>
      (await openRecentMusicPlayedBox()).listenable();
}
