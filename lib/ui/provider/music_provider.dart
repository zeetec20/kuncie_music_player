import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/Artist.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/models/RecentMusicPlayed.dart';
import 'package:kuncie/repository/api_repository.dart';
import 'package:kuncie/repository/recent_music_played_repository.dart';
import 'package:kuncie/service/music_service.dart';

class MusicProvider with ChangeNotifier {
  MusicProvider(this.apiRepository, this.recentMusicPlayedRepository);

  ApiRepository apiRepository;
  RecentMusicPlayedRepository recentMusicPlayedRepository;
  late final MusicService musicService =
      MusicService(apiRepository, recentMusicPlayedRepository);

  Future<String> getImageArtist(Artist artist) =>
      musicService.getImageArtist(artist);
  Future<List<Artist>> getArtist() => musicService.getArtist();
  Future<ValueListenable<Box<RecentMusicPlayed>>> recentMusicPlayedListen() =>
      musicService.recentMusicPlayedListen();
  Future<List<Music>> search(String keyword) => musicService.search(keyword);
}
