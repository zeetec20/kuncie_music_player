import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/models/Users.dart';
import 'package:kuncie/repository/api_repository.dart';
import 'package:kuncie/repository/recent_music_played_repository.dart';
import 'package:kuncie/service/music_service.dart';

class MusicPlayerProvider with ChangeNotifier {
  MusicPlayerProvider(this.apiRepository, this.recentMusicPlayedRepository);

  final AudioPlayer audioPlayer = AudioPlayer();
  final ApiRepository apiRepository;
  final RecentMusicPlayedRepository recentMusicPlayedRepository;
  late final MusicService musicService =
      MusicService(apiRepository, recentMusicPlayedRepository);
  bool isPlayed = false;
  bool isPaused = false;
  Music? music;
  List<Music>? playlist;
  SourceMusic? sourceMusic;

  Future pause() async {
    this.isPaused = true;
    this.isPlayed = false;
    await audioPlayer.pause();
    notifyListeners();
  }

  void play() {
    this.isPlayed = true;
    this.isPaused = false;
    audioPlayer.play();
    notifyListeners();
  }

  Future stop() async {
    await this.audioPlayer.stop();
    this.isPlayed = false;
    this.isPaused = false;
    this.music = null;
    this.playlist = null;
    notifyListeners();
  }

  Future seek(Duration time) async {
    await audioPlayer.seek(time);
  }

  Future next(Users? user) async {
    List<int?> listIndexMusic = playlist!
        .asMap()
        .entries
        .map((m) => m.value.id == this.music!.id ? m.key : null)
        .toList()
        .cast<int?>();
    listIndexMusic.removeWhere((element) => element == null);
    Music music = playlist![(listIndexMusic.first! + 1) > (playlist!.length - 1)
        ? (listIndexMusic.length - 1)
        : (listIndexMusic.first! + 1)];
    await playSource(user, music, playlist!, sourceMusic!);
  }

  Future previous(Users? user) async {
    List<int?> listIndexMusic = playlist!
        .asMap()
        .entries
        .map((m) => m.value.id == this.music!.id ? m.key : null)
        .toList()
        .cast<int?>();
    listIndexMusic.removeWhere((element) => element == null);
    Music music = playlist![
        (listIndexMusic.first! - 1) < 0 ? 0 : (listIndexMusic.first! - 1)];
    await playSource(user, music, playlist!, sourceMusic!);
  }

  Future playSource(Users? user, Music music, List<Music> listMusic,
      SourceMusic source) async {
    this.music = music;
    this.isPaused = false;
    this.isPlayed = true;
    this.sourceMusic = source;
    this.playlist = listMusic;

    await audioPlayer.setUrl(music.url);
    await musicService.addRecentMusicPlayed(music, userId: user?.id);
    audioPlayer.play();

    notifyListeners();
  }
}

enum SourceMusic { artist, recommendation, recent, like, search }
