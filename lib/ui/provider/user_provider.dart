import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/models/MusicLike.dart';
import 'package:kuncie/repository/music_like_repository.dart';
import 'package:kuncie/service/user_service.dart';

class UserProvider with ChangeNotifier {
  UserProvider(this.musicLikeRepository);

  MusicLikeRepository musicLikeRepository;
  late final UserService userService = UserService(musicLikeRepository);

  Future<ValueListenable<Box<MusicLike>>> listenLikeMusic() =>
      userService.listenLikeMusic();
  Future removeLikeMusic(String userId, Music music) =>
      userService.removeLikeMusic(userId, music);
}
