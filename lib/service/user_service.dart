import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/models/MusicLike.dart';
import 'package:kuncie/repository/music_like_repository.dart';

class UserService {
  UserService(this.musicLikeRepository);
  final MusicLikeRepository musicLikeRepository;

  Future addLikeMusic(String userId, Music music) =>
      musicLikeRepository.create(MusicLike.fromMusic(userId, music));

  Future removeLikeMusic(String userId, Music music) =>
      musicLikeRepository.delete(MusicLike.fromMusic(userId, music));

  Future<ValueListenable<Box<MusicLike>>> listenLikeMusic() =>
      musicLikeRepository.listen();
}
