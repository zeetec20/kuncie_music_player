import 'package:flutter_test/flutter_test.dart';
import 'package:kuncie/models/Artist.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/repository/api_repository.dart';
import 'package:kuncie/repository/recent_music_played_repository.dart';
import 'package:kuncie/service/music_service.dart';

void main() {
  ApiRepository apiRepository = ApiRepository();
  RecentMusicPlayedRepository recentMusicPlayedRepository =
      RecentMusicPlayedRepository();
  MusicService musicService =
      MusicService(apiRepository, recentMusicPlayedRepository);

  group('search', () {
    test('search music failed', () async {
      List<Music> result = await musicService.search('');
      expect(result.isEmpty, isTrue);
    });

    test('search music success', () async {
      List<Music> result = await musicService.search('hindia');
      expect(result.isNotEmpty, isTrue);
    });
  });

  
}
