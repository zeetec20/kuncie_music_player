import 'package:flutter/cupertino.dart';
import 'package:kuncie/models/Music.dart';
import 'package:kuncie/ui/provider/music_provider.dart';
import 'package:provider/provider.dart';

class SearchProvider with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  List<Music> musics = [];

  Future searchMusic(BuildContext context) async {
    this.musics = await Provider.of<MusicProvider>(context, listen: false).search(searchController.text);
    notifyListeners();
  }
}
