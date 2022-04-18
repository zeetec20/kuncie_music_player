import 'package:hive/hive.dart';
import 'package:kuncie/models/Music.dart';

part 'MusicLike.g.dart';

@HiveType(typeId: 1)
class MusicLike {
  MusicLike({
    required this.id,
    required this.artistId,
    required this.userId,
    required this.artist,
    required this.cover,
    required this.url,
    required this.title,
    required this.trackTimeMillis,
    required this.artistUrl,
  });

  @HiveField(1)
  int id;

  @HiveField(2)
  int artistId;

  @HiveField(3)
  String userId;

  @HiveField(4)
  String title;

  @HiveField(5)
  String artist;

  @HiveField(6)
  String cover;

  @HiveField(7)
  String url;

  @HiveField(8)
  String artistUrl;

  @HiveField(9)
  int trackTimeMillis;

  static MusicLike fromMusic(String userId, Music music) {
    return MusicLike(
        id: music.id,
        artistId: music.artistId,
        userId: userId,
        artist: music.artist,
        cover: music.cover,
        url: music.url,
        title: music.title,
        trackTimeMillis: music.trackTimeMillis,
        artistUrl: music.artistUrl);
  }

  Music toMusic() => Music(
      id, artistId, artist, cover, url, title, trackTimeMillis, artistUrl);
}
