import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:kuncie/models/MusicLike.dart';

class MusicLikeRepository {
  Future<Box<MusicLike>> openMusicLikeBox() =>
      Hive.openBox<MusicLike>('music_like');

  Future<List<MusicLike>> findByUserId(String userId) async =>
      (await openMusicLikeBox())
          .values
          .where((element) => element.userId == userId)
          .toList();

  Future create(MusicLike musicLike) async =>
      (await openMusicLikeBox()).add(musicLike);

  Future delete(MusicLike musicLike) async {
    Box<MusicLike> box = await openMusicLikeBox();
    int id = box.values
        .toList()
        .asMap()
        .entries
        .where((element) =>
            element.value.id == musicLike.id &&
            element.value.userId == musicLike.userId)
        .first
        .key;
    await box.deleteAt(id);
  }

  Future<ValueListenable<Box<MusicLike>>> listen() async =>
      (await openMusicLikeBox()).listenable();
}
