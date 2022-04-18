import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:kuncie/models/Artist.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/models/RecentMusicPlayed.dart';
import 'package:kuncie/repository/api_repository.dart';
import 'package:kuncie/repository/recent_music_played_repository.dart';

class MusicService {
  MusicService(this.apiRepository, this.recentMusicPlayedRepository);
  final ApiRepository apiRepository;
  final RecentMusicPlayedRepository recentMusicPlayedRepository;

  Future<List<Music>> search(String keyword) => apiRepository.search(keyword);

  Future addRecentMusicPlayed(Music music, {String? userId}) =>
      recentMusicPlayedRepository.add(music, userId: userId);

  Future<ValueListenable<Box<RecentMusicPlayed>>> recentMusicPlayedListen() =>
      recentMusicPlayedRepository.listen();

  Future<String> getImageArtist(Artist artist) =>
      apiRepository.getImageArtist(artist.image);

  Future<List<Artist>> getArtist() async {
    String response = await rootBundle.loadString('assets/db.json');
    Map data = (await json.decode(response)) as Map;
    return List<Map>.from(data['popular_artist'])
        .map((p) => Artist(p['name'], p['url'],
            bestMonthly: p['url'] == data['best_artist_month']['url']))
        .toList();
  }
}
